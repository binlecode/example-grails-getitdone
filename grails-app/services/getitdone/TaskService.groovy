package getitdone

import grails.gorm.services.Service

@Service(Task)
interface TaskService {

    Task get(Serializable id)

    //todo: customize list method to eager fetch assignees
    List<Task> list(Map args)

    Long count()

    Long countByAssignee(User assignee)

    void delete(Serializable id)

    Task save(Task task)

}