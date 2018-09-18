<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'task.label', default: 'Task')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#show-task" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                %{--<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--}%
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="show-task" class="content scaffold-show" role="main">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <ol class="property-list task">
                <li class="fieldcontain">
                    <span id="descriptoin-label" class="property-label">Description</span>
                    <div class="property-value" aria-labelledby="description-label">
                        ${this.task.description.encodeAsRaw()}
                    </div>
                </li>
                <li class="fieldcontain">
                    <span id="assignee-label" class="property-label">Assignee</span>
                    <div class="property-value" aria-labelledby="assignee-label">
                        <g:link controller="user" action="show" id="${this.task.assigneeId}">
                        ${this.task.assignee.email}
                        </g:link>
                    </div>
                </li>
                <li class="fieldcontain">
                    <span id="status-label" class="property-label">Status</span>
                    <div class="property-value" aria-labelledby="status-label">
                        ${this.task.status}
                    </div>
                </li>
                <li class="fieldcontain">
                    <span id="work-label" class="property-label">Work Logs</span>
                    <div class="property-value" aria-labelledby="work-label">
                        <ul>
                            <g:each in="${this.task.workLogs.sort {it.lastUpdated ?: it.dateCreated}.reverse()}" var="work" status="j">
                                <li>
                                    <g:link method="GET" controller="work" action="show" params="[id: work.id]">
                                        ${work.timeSpent} ${work.timeSpentUnit}
                                    </g:link>
                                    [on ${work.workDate.format('yyyy-MM-dd')} by ${work.worker.email}]
                                </li>
                            </g:each>
                        </ul>
                    </div>
                </li>
            </ol>
            %{--<f:display bean="task" />--}%
            <g:form resource="${this.task}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="edit" action="edit" resource="${this.task}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />

                    <g:link class="edit" controller="work"  action="create" params="['task.id': this.task.id, 'worker.id': this.task.assigneeId]">
                        <g:message code="default.button.logWork.label" default="Log Work" />
                    </g:link>

                </fieldset>
            </g:form>
        </div>
    </body>
</html>
