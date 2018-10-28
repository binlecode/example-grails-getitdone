package getitdone

import org.apache.commons.lang.time.DateUtils

import java.time.LocalDate
import java.time.ZoneId

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
    /**
     * the date of the work log
     * Note the value is always at day level, aka, no time portion or timeZone offset
     */
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

    /**
     * Truncate workDate (type {@link java.util.Date}) to {@link java.time.LocalDate} by only taking the day portion.
     *
     * java.util.Date represents an instant on the time-line, not a "date", the equivalent class to java.util.Date
     * in JSR-310 is {@link java.time.Instant}.
     * A typical way to convert Date to LocalDate is:
     * date.toInstance().atZone(...).toLocalDateTime() or date.toInstance().atZone(...).toLocalDate()
     *
     * For workDate, we simply need to get the day value since it is saved for day value use only.
     * Therefore, we put zero time zone offset (UTC).
     */
    LocalDate getLocalWorkDate() {
        workDate.toInstant().atZone(ZoneId.of('UTC')).toLocalDate()
    }

    /**
     * Intercept timeSpent setter to support 2-decimal rounding
     * @param timeSpent
     */
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
