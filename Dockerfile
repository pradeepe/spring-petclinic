FROM openjdk:8-jdk
COPY . Dockerfile /opt/docker/Dokerfile
COPY target/spring-petclinic-4.2.5-SNAPSHOT /opt/docker/spring-petclinic.jar
EXPOSE 8080
CMD ["java", "-jar", "/opt/docker/spring-petclinic.jar"]
