<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'work.label', default: 'Work')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#show-work" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="show-work" class="content scaffold-show" role="main">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            %{--<f:display bean="work" />--}%

            <ol class="property-list task">
                <li class="fieldcontain">
                    <span id="worker-label" class="property-label">Worker</span>
                    <div class="property-value" aria-labelledby="worker-label">
                        ${this.work.worker.email}
                    </div>
                </li>
                <li class="fieldcontain">
                    <span id="task-label" class="property-label">Task</span>
                    <div class="property-value" aria-labelledby="task-label">
                        ${this.work.task.description}
                    </div>
                </li>
                <li class="fieldcontain">
                    <span id="timeSpent-label" class="property-label">Time Spent</span>
                    <div class="property-value" aria-labelledby="timeSpent-label">
                        ${this.work.timeSpent} ${this.work.timeSpentUnit}
                        <g:if test="${this.work.timeSpentUnit == getitdone.Work.TIME_UNIT_HOUR}">
                            ( ${this.work.timeSpentInMin} min )
                        </g:if>
                    </div>
                </li>
                <li class="fieldcontain">
                    <span id="workDate-label" class="property-label">Work Date</span>
                    <div class="property-value" aria-labelledby="workDate-label">
                        ${this.work.workDate?.format('YYYY-MM-dd')}
                    </div>
                </li>
            </ol>

            <g:form resource="${this.work}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="edit" action="edit" resource="${this.work}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
