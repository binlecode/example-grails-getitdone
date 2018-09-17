<content tag="nav">
    <li class="dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Users<span class="caret"></span></a>
        <ul class="dropdown-menu">
            <li><g:link controller="user">List Users</g:link></li>
            <li role="separator" class="divider"></li>
            <li><g:link controller="user" action="create">Add User</g:link></li>
        </ul>
    </li>
    <li class="dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Tasks<span class="caret"></span></a>
        <ul class="dropdown-menu">
            <li><g:link controller="task">List Tasks</g:link></li>
            <li><g:link controller="task" action="create">Create Task</g:link></li>
        </ul>
    </li>
    <li class="dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Work Logs<span class="caret"></span></a>
        <ul class="dropdown-menu">
            <li><g:link controller="work">List Work Logs</g:link></li>
            <li><g:link controller="work" action="create">Log Work</g:link></li>
        </ul>
    </li>
</content>