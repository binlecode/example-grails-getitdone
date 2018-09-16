

## app bootstrap

```bash
# verify grails version 3.3.8
grails --version
# create getitdone exmaple app
grails create-app example-getitdone
```

## configuration

#### datasource on mysql

In ```build.gradle``` file add:



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








