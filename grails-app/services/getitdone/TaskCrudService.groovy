package getitdone

import grails.gorm.transactions.Transactional

@Transactional
class TaskCrudService {

    /**
     * List tasks with eager-fetched assignees
     */
    List<Task> list(Map params) {
        return Task.list(params + [fetch: [assignee: 'join']])
    }


}
