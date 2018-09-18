package getitdone

class Task {

    public static final String TASK_STATUS_STARTED = 'started'
    public static final String TASK_STATUS_CREATED = 'created'
    public static final String TASK_STATUS_COMPLETED = 'completed'
    public static final String TASK_STATUS_ABORTED = 'aborted'
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
    }

    //fixme: for unknown reason, beforeInsert is not invoked before persistence, so beforeValidate is used here
    def beforeValidate() {
        if (!status) {
            status = TASK_STATUS_CREATED
        }
    }
}
