# Build stage using official Maven 3.9 and Temurin JDK 17
FROM maven:3.9.5-eclipse-temurin-17 AS build
WORKDIR /app

# Copy pom and source, then build
COPY pom.xml .
COPY src ./src
RUN mvn -B -DskipTests package -DskipTests

# Runtime stage
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
