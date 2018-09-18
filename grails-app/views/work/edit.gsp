<%@ page import="getitdone.Task" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'work.label', default: 'Work')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#edit-work" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                %{--<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--}%
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="edit-work" class="content scaffold-edit" role="main">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
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
            <g:form resource="${this.work}" method="PUT">
                <g:hiddenField name="version" value="${this.work?.version}" />
                <fieldset class="form">
                    %{--<f:all bean="work"/>--}%

                    <div class="fieldcontain required">
                        <label for="worker">
                            Worker
                            <span class="required-indicator">*</span>
                        </label>
                        <g:select name="worker.id" id="worker" required="" from="${this.workerList}" optionKey="id" optionValue="email"
                                value="${this.work.workerId}" />
                    </div>
                    <div class="fieldcontain required">
                        <label for="task">
                            Task
                            <span class="required-indicator">*</span>
                        </label>
                        <g:select name="task.id" id="task" required=""
                                  from="${this.taskList.collect{[id: it.id, description: it.description.encodeAsRaw()]} }"
                                  optionKey="id" optionValue="description"
                                  value="${this.work.taskId}" />
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
                            %{--<span class="required-indicator">*</span>--}%
                        </label>

                        <g:select name="timeSpentUnit" id="timeSpentUnit" from="${getitdone.Work.LIST_TIME_UNIT}"
                                value="${this.work.timeSpentUnit}" />
                    </div>

                    <div class="fieldcontain required">
                        <label for="workDate">
                            Work Date
                            <span class="required-indicator">*</span>
                        </label>
                        <g:datePicker name="workDate" id="workDate" precision="day" years="${Calendar.getInstance().get(Calendar.YEAR) .. 2099}"
                                value="${this.work.workDate}" />
                    </div>

                </fieldset>
                <fieldset class="buttons">
                    <input class="save" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
