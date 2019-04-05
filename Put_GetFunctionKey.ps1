  $functionHostKey='eiqVjidLaHY2Qw3a4K4eUqzOTOUD6AK092keAGfkVjn87qWHxnAabg=='
 $data = @{
"name" = "default"
"value" = "$functionHostKey"
} | ConvertTo-Json;



$publishingCredentials = Invoke-AzureRmResourceAction -ResourceGroupName $ResourceGroupName -ResourceType "Microsoft.Web/sites/config" -ResourceName "$functionAppName/publishingcredentials" -Action list -ApiVersion 2015-08-01 -Force
$authorization = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $publishingCredentials.Properties.PublishingUserName, $publishingCredentials.Properties.PublishingPassword)))
$accessToken = Invoke-RestMethod -Uri "https://$functionAppName.scm.azurewebsites.net/api/functions/admin/token" -Headers @{Authorization=("Basic {0}" -f $authorization)} -Method GET

#put default key
$response = Invoke-RestMethod -Method PUT -Headers @{Authorization = ("Bearer {0}" -f $accessToken)} -ContentType "application/json" -Uri "https://$functionAppName.azurewebsites.net/admin/host/keys/default" -body $data
 
#get default key
$responekey=Invoke-RestMethod -Method Get -Headers @{Authorization = ("Bearer {0}" -f $accessToken)} -ContentType "application/json" -Uri "https://$functionAppName.azurewebsites.net/admin/host/keys/default"