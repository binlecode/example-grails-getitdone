package getitdone

import grails.validation.ValidationException
import java.time.LocalDate
import static org.springframework.http.HttpStatus.*

class WorkController {

    TaskDataService taskDataService
    UserService userService
    WorkService workService
    WorkDataService workDataService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    //todo: implement pagination support to this action
    //todo: add work log stats such as total time spent for each day
    def timeSheet() {

        if (params.showNextWeek) {
            params.clientDate = LocalDate.parse(params.currentWeekDateBegin).plusDays(7).toString()
        } else if (params.showLastWeek) {
            params.clientDate = LocalDate.parse(params.currentWeekDateBegin).minusDays(7)
        } else {
            // by default the date range is current week
            params.clientDate = params.clientDate ?: LocalDate.now().toString() // '2018-09-10'
        }

        Map workTrack = workDataService.trackWorkForWeek(params.worker as User, params.clientDate as String)
        Map workStats = workDataService.trackWorkStats(workTrack.workList)
        render view: 'timeSheet', model: [workDateRange: workTrack.workDateRange, workList: workTrack.workList, workStats: workStats]
    }

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
//        respond workService.listWithAssignee(params), model:[workCount: workService.count()]
        respond workDataService.list(params), model:[workCount: workService.count()]
    }

    def show(Long id) {
//        respond workService.get(id)
        respond workDataService.get(id)  // use workDataService for eager fetch of worker and task
    }

    def create() {
        respond new Work(params), model: [workerList: userService.list(), taskList: taskDataService.listNotEnded()]
    }

    def save(Work work) {
        if (work == null) {
            notFound()
            return
        }

        try {
            workService.save(work)
        } catch (ValidationException e) {
            respond work.errors, view:'create', model: [workerList: userService.list(), taskList: taskDataService.listNotEnded()]
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'work.label', default: 'Work'), work.id])
                redirect work
            }
            '*' { respond work, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond workService.get(id), model: [workerList: userService.list(), taskList: taskDataService.listNotEnded()]
    }

    def update(Work work) {
        if (work == null) {
            notFound()
            return
        }

        try {
            workService.save(work)
        } catch (ValidationException e) {
            respond work.errors, view:'edit', model: [workerList: userService.list(), taskList: taskDataService.listNotEnded()]
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'work.label', default: 'Work'), work.id])
                redirect work
            }
            '*'{ respond work, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        workService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'work.label', default: 'Work'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'work.label', default: 'Work'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
