FROM openjdk:11 AS build_image
RUN apt update && apt install maven -y
RUN git clone https://github.com/niveshsunny/CICD_KUBERNETES.git
RUN cd CICD_KUBERNETES && mvn install

FROM tomcat:9-jre11

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build_image CICD_KUBERNETES/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
