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
                <li><g:link class="btn" action="timeSheet">Current Week</g:link></li>
                <li><g:link class="btn" action="timeSheet" params="[showLastWeek: true, currentWeekDateBegin: workDateRange[0]]"><< Last Week</g:link></li>
                <li><g:link class="btn" action="timeSheet" params="[showNextWeek: true, currentWeekDateBegin: workDateRange[0]]">Next Week >></g:link></li>
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
                        <th>${workDate}</th>
                    </g:each>
                </tr>
                </thead>
                <tbody>
                <g:each in="${workList}" var="bean" status="i">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                        <td>
                            <g:link method="GET" controller="task" action="show" params="[id: bean.taskId]">
                                <span class="badge ${g.resolveTaskStatusBadgeClass(status: bean.task.status)}">
                                ${bean.task.status}
                                </span>
                                <g:if test="${bean.task.description.size() > 30}">
                                    ${bean.task.description.take(26)} ...
                                </g:if>
                                <g:else>
                                    ${bean.task.description.encodeAsRaw()}
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
                                %{-- find the matching local work date for this work --}%
                                <g:if test="${bean.localWorkDate == workDate}">
                                    <span class="badge">
                                    <g:link style="text-decoration: none; color: whitesmoke"
                                            method="GET" controller="work" action="show" params="[id: bean.id]">
                                    ${bean.timeSpent} ${bean.timeSpentUnit}
                                    </g:link>
                                    </span>
                                </g:if>
                            </td>
                        </g:each>

                    </tr>
                </g:each>

                %{-- add work stats row with total time spent per day --}%
                <g:if test="${workStats}">
                    <tr class="odd">
                        <td></td>
                        <td>Total Time</td>
                        <g:each in="${workDateRange}" var="workDate" state="k">
                            <td>
                                <g:if test="${workStats.keySet().any { it == workDate}}">
                                    <span>${workStats.get(workDate)} hrs</span>
                                </g:if>
                                <g:else>
                                    <span>0</span>
                                </g:else>
                            </td>
                        </g:each>
                    </tr>
                </g:if>

                </tbody>
            </table>

            <div class="pagination">
                <g:paginate total="${workCount ?: 0}" />
            </div>
        </div>
    </body>
</html>