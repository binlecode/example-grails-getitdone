<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'task.label', default: 'Task')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#list-task" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="list-task" class="content scaffold-list" role="main">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            %{--<f:table collection="${taskList}" />--}%
            <table>
                <thead>
                <tr>
                    <g:sortableColumn property="description" title="Description" />
                    <th>Assignee</th>
                    <g:sortableColumn property="status" title="Status" />
                    <g:sortableColumn property="dateCreated" title="Last Update Time" />
                    %{--<g:sortableColumn property="dateCreated" title="Create Time" />--}%
                </tr>
                </thead>
                <tbody>
                <g:each in="${taskList}" var="bean" status="i">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        <td><g:link method="GET" resource="${bean}"><f:display bean="${bean}" property="description" displayStyle="table" /></g:link></td>
                        <td>
                            <g:link method="GET" controller="user" action="show" params="[id: bean.assigneeId]">
                                <f:display bean="${bean}" property="assignee.email"  displayStyle="table" theme="${theme}"/>
                            </g:link>
                        </td>
                        <td><f:display bean="${bean}" property="status"  displayStyle="table" theme="${theme}"/></td>
                        <td><f:display bean="${bean}" property="lastUpdated"  displayStyle="table" theme="${theme}"/></td>
                        %{--<td><f:display bean="${bean}" property="dateCreated"  displayStyle="table" theme="${theme}"/></td>--}%
                    </tr>
                </g:each>
                </tbody>
            </table>

            <div class="pagination">
                <g:paginate total="${taskCount ?: 0}" />
            </div>
        </div>
    </body>
</html>