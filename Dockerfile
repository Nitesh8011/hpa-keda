FROM openjdk:21-jdk

LABEL maintainer="nitesh8011"

COPY *.jar /app.jar

ENTRYPOINT ["java","-jar","/app.jar"]