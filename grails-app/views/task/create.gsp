<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'task.label', default: 'Task')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#create-task" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                %{--<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--}%
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="create-task" class="content scaffold-create" role="main">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
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
            <g:form resource="${this.task}" method="POST">
                <fieldset class="form">
                    <div class="fieldcontain required">
                        <label for="description">
                            Description
                            <span class="required-indicator">*</span>
                        </label>
                        %{--<g:textArea id="description" name="description" rows="3" placeholder="task description" required=""--}%
                                    %{--maxlength="2048"/>--}%

                        <!-- Include stylesheet for QuillJS editor -->
                        <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
                        <!-- Create the editor container -->
                        <input type="hidden" id="description" name="description" />
                        <div id="editor-container">
                        </div>
                    </div>
                    <div class="fieldcontain">
                        <label for="assignee">
                            Assignee
                        </label>
                        <g:select name="assignee.id" id="assignee" from="${this.userList}"
                                  optionKey="id" optionValue="email"
                                  noSelection="['':'Assign task to:']"/>
                    </div>
                </fieldset>
                <fieldset class="buttons">
                    <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                </fieldset>
            </g:form>
        </div>

        <g:render template="quilljs_integration" />
    </body>
</html>
