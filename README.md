
# Example Grails Get-It-Done Application

[![Build Status](https://travis-ci.org/binlecode/example-grails-getitdone.svg?branch=master)](https://travis-ci.org/binlecode/example-grails-getitdone)


## features

### workflow module
#### task management
 - creation from template or scratch (builder/factory) 
 - assignment
#### task tracking and workflow tracking
#### comments on task or workflow
#### management UI

### scheduler module
#### task scheduling
- long due task by predefined time window expiration
- task temporal nature by predefined calendar association

#### task notification by status change detection (scanning) 

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
create a ```.travis.yml``` file to project root folder
```yaml
sudo: false # follows default ubuntu convention (Travis on ubuntu)
before_cache:
  - rm -f $HOME/.gradle/caches/modules-2/modules-2.lock
cache:
  directories:
    - $HOME/.gradle/caches/
    - $HOME/.gradle/wrapper/ # 
language: groovy # 
jdk:
  - oraclejdk8 #  
``` 

For more details, see [OCI guide](http://guides.grails.org/grails-on-travis-basics/guide/index.html).

Once Travis-CI can build on Github push, the [build|passing] Travis status badge can be added to README.md (check the top of this file). 


## Docker container deployment

fix server port in ```application.yml```

By default gradlew assemble picks product environment. For security reason and demo purpose, we build jar with development env.

added Dockerfile to the project root folder that
- pulled in azul/java-zulu openjdk which is compatible with oracle version
- build jar and copy to ```$WORKDIR```
- run java jar from ```$WORKDIR```

run 
```bash
docker build .
```
