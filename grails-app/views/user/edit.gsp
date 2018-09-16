<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#edit-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="edit-user" class="content scaffold-edit" role="main">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.user}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.user}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <g:form resource="${this.user}" method="PUT">
                <g:hiddenField name="version" value="${this.user?.version}" />
                <fieldset class="form">
                    %{--<f:all bean="user"/>--}%

                    <div class="fieldcontain">
                        <label for="firstName">First Name</label>
                        <g:field type="text" id="firstName" name="firstName" value="${this.user.firstName}"/>
                    </div>
                    <div class="fieldcontain">
                        <label for="middleName">Middle Name</label>
                        <g:field type="text" id="middleName" name="middleName" value="${this.user.middleName}"/>
                    </div>
                    <div class="fieldcontain">
                        <label for="lastName">Last Name</label>
                        <g:field type="text" id="lastName" name="lastName" value="${this.user.lastName}"/>
                    </div>
                    <div class="fieldcontain required">
                        <label for="email">
                            Email
                            <span class="required-indicator">*</span>
                        </label>
                        <g:field type="text" id="email" name="email" value="${this.user.email}"/>
                    </div>

                    <div class="fieldcontain">
                        <label>
                            Assigned Tasks Count
                        </label>
                        <span class="badge">
                            ${this.userTaskCount}
                        </span>
                    </div>

                </fieldset>
                <fieldset class="buttons">
                    <input class="save" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
