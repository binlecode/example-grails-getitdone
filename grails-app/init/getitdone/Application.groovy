package getitdone

import grails.boot.GrailsApp
import grails.boot.config.GrailsAutoConfiguration
import org.springframework.boot.actuate.health.DataSourceHealthIndicator

class Application extends GrailsAutoConfiguration {
    static void main(String[] args) {
        GrailsApp.run(Application, args)
    }

    @Override
    Closure doWithSpring() {
        { ->
            // Configure data source health indicator based on the dataSource in the application context.
            databaseHealthCheck(DataSourceHealthIndicator, ref('dataSource'))

//            diskSpaceHealthIndicatorProperties(DiskSpaceHealthIndicatorProperties) {
//                threshold = 250 * 1024 * 1024
//            }
        }
    }
}