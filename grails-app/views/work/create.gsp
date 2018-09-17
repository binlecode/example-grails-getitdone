<%@ page import="getitdone.Work" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'work.label', default: 'Work')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#create-work" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                %{--<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--}%
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="create-work" class="content scaffold-create" role="main">
            <h1><g:message code="default.logWork.label" args="[entityName]" default="Log Work" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.work}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.work}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <g:form resource="${this.work}" method="POST">
                <fieldset class="form">
                    %{--<f:all bean="work"/>--}%

                    <div class="fieldcontain required">
                        <label for="worker">
                            Worker
                            <span class="required-indicator">*</span>
                        </label>
                        <g:select name="worker.id" id="worker" required="" from="${this.workerList}" optionKey="id" optionValue="email"
                                value="${this.work.workerId}"/>
                    </div>
                    <div class="fieldcontain required">
                        <label for="task">
                            Task
                            <span class="required-indicator">*</span>
                        </label>
                        <g:select name="task.id" id="task" required="" from="${this.taskList}" optionKey="id" optionValue="description"
                                value="${this.work.taskId}"/>
                    </div>

                    <div class="fieldcontain required">
                        <label for="timeSpent">
                            Time Spent
                            <span class="required-indicator">*</span>
                        </label>
                        <g:field type="text" id="timeSpent" name="timeSpent" required="" value="${this.work.timeSpent}"/>
                    </div>
                    <div class="fieldcontain required">
                        <label for="timeSpentUnit">
                            Time Unit
                        </label>
                        <g:select name="timeSpentUnit" id="timeSpentUnit" from="${getitdone.Work.LIST_TIME_UNIT}" />
                    </div>

                    <div class="fieldcontain required">
                        <label for="workDate">
                            Work Date
                            <span class="required-indicator">*</span>
                        </label>
                        <g:datePicker name="workDate" id="workDate" precision="day" years="${Calendar.getInstance().get(Calendar.YEAR) .. 2099}" />
                    </div>

                </fieldset>
                <fieldset class="buttons">
                    <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
