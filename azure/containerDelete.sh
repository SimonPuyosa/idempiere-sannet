# Eliminar la imagen del repositorio del contenedor
az acr repository delete --name idempiere --image sannet-app:latest --yes

# Eliminar el contenedor
az container delete --name sannet-container --resource-group IdempiereSannet --yes

# Eliminar el repositorio del contenedor
az acr repository delete --name idempiere --repository sannet-app --yes

# Ejecutar el script de limpieza
./run-nuke.sh
