$rg = 'rgaksdemo'
$location = 'eastus' 

#Create Resource Group
az group create --name $rg --location $location


$aksculster = 'akssampleclstr'
#Create AKS cluster
az aks create --resource-group $rg --name $aksculster --node-count 1 --enable-addons monitoring --generate-ssh-keys


#Configure kubectl to connect to your Kubernetes cluster 
az configure --defaults group=$rg 
az aks get-credentials --resource-group $rg --name $aksculster


$ContainerRegistry = 'ctraksdemo'
az acr create --resource-group $rg --name $ContainerRegistry  --sku Basic


#Configure ACR integration for existing AKS clusters
az aks update -n $aksculster -g $rg --attach-acr $ContainerRegistry