FROM maven:3.8.6-openjdk-8 AS builder
WORKDIRR /app
COPY . .
RUN mvn clean package
FROM tomcat:9.0-jdk8-openjdk
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE: 8080
CMD ["catalina.sh", "run"]