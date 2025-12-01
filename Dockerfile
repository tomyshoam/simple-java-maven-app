# ====== Build stage ======
FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /app

# Only copy what we need for Maven to run
COPY pom.xml .
COPY src ./src

# Build the jar
RUN mvn -B -DskipTests package

# ====== Runtime stage ======
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

# Copy the built jar from the build stage
COPY --from=build /app/target/*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]

