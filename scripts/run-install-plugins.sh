#!/bin/sh

# Ejecutar idempiere
./idempiere-server.sh

# Instala los plugins sin mostrar logs
./install-plugins.sh # > /dev/null 2>&1 &

wait