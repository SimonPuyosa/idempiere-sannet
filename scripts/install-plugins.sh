#!/bin/bash

esta_en_uso() {
    netstat -tuln | grep 12612 > /dev/null 2>&1
}

while ! esta_en_uso; do
    sleep 10
done

# Variables
TELNET_HOST="localhost"
TELNET_PORT="12612"
BUNDLE_PATHS=("org.globalqss.idempiere.LCO.withholdings.DCS_1.0.26.202406291221.jar" "ve.net.dcs.Customization_1.0.4.202406291233.jar" "ve.net.dcs.DCSBankTransfer_1.0.0.202407211647.jar" "ve.net.dcs.MultiPayment_1.0.4.B202407211707.jar" "ve.net.dcs.LiberoHR_VE_2.2.10.202407211648.jar" "ve.com.as.BalanceSheetGenerate_1.0.0.202410010926.jar" "ve.com.gq.allocationnc_1.0.0.jar")


install_and_start_bundle() {
    BUNDLE_PATH=$1

    # Conecta al servidor Telnet y ejecuta los comandos necesarios
    (
        sleep 1
        echo "install $BUNDLE_PATH"
        sleep 2
        echo "disconnect"
    ) | telnet $TELNET_HOST $TELNET_PORT | tee install_output.txt

    # Extrae el ID del bundle recién instalado
    BUNDLE_ID=$(awk -F'Bundle ID: ' '/Bundle ID: /{print $2}' install_output.txt)

    # Conecta nuevamente para ajustar el nivel de inicio y arrancar el bundle usando el ID extraído
    (
        sleep 1
        echo "bundlelevel -s 5 $BUNDLE_ID"  # Cambia el nivel de inicio a 5
        sleep 1
        echo "start $BUNDLE_ID"
        sleep 1
        echo "disconnect"
    ) | telnet $TELNET_HOST $TELNET_PORT

    # Limpia el archivo temporal
    rm install_output.txt
}

# Itera sobre cada ruta de bundle en el arreglo
for BUNDLE_PATH in "${BUNDLE_PATHS[@]}"; do
    install_and_start_bundle "$BUNDLE_PATH"
done

echo "disconnect"
