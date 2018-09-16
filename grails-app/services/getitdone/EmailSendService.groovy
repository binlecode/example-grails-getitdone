package getitdone

import grails.events.annotation.Subscriber

//@Transactional
class EmailSendService {

    @Subscriber('eventTaskSaved')
    def onTaskSaved(Map params) {
        log.info "sending email with params: $params"
        try {
            Task task = params.task
            User assignee = params.assignee

            // Grails email plugin adds SendMail trait to both controller and service classes
            sendMail {
                to assignee.email
                subject "You have been assigned to a task"
                text """
Dear ${assignee.firstName ?: ''} ${assignee.middleName ?: ''} ${assignee.lastName ?: ''} (${assignee.email}),

You have been recently assigned to a Task: 
ID: ${task.id} 

Description:
${task.description}

URL:
${params.taskUrl}

The time of assignment is ${task.lastUpdated.format('yyyy-MM-dd HH:mm:ss')}.

Your sincere GetItDone assistant,
sprt4getitdone@gmail.com

"""
//            html view: '/emailSend/template', model: params
            }
        } catch (ex) {
            log.error ex.message, ex
        }
    }


}
