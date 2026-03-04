#!/bin/sh
#
# myEnvironment defines the variables used for idempiere
# Do not edit directly - use setup.sh
#
# $Id: myEnvironmentTemplate.sh,v 1.12 2005/02/21 03:17:21 jjanke Exp $

echo Setting myEnvironment ....
#	Clients only needs
#		IDEMPIERE_HOME
#		JAVA_HOME
#	Server install needs to change
#		ADEMPIERE_DB_NAME	(for Oracle)
#		passwords

# 	Homes ...
IDEMPIERE_HOME="/opt/idempiere-server"
export IDEMPIERE_HOME
JAVA_HOME="/usr/lib/jvm/java-17-amazon-corretto"
export JAVA_HOME

#	Database ...
ADEMPIERE_DB_SERVER="marselladatabase.postgres.database.azure.com"
export ADEMPIERE_DB_SERVER
ADEMPIERE_DB_USER="adempiere"
export ADEMPIERE_DB_USER
ADEMPIERE_DB_PASSWORD="$( "$IDEMPIERE_HOME/utils/getVar.sh" ADEMPIERE_DB_PASSWORD )"
export ADEMPIERE_DB_PASSWORD
ADEMPIERE_DB_URL="jdbc:postgresql://marselladatabase.postgres.database.azure.com:5432/sannet"
export ADEMPIERE_DB_URL
ADEMPIERE_DB_PORT="5432"
export ADEMPIERE_DB_PORT

#	Oracle Specifics ...
ADEMPIERE_DB_PATH="postgresql"
export ADEMPIERE_DB_PATH
ADEMPIERE_DB_NAME="sannet"
export ADEMPIERE_DB_NAME
ADEMPIERE_DB_SYSTEM="$( "$IDEMPIERE_HOME/utils/getVar.sh" ADEMPIERE_DB_SYSTEM )"
export ADEMPIERE_DB_SYSTEM
ADEMPIERE_DB_SYSTEM_USER=""
export ADEMPIERE_DB_SYSTEM_USER

#	Homes(2)
ADEMPIERE_DB_HOME="$IDEMPIERE_HOME/utils/$ADEMPIERE_DB_PATH"
export ADEMPIERE_DB_HOME

#	Apps Server
ADEMPIERE_APPS_SERVER="0.0.0.0"
export ADEMPIERE_APPS_SERVER
ADEMPIERE_WEB_PORT="8080"
export ADEMPIERE_WEB_PORT
ADEMPIERE_JNP_PORT="@ADEMPIERE_JNP_PORT@"
export ADEMPIERE_JNP_PORT
#	SSL Settings - see jettyhome/etc/jetty.xml and jettyhome/etc/jetty-ssl.xml
ADEMPIERE_SSL_PORT="8443"
export ADEMPIERE_SSL_PORT
ADEMPIERE_KEYSTORE="/opt/idempiere-server/jettyhome/etc/keystore"
export ADEMPIERE_KEYSTORE
ADEMPIERE_KEYSTOREPASS="OBF:1saj1vg11t331vgj1xfj1vgb1t331vgt1sar"
export ADEMPIERE_KEYSTOREPASS

#	Java
ADEMPIERE_JAVA="$JAVA_HOME/bin/java"
export ADEMPIERE_JAVA
IDEMPIERE_JAVA_OPTIONS="-Xms64M -Xmx512M -DIDEMPIERE_HOME=$IDEMPIERE_HOME"
export IDEMPIERE_JAVA_OPTIONS

if [ "$ID_ENV" != "Server" ]
then
    cp $IDEMPIERE_HOME/utils/myEnvironment.sh $IDEMPIERE_HOME/utils/myEnvironment.sav
fi
