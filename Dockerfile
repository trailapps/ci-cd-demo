FROM openjdk:16-alpine as builder

#Create useer as its advisable not run the commands as root user
RUN addgroup -S spring && adduser -S springuser -G spring
USER springuser

#create working dir springuser
WORKDIR /home/springuser

#copy file(s) from host to image
ARG JAR_FILE=build/libs/ci-cd-demo-0.0.1-SNAPSHOT.jar
COPY ${JAR_FILE} api.jar
RUN java -Djarmode=layertools -jar api.jar extract

FROM openjdk:16-alpine
WORKDIR application
COPY --from=builder /home/springuser/dependencies/ ./
COPY --from=builder /home/springuser/snapshot-dependencies/ ./
COPY --from=builder /home/springuser/spring-boot-loader/ ./
COPY --from=builder /home/springuser/application/ ./
EXPOSE 8080
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]

#configures main process executable command
#ENTRYPOINT ["java", "-Xmx512m", "-Xms256m", "-jar", "app.jar"]