<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'work.label', default: 'Work')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#list-work" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="list-work" class="content scaffold-list" role="main">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            %{--<f:table collection="${workList}" />--}%

            <table>
                <thead>
                <tr>
                    <g:sortableColumn property="dateCreated" title="Create Time" />
                    <g:sortableColumn property="lastUpdated" title="Update Time" />
                    <g:sortableColumn property="workDate" title="Work Date" />
                    <!-- use regulated timeInMin for sorting, while use unit based timeSpent for rendering -->
                    <g:sortableColumn property="timeSpentInMin" title="Time Spent" />
                    <g:sortableColumn property="worker.email" title="Worker" />
                    <g:sortableColumn property="task.description" title="task" />
                </tr>
                </thead>
                <tbody>
                <g:each in="${workList}" var="bean" status="i">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                        <td><g:link method="GET" resource="${bean}"><f:display bean="${bean}" property="dateCreated" displayStyle="table" /></g:link></td>
                        <td><f:display bean="${bean}" property="lastUpdated"  displayStyle="table" theme="${theme}"/></td>
                        <td>${bean.workDate?.format('YYYY-MM-dd')}</td>
                        <td>
                            ${bean.timeSpent} ${bean.timeSpentUnit}
                            <g:if test="${bean.timeSpentUnit == getitdone.Work.TIME_UNIT_HOUR}">
                                ( ${bean.timeSpentInMin} min )
                            </g:if>
                        </td>
                        <td>
                            <g:link method="GET" controller="user" action="show" params="[id: bean.workerId]">
                                <f:display bean="${bean}" property="worker.email"  displayStyle="table" theme="${theme}"/>
                            </g:link>
                        </td>
                        <td>
                            <g:link method="GET" controller="task" action="show" params="[id: bean.taskId]">
                                <f:display bean="${bean}" property="task.description"  displayStyle="table" theme="${theme}"/>
                            </g:link>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>



            <div class="pagination">
                <g:paginate total="${workCount ?: 0}" />
            </div>
        </div>
    </body>
</html>