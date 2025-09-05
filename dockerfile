# Stage 1: Build the application
FROM maven:3.8.8-eclipse-temurin-17 AS builder

# Set the working directory
WORKDIR /app

# Copy the project files into the container
COPY . .

# Build the application
RUN mvn clean package -DskipTests

# Stage 2: Run the application
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=builder /app/target/OtmTodoApp-1.0-SNAPSHOT.jar app.jar

# Expose the application port
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "app.jar"]

# Stage 2: Run the application
FROM openjdk:17-jdk-slim

# Install required libraries for JavaFX
RUN apt-get update && apt-get install -y libx11-6 libxext6 libxrender1 libxtst6 libxi6 libgl1-mesa-glx

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=builder /app/target/OtmTodoApp-1.0-SNAPSHOT.jar app.jar

# Expose the application port
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "app.jar"]