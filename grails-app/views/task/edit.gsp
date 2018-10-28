<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'task.label', default: 'Task')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#edit-task" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                %{--<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--}%
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="edit-task" class="content scaffold-edit" role="main">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.task}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.task}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <g:form resource="${this.task}" method="PUT">
                <g:hiddenField name="version" value="${this.task?.version}" />
                <fieldset class="form">
                    <div class="fieldcontain required">
                        <label for="description">
                            Description
                            <span class="required-indicator">*</span>
                        </label>
                        %{--<g:textArea id="description" name="description" rows="3" placeholder="task description" required=""--}%
                                    %{--maxlength="2048" value="${this.task.description}" />--}%
                        %{-- Use QuillJS rich text editor for description --}%
                        <!-- Include stylesheet for QuillJS editor -->
                        <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
                        <!-- Create the editor container -->
                        <input type="hidden" id="description" name="description" value="${this.task.description}" />
                        <div id="editor-container">
                            ${this.task.description.encodeAsRaw()}
                        </div>
                    </div>
                    <div class="fieldcontain">
                        <label for="assignee">
                            Assignee
                        </label>
                        <g:select name="assignee.id" id="assignee" from="${this.userList}"
                                  optionKey="id" optionValue="email"
                                  value="${this.task.assigneeId}"
                                  noSelection="['':'Assign task to:']"/>
                    </div>
                    <div class="fieldcontain required">
                        <label for="status">
                            Status
                            <span class="required-indicator">*</span>
                        </label>
                        %{--<g:field type="text" id="status" name="status" required="" value="${this.task.status}"/>--}%
                        <g:select name="status" from="${getitdone.Task.LIST_TASK_STATUS}" value="${this.task.status}" />
                    </div>

                    %{--<f:all bean="task"/>--}%
                </fieldset>
                <fieldset class="buttons">
                    <input class="save" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </fieldset>
            </g:form>
        </div>

        <g:render template="quilljs_integration" />
    </body>
</html>
