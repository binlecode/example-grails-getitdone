<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#list-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="list-user" class="content scaffold-list" role="main">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <f:table collection="${userList}" properties="['email', 'firstName', 'lastName', 'middleName', 'dateCreated', 'lastUpdated']"/>

            %{--<table>--}%
                %{--<thead>--}%
                %{--<tr>--}%
                    %{--<g:each in="${domainProperties}" var="p" status="i">--}%
                        %{--<g:sortableColumn property="${p.property}" title="${p.label}" />--}%
                    %{--</g:each>--}%
                %{--</tr>--}%
                %{--</thead>--}%
                %{--<tbody>--}%
                %{--<g:each in="${userList}" var="bean" status="i">--}%
                    %{--<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">--}%
                        %{----}%
                        %{----}%
                        %{--<g:each in="${domainProperties}" var="p" status="j">--}%
                            %{--<g:if test="${j==0}">--}%
                                %{--<td><g:link method="GET" resource="${bean}"><f:display bean="${bean}" property="${p.property}" displayStyle="${displayStyle?:'table'}" theme="${theme}"/></g:link></td>--}%
                            %{--</g:if>--}%
                            %{--<g:else>--}%
                                %{--<td><f:display bean="${bean}" property="${p.property}"  displayStyle="${displayStyle?:'table'}" theme="${theme}"/></td>--}%
                            %{--</g:else>--}%
                        %{--</g:each>--}%
                    %{--</tr>--}%
                %{--</g:each>--}%
                %{--</tbody>--}%
            %{--</table>--}%

            <div class="pagination">
                <g:paginate total="${userCount ?: 0}" />
            </div>
        </div>
    </body>
</html>