package getitdone

import grails.events.EventPublisher
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class TaskController implements EventPublisher {

    TaskService taskService
    TaskDataService taskDataService
    UserService userService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        // apply default sorting
        if (!params.sort) {
            params.sort = 'lastUpdated'
            params.order = 'desc'
        }
        // taskService.listWithAssignee() vs taskCrudService.listWithAssignee() to show N+1 case
//        respond taskService.listWithAssignee(params), model:[taskCount: taskService.count()]
        respond taskDataService.listWithAssignee(params), model:[taskCount: taskService.count()]
    }

    def show(Long id) {
        respond taskService.get(id)
    }

    def create() {
        respond new Task(params), model: [userList: userService.list()]
    }

    def save(Task task) {
        if (task == null) {
            notFound()
            return
        }

        try {
            taskService.save(task)
        } catch (ValidationException e) {
            respond task.errors, view:'create', model: [userList: userService.list()]
            return
        }

        // at this point task has been successfully assigned
        notify("eventTaskSaved", [task: task, assignee: task.assignee,
                taskUrl: g.createLink(controller: 'task', action: 'show', id: task.id, absolute: true).encodeAsHTML()
        ])

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'task.label', default: 'Task'), task.id])
                redirect task
            }
            '*' { respond task, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond taskService.get(id), model: [userList: userService.list()]
    }

    def update(Task task) {
        if (task == null) {
            notFound()
            return
        }

        try {
            taskService.save(task)
        } catch (ValidationException e) {
            respond task.errors, view:'edit', model: [userList: userService.list()]
            return
        }

        // at this point task has been successfully assigned
        notify("eventTaskSaved", [task: task, assignee: task.assignee,
                taskUrl: g.createLink(controller: 'task', action: 'show', id: task.id, absolute: true).encodeAsHTML()
        ])

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'task.label', default: 'Task'), task.id])
                redirect task
            }
            '*'{ respond task, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        taskService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'task.label', default: 'Task'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'task.label', default: 'Task'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
