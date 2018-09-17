<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
        <g:layoutTitle default="Grails"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico" />

    <asset:stylesheet src="application.css"/>

    <g:layoutHead/>
</head>
<body>

    <div class="navbar navbar-default navbar-static-top" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/#">
		            <asset:image src="get-it-done-logo-gray.png" alt="app Logo"/>
                </a>
            </div>
            <div class="navbar-collapse collapse" aria-expanded="false" style="height: 0.8px;">
                <ul class="nav navbar-nav navbar-right">
                    %{--<g:pageProperty name="page.nav" />--}%
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
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Time Sheet<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><g:link controller="work" action="timeSheet">Team</g:link></li>
                            <li><g:link uri="#">Personal</g:link></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">App Status <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="#">Environment: ${grails.util.Environment.current.name}</a></li>
                            <li><a href="#">App profile: ${grailsApplication.config.grails?.profile}</a></li>
                            <li><a href="#">App version:
                                <g:meta name="info.app.version"/></a>
                            </li>
                            <li role="separator" class="divider"></li>
                            <li><a href="#">Grails version:
                                <g:meta name="info.app.grailsVersion"/></a>
                            </li>
                            <li><a href="#">Groovy version: ${GroovySystem.getVersion()}</a></li>
                            <li><a href="#">JVM version: ${System.getProperty('java.version')}</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a href="#">Reloading active: ${grails.util.Environment.reloadingAgentEnabled}</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <g:layoutBody/>

    <div class="footer" role="contentinfo">
        <p>This software is proof-of-concept, for demo only. See: <a href="https://github.com/binlecode/example-grails-getitdone">Github repo.</a></p>
        <p>Contact: bin.le.code@gmail.com</p>
    </div>

    <div id="spinner" class="spinner" style="display:none;">
        <g:message code="spinner.alt" default="Loading&hellip;"/>
    </div>

    <asset:javascript src="application.js"/>
</body>
</html>
