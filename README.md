
# Example Grails Get-It-Done Application

[![Build Status](https://travis-ci.org/binlecode/example-grails-getitdone.svg?branch=master)](https://travis-ci.org/binlecode/example-grails-getitdone)


## app bootstrap

```bash
# verify grails version 3.3.8
grails --version
# create getitdone exmaple app
grails create-app example-getitdone
```

## configuration

#### datasource

For demo purpose the embedded h2 database is good fit.
When application is running, open web database console at `http://localhost/dbconsole`. And set `JDBC URL` to `jdbc:h2:./devDb;MVCC=TRUE;LOCK_TIMEOUT=10000;DB_CLOSE_ON_EXIT=FALSE`.



#### enable sql logging

In ```logback.groovy``` file, add:
```groovy
def loggerList = ['STDOUT']
logger('org.hibernate.SQL', DEBUG, loggerList, false)    // show sql statements
logger('org.hibernate.type.descriptor.sql.BasicBinder', DEBUG, loggerList, false)  // show sql bind variable values
```


## setup domains

#### User domain

```bash
grails create-domain-class getitdone.User
```
setup fields: firstName, lastName, middleName, email, etc.
also add validation on those fields.

then generate scaffold mvc artifacts for User domain:

```bash
generate-all getitdone.User
```

this will generate controller, and JPA compliant UserService class.

#### Task domain



## Travis CI integration

Created a [`.travis.yml`](.travis.yml) file to project root folder.


For more details, see [OCI guide](http://guides.grails.org/grails-on-travis-basics/guide/index.html).

Travis-CI is configured on Github push, the [build|passing] Travis status badge has been be added to README.md (check the top of this file). 


## Docker container deployment

First make sure gradle assemble builds the jar:

```bash
./gradlew assemble
```

By default gradlew assemble picks production environment. For demo purpose, we build jar with development env.

A Dockerfile at the project root folder that does:
- pulled in azul/java-zulu openjdk which is compatible with oracle version
- build jar and copy to `$WORKDIR`
- run java jar from `$WORKDIR`

Build the image with a tag:

```bash
docker build -t example-grails-getitdone .
```

For jdk 8 and 9, it is a known issue that jvm may not know well about the virtual host memory boundary.

```bash
docker run --rm -p 8080:8080 -m 1024M example-grails-getitdone
```

to run in daemon mode

```bash
docker run -d -p 8080:8080 -m 1024M --name getitdone example-grails-getitdone
docker logs -f getitdone
```
