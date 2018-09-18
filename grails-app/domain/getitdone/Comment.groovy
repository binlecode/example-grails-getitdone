package getitdone

class Comment {

    Date dateCreated
    Date lastUpdated

    String content

    //todo: need to add ref to user (author) once spring security is added

    Task task

    static belongsTo = [task: Task]

    static constraints = {
        content blank: false, maxSize: 1024
    }
}
