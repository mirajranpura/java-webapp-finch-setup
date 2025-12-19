# Use Tomcat 9 with Java 8
FROM tomcat:9.0-jdk8-openjdk

# Install additional tools for debugging
RUN apt-get update && apt-get install -y \
    curl \
    netcat \
    && rm -rf /var/lib/apt/lists/*

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR files to webapps directory
COPY wars/*.war /usr/local/tomcat/webapps/

# Set Java options for better debugging and memory management
ENV JAVA_OPTS="-Xmx1024m -Xms512m -XX:+UseG1GC -XX:+PrintGCDetails -Djava.awt.headless=true -Dfile.encoding=UTF-8"

# Set Tomcat options for better logging
ENV CATALINA_OPTS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9999 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false"

# Create logs directory
RUN mkdir -p /usr/local/tomcat/logs

# Expose Tomcat port and JMX port
EXPOSE 8080 9999

# Add health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:8080/ || exit 1

# Start Tomcat
CMD ["catalina.sh", "run"]