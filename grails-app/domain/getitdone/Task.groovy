package getitdone

import java.util.concurrent.TimeUnit

/**
 * Task domain represents the unit of work. It consists of zero, one, or more {@link Work} logs.
 * @see {@link Work}
 */
class Task {

    public static final String TASK_STATUS_STARTED = 'started'
    public static final String TASK_STATUS_CREATED = 'created'
    public static final String TASK_STATUS_COMPLETED = 'completed'
    public static final String TASK_STATUS_ABORTED = 'aborted'
    //todo: blocked/pending state will be supported when approval workflow is available
//    public static final String TASK_STATUS_BLOCKED = 'blocked'
    public static final List LIST_TASK_STATUS = [TASK_STATUS_STARTED, TASK_STATUS_CREATED, TASK_STATUS_COMPLETED, TASK_STATUS_ABORTED]

    Date dateCreated
    Date lastUpdated

    String description

    String status //todo: add index on this column in BootStrap.groovy

//    User creator  //todo: might be needed when task lifecycle is tracked
    User assignee

    static hasMany = [workLogs: Work, comments: Comment]

    static constraints = {
        description blank: false, maxSize: 2048

        assignee nullable: true  // a task can be un-assigned

        status blank: false, inList: LIST_TASK_STATUS

        workflowState nullable: true
    }

    //fixme: for unknown reason, beforeInsert is not invoked before persistence, so beforeValidate is used here
    def beforeValidate() {
        if (!status) {
            status = TASK_STATUS_CREATED
        }
    }



    //todo: move all workflow supporting logic to dedicated trait

    // State -> Event -> Action (callback) hierarchy to model general proc-node-activity BPMN
    // This is essentially a simplified finite state machine

    /**
     *
     */
    static Map workflowMap = [
            CREATED: [  // key is the current state name
                    assign: 'ASSIGNED'  // key is event name, value is transition-to state name
            ],
            ASSIGNED: [
                    submit: 'UNDER_REVIEW'
            ],
            'UNDER_REVIEW': [
                    approve: 'APPROVED',
                    reject: 'REJECTED'
            ],
            APPROVED: null,  // an end state that has no transition mapping
            REJECTED: [
                    reAssign: 'ASSIGNED'
            ]
    ]

    String workflowState = 'CREATED'  // current initial state

    /**
     * validates workflow map definition
     */
    static boolean isWorkflowMapValid() {
        // check source states set and transition-to states set match each other
        def states = workflowMap.keySet()
        Set<String> transToStates = new HashSet<>()
        workflowMap.values().each { Map m ->
            if (m) {  // m could be null or empty for dead-end state
                transToStates.addAll(m.values())
            }
        }
        return states == (transToStates + ['CREATED'])  // groovy set operators are awesome
    }

    static List<String> getWorkflowEvents() {
//        Set<String> events = new HashSet<>()
        return workflowMap.values().inject(new HashSet<String>()) { Set<String> result, Map m -> result.addAll(m.keySet()) }
    }

    static Set<String> getWorkflowStates() {
        return workflowMap.keySet()
    }

    // by default, if an instance method is defined with same name as event name, then it is an event callback

    /**
     * before-event callback
     */
    void beforeAssign() {
        log.info ">> callback before event assign, user $assignee is to be assigned to this task"
        //todo: can hook some sync or async logic
    }

    /**
     * after-event callback
     */
    void afterAssign() {
        log.info ">> callback after event assign, user $assignee has been assigned to this task"
    }

    /**
     * on-state callback, typically registers some automated processing logic on this state
     */
    void onASSIGNED() {
        log.info "on state: $workflowState, assignee $assignee is working on this task ..."
        3.times {
            TimeUnit.SECONDS.sleep(1)
            log.info "  ... still working ..."
        }
        log.info "  ... finished! now submitting"
        this.receiveEvent('submit')
    }

    void beforeSubmit() {
        log.info ">> callback before submit event, are you sure to submit?  .. OK, I guess you mean it"
    }

    void afterSubmit() {
        log.info ">> callback after submit event, now it is too late if you regret..."
    }


    void onUNDER_REVIEW() {
        log.info "on state: $workflowState, someone is reviewing your submission"
    }


    // ** utility methods that should go to traits **

    //todo: need to add state tracking persistence for each state transition

    void receiveEvent(String event) {
        if (!validateEvent(event)) {
            return
        }

        // on-event callback is in-thread, sync execution with event call
        def beforeEventCallbackName = "on${event.capitalize()}".toString()
        if (this.metaClass.respondsTo(this, beforeEventCallbackName)) {
            log.debug "this is before-event callback for event: $event on current state: $workflowState"
            this."$beforeEventCallbackName"()  // if exception the call stack will error out, this is intended
        }

        // transition state
        if (!transitionState(event)) {
            log.warn "state transition error"
            return
        }

        // after-event callback
        def afterEventCallbackName = "after${event.capitalize()}".toString()
        if (this.metaClass.respondsTo(this, afterEventCallbackName)) {
            log.debug "this is after-event callback for event: $event on transitioned state: $workflowState"
            this."$afterEventCallbackName"()
        }

        // on state callback
        def onStateCallbackName = "on${workflowState}".toString()
        if (this.metaClass.respondsTo(this, onStateCallbackName)) {
            log.debug "this is on-state callback on state: $workflowState"
            this."$onStateCallbackName"()
        }

    }

    boolean transitionState(String event, Map options = [:]) {
        this.withTransaction {
            String origState = workflowState
            String transToState = getTransitionToState(event)
            if (!transToState) {
                log.warn "can not find transition-to state for event $event on current state: $origState, transition aborted"
                return false
            }

            log.debug "transitioning state: $origState => $transToState"
            this.workflowState = transToState
            return this.save(flush: true)  // state change should be synced to db by immediate session flush
        }
    }

    String getTransitionToState(String event) {
        Map currentStateMap = getWorkflowState(workflowState)
        return currentStateMap?.get(event)
    }

    Set<String> getAcceptableEvents() {
        Map currentStateMap = getWorkflowState(workflowState)
        return currentStateMap?.keySet()
    }

    boolean validateEvent(String event) {
        //todo: do more checks
        return canReceiveEvent(event)
    }

    boolean canReceiveEvent(String event) {
        Map currentStateMap = workflowMap.get(workflowState)
        if (currentStateMap?.keySet().contains(event)) {
            return true
        }
        return false
    }

    static def getWorkflowState(String stateKey) {
        workflowMap[stateKey]
    }

}
