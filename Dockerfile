# Version qui marche à coup sûr en 2025
FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app

# Cache des dépendances (très rapide après la 1ère fois)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Build du JAR
COPY src ./src
RUN mvn clean package -DskipTests -B

# Image finale ultra-légère
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
