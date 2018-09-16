package getitdone

import grails.gorm.transactions.Transactional

@Transactional
class WorkDataService {

    List<Work> list(Map params) {
        return Work.list(params + [fetch: [worker: 'join', task: 'join']])
    }

    Work get(Serializable id) {
        return Work.findById(id, [fetch: [worker: 'join', task: 'join']])
    }

    /**
     *
     */
    List<Work> trackWork(Map params) {
        //todo: need to eager fetch user and task into the list to avoid N+1 queries
        //todo: support pagination
        def taskList = Work.where {
            if (params.workDate) {
                workDate == params.workDate
            } else {
                if (params.workDateStart) {
                    workDate >= params.workDateStart
                }
                if (params.workDateEnd) {
                    workDate <= params.workDateEnd
                }
            }

            if (params.worker) {
                worker == params.worker
            }
        }.list()

        return taskList
    }
}
