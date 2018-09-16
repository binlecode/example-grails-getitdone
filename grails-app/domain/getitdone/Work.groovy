package getitdone

/**
 * Work is the time tracking log for a given user spent on a given task.
 */
class Work {
    public static final String TIME_UNIT_HOUR = 'hr'
    public static final String TIME_UNIT_MINUTE = 'min'
    public static final List LIST_TIME_UNIT = [TIME_UNIT_HOUR, TIME_UNIT_MINUTE]

    Date dateCreated
    Date lastUpdated

    Float timeSpent
    String timeSpentUnit  // hour, min
    Float timeSpentInMin  // regulated to number of minutes
    /** the date of the work */
    Date workDate  //todo: must add db index on this column

    User worker
    Task task

    static belongsTo = [task: Task, worker: User]

    static constraints = {
        timeSpentUnit inList: LIST_TIME_UNIT
        // use improved custom validator dsl by Grails 3.3: https://docs.grails.org/latest/ref/Constraints/validator.html
        timeSpent validator: { Float val, Work obj ->
            if (val <= 0) {
                return ['valueZeroOrNegative', val.toString()]
            }
            if (obj.timeSpentUnit == TIME_UNIT_HOUR && val >= 24) {
                return ['valueTooLargeForHour', val.toString()]
            }
            if (obj.timeSpentUnit == TIME_UNIT_MINUTE && val >= 60) {
                return ['valueTooLargeForMin', val.toString()]
            }
        }
    }


    void setTimeSpent(Float timeSpent) {
        this.timeSpent = timeSpent?.round(2)  // round to at most 2 decimal resolution
    }

    def beforeValidate() {
        calculateTimeSpentInMin()
        if (!workDate) {
            setDefaultWorkDate()
        }
    }

    //fixme: not why beforeInsert and beforeValidate are not invoked prior to save
//    def beforeInsert() {
//        calculateTimeSpentInMin()
//    }
//    def beforeUpdate() {
//        calculateTimeSpentInMin()
//    }

    private calculateTimeSpentInMin() {
        if (timeSpentUnit == TIME_UNIT_MINUTE) {
            timeSpentInMin = timeSpent
        } else if (timeSpentUnit == TIME_UNIT_HOUR) {
            timeSpentInMin = (timeSpent * 60F).round(2)
        }
    }

    private setDefaultWorkDate() {
        workDate = new Date()
    }
}
