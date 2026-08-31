# Gym Dockerfile
FROM maven:3.9-eclipse-temurin-11 AS builder

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

FROM tomcat:9-jdk11-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=builder /app/target/gym-website.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]