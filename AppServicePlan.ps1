#------------------------------------------------------------------------------------------------------------
#Check if App Service Plan exists,if not then create it
#------------------------------------------------------------------------------------------------------------
 
Get-AzureRmAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlan -ErrorVariable GetAppServicePlanError -ErrorAction SilentlyContinue

if($GetAppServicePlanError)
{
	Write-Output "Create AppServicePlan '$AppServicePlan' ..."
	New-AzureRmAppServicePlan -Name $AppServicePlan -Location $Location -ResourceGroupName $ResourceGroupName -Tier $Tier
	}

