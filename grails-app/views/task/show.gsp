<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'task.label', default: 'Task')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#show-task" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                %{--<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--}%
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="show-task" class="content scaffold-show" role="main">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <ol class="property-list task">
                <li class="fieldcontain">
                    <span id="descriptoin-label" class="property-label">Description</span>
                    <div class="property-value" aria-labelledby="description-label">
                        ${this.task.description.encodeAsRaw()}
                    </div>
                </li>
                <li class="fieldcontain">
                    <span id="assignee-label" class="property-label">Assignee</span>
                    <div class="property-value" aria-labelledby="assignee-label">
                        %{-- a task may not be assigned thus assigneeId could be null --}%
                        <g:if test="${this.task.assigneeId}">
                        <g:link controller="user" action="show" id="${this.task.assigneeId}">
                        ${this.task.assignee.email}
                        </g:link>
                        </g:if>
                    </div>
                </li>
                <li class="fieldcontain">
                    <span id="status-label" class="property-label">Status</span>
                    <div class="property-value" aria-labelledby="status-label">
                        ${this.task.status}
                    </div>
                </li>
                <li class="fieldcontain">
                    <div class="property-value" style="display: flex; align-items: center;">
                        <span style="flex-grow: 1;
                        border-bottom: 1px solid #CCCCCC;
                        margin: 5px"></span>
                    </div>

                </li>
                <li class="fieldcontain">
                    <span id="work-label" class="property-label">Work Logs</span>
                    <div class="property-value" aria-labelledby="work-label">
                        <ul class="list-unstyled">
                            <g:each in="${this.task.workLogs.sort {it.lastUpdated ?: it.dateCreated}.reverse()}" var="work" status="j">
                                <li>
                                    <g:link method="GET" controller="work" action="show" params="[id: work.id]">
                                        ${work.timeSpent} ${work.timeSpentUnit}
                                    </g:link>
                                    [on ${work.workDate.format('yyyy-MM-dd')} by ${work.worker.email}]
                                </li>
                            </g:each>
                        </ul>
                    </div>
                </li>

                <li class="fieldcontain">
                    <span id="comments-label" class="property-label">Comments</span>
                    <div class="property-value" aria-labelledby="comments-label">
                        <ul class="list-unstyled">
                            <g:if test="${this.task.comments}">
                                <g:each in="${this.task.comments.sort {it.lastUpdated}}" var="comment" status="k">
                                    <li>
                                        <div class="card card-block">
                                            <div class="card-title">
                                                Commented at ${comment.dateCreated.format('yyyy-MM-dd HH:mm:ss')}
                                            </div>
                                            <div class="card-text">
                                                %{--<h5 class="card-title">Special title treatment</h5>--}%
                                                ${comment.content.encodeAsRaw()}
                                                %{--<a href="#" class="btn btn-primary">Go somewhere</a>--}%
                                            </div>
                                        </div>
                                    </li>
                                </g:each>
                            </g:if>
                            <g:else>
                                <li>
                                    <div class="card card-block">
                                        <div class="card-title">
                                            There's no comment for this task. Add one below.
                                        </div>
                                    </div>

                                </li>
                            </g:else>
                            <li>
                                %{-- insert inline comment editor --}%
                                <g:form name="form-comment" controller="comment" action="save" method="POST">
                                        <!-- Include stylesheet for QuillJS editor -->
                                        <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">

                                        <input type="hidden" id="task.id" name="task.id" value="${this.task.id}" />
                                        <input type="hidden" id="comment-content" name="content" />
                                        <input type="hidden" id="form-redirect-url" name="redirect.url"
                                                value="${g.link(controller: 'task', action: 'show', id: this.task.id)}" />

                                        <!-- Create the editor container -->
                                        <div id="editor-container">
                                        </div>
                                    <div>
                                        <g:submitButton name="create" class="btn-default save" value="Submit Comment" />
                                    </div>

                                </g:form>
                            </li>
                        </ul>
                    </div>
                </li>
            </ol>
            <g:form resource="${this.task}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="edit" action="edit" resource="${this.task}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                    <g:link class="edit" controller="work"  action="create" params="['task.id': this.task.id, 'worker.id': this.task.assigneeId]">
                        <g:message code="default.button.logWork.label" default="Log Work" />
                    </g:link>
                </fieldset>
            </g:form>
        </div>

    <!-- Include the Quill library -->
    <script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
    <asset:javascript src="quill-image-resize.min.js" />

    <!-- Initialize Quill editor -->
    <script>

        Quill.register('modules/imageResize', ImageResize);


        var quill = new Quill('#editor-container', {
            modules: {
                toolbar: [
                    [{ size: [ 'small', false, 'large', 'huge' ]}],
                    // [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                    // [{ 'script': 'sub' }, { 'script': 'super' }],  // superscript/subscript
                    [{ 'color': [] }, { 'background': [] }],    // dropdown with defaults from theme
                    [{ 'font': [] }],
                    [{ 'align': [] }],
                    ['bold', 'italic'],
                    ['link', 'blockquote', 'code-block', 'image'],
                    [{ list: 'ordered' }, { list: 'bullet' }]
                ],
                //fixme: this gets 'moduleClass is not a constructor' error
                // imageResize: {}
            },
            placeholder: 'Compose comment ...',
            theme: 'snow'
        });



        var form = document.querySelector('form[name=form-comment]');
        form.onsubmit = function() {
            var ctnt = document.querySelector('input[name=content]');

            var ctntHtml = quill.root.innerHTML;  // getting html format content
            ctnt.value = ctntHtml;
            console.log("html content:", ctntHtml);

            // return false;  // abort real form submission
            return true;
        };
    </script>

    </body>
</html>
