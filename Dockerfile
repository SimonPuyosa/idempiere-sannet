# Utiliza una imagen de OpenJDK 17
FROM maven:3.9-eclipse-temurin-17-alpine AS build

# Se agrega telnet
#RUN apk update && apk add --no-cache busybox-extras

# Define el directorio de trabajo como /idempServ10
# WORKDIR /idempServ10
# COPY . .

# Compila el proyecto
# RUN mvn -q verify -U 

# Define el directorio de instalación de Idempiere
WORKDIR /opt/idempiere-server

# Copia los archivos necesarios para la ejecución de Idempiere
COPY ./org.idempiere.p2/target/products/org.adempiere.server.product/linux/gtk/x86_64/ .
COPY ./scripts/* /opt/idempiere-server/

# Otorga permisos de ejecución a todos los scripts
RUN echo "=== Listando archivos copiados ===" && ls -la /opt/idempiere-server/ && \
    echo "=== Otorgando permisos de ejecucion ===" && \
    find /opt/idempiere-server -name "*.sh" -exec chmod +x '{}' \; && \
    echo "=== Permisos aplicados ===" && ls -la /opt/idempiere-server/*.sh

# Ejecuta el setup de configuracion
RUN echo "=== Iniciando console-setup-alt.sh ===" && \
    sh -x ./console-setup-alt.sh < ./configuracion.txt ; \
    echo "=== console-setup-alt.sh termino con codigo: $? ===" && \
    echo "=== Archivos generados post-setup ===" && ls -la /opt/idempiere-server/

# Instala el plugin REST
RUN echo "=== Iniciando update-prd.sh ===" && \
    sh -x ./update-prd.sh https://jenkins.idempiere.org/job/idempiere-rest/ws/com.trekglobal.idempiere.extensions.p2/target/repository/ com.trekglobal.idempiere.rest.api ; \
    echo "=== update-prd.sh termino con codigo: $? ==="
EXPOSE 8080 8443 12612

# Define el comando de entrada para ejecutar Idempiere
ENTRYPOINT ["sh", "-c", "./idempiere-server.sh"]
