package getitdone

import grails.events.annotation.Subscriber

//@Transactional
class EmailSendService {

    @Subscriber('eventTaskAssigned')
    void onTaskAssigned(Map params) {
        log.info "sending email with params: $params"
        try {
            User assignee = params.assignee

            // Grails email plugin adds SendMail trait to both controller and service classes
            sendMail {
                to assignee.email
                subject "You have been assigned to a task"
//                text buildEmailText(params)
                html buildEmailHtml(params)
//                html view: '/emailSend/template', model: params
            }
        } catch (ex) {
            log.error ex.message, ex
        }
    }

    String buildEmailText(Map params) {
        """
Dear ${params.assignee.firstName ?: ''} ${params.assignee.middleName ?: ''} ${params.assignee.lastName ?: ''} (${params.assignee.email}),

You have been recently assigned to a Task: 
ID: ${params.task.id} 

Description:
${params.task.description.encodeAsRaw()}

URL:
${params.taskUrl}

The time of assignment is ${params.task.lastUpdated.format('yyyy-MM-dd HH:mm:ss')}.

Your sincere GetItDone assistant,
sprt4getitdone@gmail.com
${new Date().format('yyyy-MM-dd HH:mm:ss')}
"""
    }

    String buildEmailHtml(Map params) {
        """<!doctype html><html>
<head></head>
<body>
<p>
Hey ${params.assignee.firstName ?: ''} ${params.assignee.middleName ?: ''} ${params.assignee.lastName ?: ''} (${params.assignee.email}),
</p>
<br/>
<p>
You've been recently assigned a Task: ${params.task.id}. 
</p>

<h4>Description:</h4>
<p>
${params.task.description.encodeAsRaw()}
</p>

<h4>Task URL:</h4>
${params.taskUrl}

<h4>Time of assignment: </h4>
${params.task.lastUpdated.format('yyyy-MM-dd HH:mm:ss')}

<br/><br/>

<div>
Your sincere <span style="color:orange"><em>Get-It-Done</em></span> assistant,
<br/>
sprt4getitdone@gmail.com
<br/>
${new Date().format('yyyy-MM-dd HH:mm:ss')}
</div>

</body>
</html>"""
    }


}
