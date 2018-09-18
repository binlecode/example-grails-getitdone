<%@ page import="getitdone.Task" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#show-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                %{--<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--}%
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="show-user" class="content scaffold-show" role="main">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            %{--<f:display bean="user" />--}%

            <ol class="property-list user">
                <li class="fieldcontain">
                    <span id="firstName-label" class="property-label">First Name</span>
                    <div class="property-value" aria-labelledby="firstName-label">
                        <f:display bean="${this.user}" property="firstName"  displayStyle="table" theme="${theme}"/>
                    </div>
                </li>
                <g:if test="${this.user.middleName}">
                <li class="fieldcontain">
                    <span id="middleName-label" class="property-label">Middle Name</span>
                    <div class="property-value" aria-labelledby="middleName-label">
                        <f:display bean="${this.user}" property="middleName"  displayStyle="table" theme="${theme}"/>
                    </div>
                </li>
                </g:if>
                <li class="fieldcontain">
                    <span id="lastName-label" class="property-label">Last Name</span>
                    <div class="property-value" aria-labelledby="lastName-label">
                        <f:display bean="${this.user}" property="lastName"  displayStyle="table" theme="${theme}"/>
                    </div>
                </li>
                <li class="fieldcontain">
                    <span id="email-label" class="property-label">Email</span>
                    <div class="property-value" aria-labelledby="email-label">
                        <f:display bean="${this.user}" property="email"  displayStyle="table" theme="${theme}"/>
                    </div>
                </li>
                <li class="fieldcontain">
                    <span id="tasks-label" class="property-label">Assigned Tasks</span>
                    <div class="property-value" aria-labelledby="tasks-label">
                        <ul class="list-unstyled">
                            <g:each in="${this.user.tasks.findAll {
                                it.status != Task.TASK_STATUS_COMPLETED && it.status != Task.TASK_STATUS_ABORTED
                            }.sort {it.lastUpdated ?: it.dateCreated}.reverse()}" var="task" status="j">
                                <li class="task-description">
                                    <div>
                                    <g:link style="text-decoration: none" method="GET" controller="task" action="show" params="[id: task.id]">
                                        ${task.description.encodeAsRaw()}
                                    </g:link>
                                    <span class="badge ${task.status == 'created' ? 'badge-info' : 'badge-primary'}">
                                    ${task.status}
                                    </span> at ${task.lastUpdated ?: task.dateCreated}
                                    </div>
                                </li>
                            </g:each>
                        </ul>
                    </div>
                </li>
                <li class="fieldcontain">
                    <span id="ended-tasks-label" class="property-label">Ended Tasks</span>
                    <div class="property-value" aria-labelledby="ended-tasks-label">
                        <ul class="list-unstyled">
                            <g:each in="${this.user.tasks.findAll {
                                it.status == Task.TASK_STATUS_COMPLETED || it.status == Task.TASK_STATUS_ABORTED
                            }.sort {it.lastUpdated ?: it.dateCreated}.reverse()}" var="task" status="k">
                                <li class="task-description">
                                    <div>
                                    <g:link method="GET" controller="task" action="show" params="[id: task.id]">
                                        ${task.description.encodeAsRaw()}
                                    </g:link>
                                    <span class="badge ${task.status == 'completed' ? 'badge-success' : 'badge-warning'}">
                                        ${task.status}
                                    </span> at ${task.lastUpdated ?: task.dateCreated}
                                    </div>
                                </li>
                            </g:each>
                        </ul>
                    </div>
                </li>
            </ol>

            <g:form resource="${this.user}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="edit" action="edit" resource="${this.user}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
