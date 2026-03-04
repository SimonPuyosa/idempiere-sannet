# Iniciar sesión en Azure
sudo az login

# Crear el grupo de recursos si no existe
#az group create --name IdempiereSannet --location centralus

# Crear el registro de contenedores de Azure si no existe
#az acr create --resource-group Marsella --name idempiere --sku Basic

# Iniciar sesión en el registro de contenedores de Azure (ACR)
sudo az acr login --name idempiere

# Construir la imagen de Docker
sudo docker build -t sannet-app .

# Etiquetar la imagen de Docker
sudo docker tag sannet-app idempiere.azurecr.io/sannet-app:latest

# Subir la imagen al registro de contenedores de Azure
sudo docker push idempiere.azurecr.io/sannet-app:latest

# Crear el contenedor en Azure
az container create --resource-group Sannet --name sannet-container \
    --image idempiere.azurecr.io/sannet-app:latest --cpu 1 --memory 2 \
    --os-type Linux \
    --ports 8080 8443 12612 --vnet IdempSrv-vnet --subnet MarsellaContainer