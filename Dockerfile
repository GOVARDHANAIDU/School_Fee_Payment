# Step 1: Build WAR using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn -e -X -DskipTests=true clean package

# Step 2: Deploy to Tomcat
FROM tomcat:9.0

RUN rm -rf /usr/local/tomcat/webapps/ROOT

COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
