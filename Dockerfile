FROM java:8


#tomcat
RUN mkdir /var/tmp/tomcat
RUN wget -P /var/tmp/tomcat http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.27/bin/apache-tomcat-8.5.27.tar.gz
RUN tar xzf /var/tmp/tomcat/apache-tomcat-8.5.27.tar.gz -C /var/tmp/tomcat
RUN rm -rf /var/tmp/tomcat/apache-tomcat-8.5.27.tar.gz

RUN mkdir /var/tmp/webapp
ADD ./target/spring-petclinic-2.0.0.BUILD-SNAPSHOT.jar /var/tmp/webapp
ADD ./context.xml /var/
ADD ./tomcat-users.xml /var/
RUN cd /var/tmp/webapp && ls  -al
RUN cp -aprf /var/context.xml /var/tmp/tomcat/apache-tomcat-8.5.27/webapps/manager/META-INF
RUN cp -aprf /var/tomcat-users.xml   /var/tmp/tomcat/apache-tomcat-8.5.27/conf
RUN cp -apr /var/tmp/webapp/* /var/tmp/tomcat/apache-tomcat-8.5.27/webapps

EXPOSE 8585

CMD ["./var/tmp/tomcat/apache-tomcat-8.5.27/bin/catalina.sh","run"]

