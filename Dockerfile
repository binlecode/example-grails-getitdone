#FROM docker-registry.construction.com/oracle-jre:1.8.0_121
#FROM openjdk:8u171-alphine
FROM azul/zulu-openjdk:8u181

ARG VERSION="0.1"
ARG PRODUCT="example-grails-getitdone"
ARG WORKING_DIR="build/libs"

ENV JVM_OPTS="-Xms512M -Xmx512M -XX:+UseParallelGC"

LABEL base.image="oracle-jre:1.8.0_121"
# LABEL version="$VERSION"

#WORKDIR /opt/$PRODUCT
WORKDIR /opt/example-grails-getitdone

#COPY $WORKING_DIR/build/libs/$PRODUCT-$VERSION.jar $PRODUCT.jar
COPY build/libs/example-grails-getitdone-0.1.jar app.jar

# this is for alpine linux OS
#CMD exec java -jar --add-modules java.xml.bind -Dgrails.env=development /opt/example-grails-getitdone/app.jar

CMD exec java $JVM_OPTS -Dgrails.env=development -jar /opt/example-grails-getitdone/app.jar

# ENTRYPOINT ["java", "-Xms512M", "-Xmx512M", "-XX:MaxPermSize=256M", "-XX:+UseParallelGC", "-Dgrails.env=development", "-jar", "/opt/example-grails-getitdone/app.jar"]