package getitdone

class User {

    Date dateCreated
    Date lastUpdated

    String firstName
    String lastName
    String middleName
    String email

    static hasMany = [tasks: Task, workLogs: Work]

    static constraints = {
        firstName nullable: true
        lastName nullable: true
        middleName nullable: true
        email blank: false, unique: true, email: true
    }


}
