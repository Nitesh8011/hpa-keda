FROM openjdk:21-jdk

LABEL maintainer="Nitesh Kumar"

COPY *.jar /app.jar

ENTRYPOINT ["java","-jar","/app.jar"]