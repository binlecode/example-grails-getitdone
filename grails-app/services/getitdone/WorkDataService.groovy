package getitdone

import grails.gorm.transactions.Transactional

import java.time.DayOfWeek
import java.time.LocalDate
import java.time.LocalTime
import java.time.ZoneId
import java.time.ZonedDateTime

import static java.time.temporal.TemporalAdjusters.previousOrSame

@Transactional
class WorkDataService {

    List<Work> list(Map params) {
        return Work.list(params + [fetch: [worker: 'join', task: 'join']])
    }

    Work get(Serializable id) {
        return Work.findById(id, [fetch: [worker: 'join', task: 'join']])
    }

    /**
     * @param dayInWeek  'yyyy-MM-dd'
     * @param weekDayStart beginning day of the week, default to sunday if not given
     * @return
     */
    Map getBeginEndDatesOfWeek(LocalDate dayInWeek, DayOfWeek weekDayStart = DayOfWeek.SUNDAY) {
        def firstDayOfWeek = dayInWeek.with(previousOrSame(weekDayStart))
        [
                dayBegin: firstDayOfWeek,
                dayEnd: firstDayOfWeek.plusDays(6)
        ]
    }

    /**
     * @param dateStr  'yyyy-MM-dd'
     * @return
     */
    Map getBeginEndDatesOfMonth(LocalDate dayInMonth) {
        def firstDayOfMonth = dayInMonth.withDayOfMonth(1) // first day of month
        return [
                monthDayBegin: firstDayOfMonth,
                monthDayEnd: firstDayOfMonth.plusDays(dayInMonth.lengthOfMonth() - 1)
        ]
    }

    /**
     * @param dateInWeek
     * @param weekDayStart defaut to sunday if not given
     * @return list of one week of {@link LocalDate} including input date
     */
    List getDatesOfWeek(LocalDate dateInWeek, DayOfWeek weekDayStart = DayOfWeek.SUNDAY) {
        def firstDayOfWeek = dateInWeek.with(previousOrSame(weekDayStart))
        return (0..6).collect { firstDayOfWeek.plusDays(it) }
    }

    /**
     * @param dateInMonth
     * @return list of one month of {@link LocalDate} including input date
     */
    List getDatesOfMonth(LocalDate dateInMonth) {
        def firstDayOfMonth = dateInMonth.withDayOfMonth(1) // first day of month
        return (0..(dateInMonth.lengthOfMonth() - 1)).collect { firstDayOfMonth.plusDays(it) }
    }

    /**
     * @param worker
     * @param clientLocalDateStr 'yyyy-MM-dd'
     */
    Map trackWorkForWeek(User worker, String clientLocalDateStr) {
        LocalDate clientLocalDate = LocalDate.parse(clientLocalDateStr)
        List<LocalDate> clientDateRange = getDatesOfWeek(clientLocalDate)
        List<Work> workList = getWorkList(worker, clientDateRange[0], clientDateRange[-1])
        [
                workDateRange: clientDateRange,
                workList: workList
        ]
    }

    /**
     * @param worker
     * @param clientLocalDateStr 'yyyy-MM-dd'
     */
    Map trackWorkForMonth(User worker, String clientLocalDateStr) {
        LocalDate clientLocalDate = LocalDate.parse(clientLocalDateStr)
        List<LocalDate> clientDateRange = getDatesOfMonth(clientLocalDate)
        [
                workDateRange: clientDateRange,
                workList: getWorkList(worker, clientDateRange[0], clientDateRange[-1])
        ]
    }

    //todo: support team level filtering, aka group of workers
    //todo: support pagination (or not, need a decision)
    /**
     * Get list of work logs by matching to begin and end local dates.
     * Note the local dates value are at day level, no time portion, no timezone offset
     * @param worker
     * @param dateBegin
     * @param dateEnd
     * @return
     */
    List<Work> getWorkList(User worker, LocalDate dateBegin, LocalDate dateEnd = null) {
        def workList = Work.where {
            if (worker) {
                worker == (worker)
            }
            if (!dateEnd) {
                workDate == java.sql.Date.valueOf(dateBegin)
            } else {
                workDate >= java.sql.Date.valueOf(dateBegin) && workDate <= java.sql.Date.valueOf(dateEnd)
            }
        }.list()
        return workList
    }

    /**
     * @param localDateStr ISO date format 'yyyy-MM-dd'
     * @return {@link LocalDate} instance, aka a date value without time zone offset info
     */
    LocalDate parseLocalDate(String localDateStr) {
        assert localDateStr ==~ /^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$/
        // this is for exact match yyyy-MM-dd
        //assert cleintDate ==~ /^\d{4}\-(0[1-9]|1[012])\-(0[1-9]|[12][0-9]|3[01])$/
        return LocalDate.parse(localDateStr)
    }

    /**
     * Converts local date to zoned date time with given time zone.
     * Local date has no time zone or time portion value.
     * Zoned dateTime contains absolute instant time so that it can be compared to other datetime values.
     * @param localDate
     * @param zoneId
     */
    ZonedDateTime getZonedDateTimeFromLocalDate(LocalDate localDate, ZoneId zoneId = null) {
        // note adding 0:0 time portion, which is the same as clientDate.atStartOfDay()
        ZonedDateTime.of(localDate, LocalTime.of(0, 0), zoneId ?: ZoneId.systemDefault())
    }


}
