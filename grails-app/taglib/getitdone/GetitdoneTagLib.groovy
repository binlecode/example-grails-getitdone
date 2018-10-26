package getitdone

class GetitdoneTagLib {
    static defaultEncodeAs = [taglib:'html']
    //static encodeAsForTags = [tagName: [taglib:'html'], otherTagName: [taglib:'none']]

    def resolveTaskStatusBadgeClass = { attrs, body ->
        switch (attrs.status) {
            case Task.TASK_STATUS_ABORTED:
                out << 'badge-warning'
                break
            case Task.TASK_STATUS_COMPLETED:
                out << 'badge-success'
                break
            case Task.TASK_STATUS_STARTED:
                out << 'badge-info'
                break
            case Task.TASK_STATUS_CREATED:
                out << 'badge-default'
                break
            default:
                out << 'badge-default'
                break
        }
    }

}
