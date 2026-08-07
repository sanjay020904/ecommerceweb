# Stage 1: Build application using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run application with Apache Tomcat 10
FROM tomcat:10.1-jdk17-temurin
WORKDIR /usr/local/tomcat
RUN rm -rf webapps/ROOT webapps/ROOT.war
COPY --from=build /app/target/ecommerceapp.war webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
