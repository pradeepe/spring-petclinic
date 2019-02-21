From tomcat:8-jre8
COPY Dockerfile /opt/docker/
COPY petclinic.war /opt/docker/
EXPOSE 8080
CMD ["java", "-jar", "/opt/docker/spring-petclinic.jar"]
