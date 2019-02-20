FROM openjdk:8-jdk
COPY Dockerfile /opt/docker/
EXPOSE 8080
CMD ["java", "-jar", "/opt/docker/spring-petclinic.jar"]
