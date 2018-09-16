package getitdone

import grails.gorm.transactions.Transactional

@Transactional
class TaskDataService {

    /**
     * List tasks with eager-fetched assignees
     */
    List<Task> listWithAssignee(Map params) {
        return Task.list(params + [fetch: [assignee: 'join']])
    }

    List<Task> listNotEnded(Map params) {
        return Task.findAll(params) {
            status != Task.TASK_STATUS_COMPLETED && status != Task.TASK_STATUS_ABORTED
        }
    }

}
