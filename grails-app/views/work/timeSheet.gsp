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
                %{--<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--}%
                <li><g:link class="create" action="create"><g:message code="default.logWork.label" args="[entityName]" default="Log Work" /></g:link></li>
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
                    <th>Task</th>
                    <th>Worker</th>
                    <g:each in="${this.workDateRange}" var="workDate" status="j">
                        <th>${workDate.format('yyyy-MM-dd')}</th>
                    </g:each>
                </tr>
                </thead>
                <tbody>
                <g:each in="${workList}" var="bean" status="i">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                        <td>
                            <g:link method="GET" controller="task" action="show" params="[id: bean.taskId]">
                                <g:if test="${bean.task.description.size() > 30}">
                                    [<b>${bean.task.status}</b>] ${bean.task.description.take(26)} ...
                                </g:if>
                                <g:else>
                                    <b>${bean.task.status}</b> : ${bean.task.description}
                                </g:else>
                            </g:link>
                        </td>
                        <td>
                            <g:link method="GET" controller="task" action="show" params="[id: bean.taskId]">
                                ${bean.worker.email}
                            </g:link>
                        </td>

                        <g:each in="${workDateRange}" var="workDate" state="k">
                            <td>
                                <g:if test="${bean.workDate == workDate}">
                                    <span class="badge">
                                    <g:link style="text-decoration: none; color: whitesmoke"
                                            method="GET" controller="work" action="show" params="[id: bean.id]">
                                    ${bean.timeSpent} ${bean.timeSpentUnit}
                                    %{--<g:if test="${bean.timeSpentUnit == getitdone.Work.TIME_UNIT_HOUR}">--}%
                                        %{--( ${bean.timeSpentInMin} min )--}%
                                    %{--</g:if>--}%
                                    </g:link>
                                    </span>
                                </g:if>
                            </td>
                        </g:each>

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