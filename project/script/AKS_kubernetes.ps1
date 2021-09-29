$subid=''
Set-AzContext -SubscriptionId $subid

$rg = 'rgaksdemo'
$location = 'eastus' 

#Create Resource Group
New-AzResourceGroup -Name $rg -Location $location


$aksculster = 'akssampleclstr'

#Create AKS cluster
New-AzAksCluster -ResourceGroupName $rg -Name $aksculster -NodeCount 1


#Configure kubectl to connect to your Kubernetes cluster 
Import-AzAksCredential -ResourceGroupName $rg -Name $aksculster


$ContainerRegistry = 'ctraksdemo'

New-AzContainerRegistry -Name $ContainerRegistry -ResourceGroupName $rg -Sku Basic

#Configure ACR integration for existing AKS clusters
Set-AzAksCluster -Name $aksculster -ResourceGroupName $rg -AcrNameToAttach $ContainerRegistry
