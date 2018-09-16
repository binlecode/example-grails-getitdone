package getitdone

import grails.gorm.services.Service

@Service(Work)
interface WorkService {

    Work get(Serializable id)

    List<Work> list(Map args)

    Long count()

    void delete(Serializable id)

    Work save(Work work)

}