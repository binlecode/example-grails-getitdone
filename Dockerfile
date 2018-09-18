#FROM docker-registry.construction.com/oracle-jre:1.8.0_121
#FROM openjdk:8u171-alphine
FROM azul/zulu-openjdk:8u181

ARG VERSION
ARG PRODUCT
ARG WORKING_DIR_NAME

LABEL base.image="oracle-jre:1.8.0_121"
# LABEL version="$VERSION"

#WORKDIR /opt/$PRODUCT
WORKDIR /opt/example-grails-getitdone

#COPY $WORKING_DIR_NAME/build/libs/$PRODUCT-$VERSION.jar $PRODUCT.jar
COPY build/libs/example-grails-getitdone-0.1.jar app.jar

# this is for alpine linux OS
#CMD exec java -jar --add-modules java.xml.bind -Dgrails.env=development /opt/example-grails-getitdone/app.jar

#ENTRYPOINT ["java", '-jar', '-Dgrails.env=development', '/opt/example-grails-getitdone/app.jar']

ENTRYPOINT ["java", "-jar", "-Dgrails.env=development", "/opt/example-grails-getitdone/app.jar"]