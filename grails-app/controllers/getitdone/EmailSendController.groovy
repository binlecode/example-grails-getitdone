package getitdone

/**
 * a simple web ui to compose and send email, using Grails email plugin.
 * the web ui is using CK-Edit to support html email body.
 * ref url: https://www.djamware.com/post/58b50fee80aca736bb5e4369/grails-3-send-email-example
 */
class EmailSendController {

    def index() {
    }

    def send() {
        sendMail {
            to params.address
            subject params.subject
//            text params.body
            html params.body  // use CKEditor to edit html body for email body
        }

        flash.message = "Message sent at ${new Date()}"
        redirect action:"index"
    }

}
