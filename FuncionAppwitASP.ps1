#------------------------------------------------------------------------------------------------------------
#Check if App Service Plan exists,if not then create it
#------------------------------------------------------------------------------------------------------------
 
Get-AzureRmAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlan -ErrorVariable GetAppServicePlanError -ErrorAction SilentlyContinue

if($GetAppServicePlanError)
{
	Write-Output "Create AppServicePlan '$AppServicePlan' ..."
	New-AzureRmAppServicePlan -Name $AppServicePlan -Location $Location -ResourceGroupName $ResourceGroupName -Tier $Tier
	}

#------------------------------------------------------------------------------------------------------------
#Create function app for data collection
#------------------------------------------------------------------------------------------------------------
$PropertiesObject = @{
    # serverFarmId points to the App Service Plan resource id
    serverFarmId = "/subscriptions/$SubscriptionID/resourceGroups/$ResourceGroupName/providers/Microsoft.Web/serverfarms/$AppServicePlan"
}

#Get-AzureRmResource -ResourceGroupName $resourceGroupName -ResourceType 'Microsoft.Web/sites/functions' -ResourceName $functionAppName -ErrorVariable GetfunctionAppError -ErrorAction SilentlyContinue |Out-Null
#if($GetfunctionAppError) {
		Write-Output "Create new Function App for data collection"
		New-AzureRmResource -PropertyObject $PropertiesObject -ResourceType 'Microsoft.Web/Sites' -ResourceName $functionAppName -kind 'functionapp' -Location $Location -ResourceGroupName $ResourceGroupName -force
#}
