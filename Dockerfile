# ----------------------------------------------------------------------
# STAGE 1: BUILD THE APPLICATION
# This stage uses a full JDK/Maven environment to compile the code
# ----------------------------------------------------------------------
FROM maven:3.8.7-eclipse-temurin-17 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and source code into the container
# Copying pom.xml first allows Docker to cache the dependencies layer
COPY pom.xml .
COPY src ./src

# Build the application, creating the JAR file in the target directory
# We use -DskipTests to speed up the Docker build, but you should run tests
# separately in a CI/CD pipeline.
RUN mvn clean package -DskipTests

# ----------------------------------------------------------------------
# STAGE 2: CREATE THE FINAL RUNTIME IMAGE
# This stage uses a minimal JRE base image to run the final JAR artifact
# ----------------------------------------------------------------------
FROM eclipse-temurin:17-jre

# Set the working directory
WORKDIR /app

# Copy the final JAR artifact from the 'builder' stage
# The name of the JAR file needs to match what Maven generated.
# If you only have one JAR, you can often use *.jar
# Here we assume the generated jar is the first one found in /app/target/
COPY --from=builder /app/target/*.jar app.jar

# Expose the application port
EXPOSE 8080

# Define the command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
