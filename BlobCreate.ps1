
$accounthcKey = (Get-AzureRmStorageAccountKey -ResourceGroupName $ResourceGroupName -AccountName $StorageAccountName).Value[0]
$storageAccountConnectionString = 'DefaultEndpointsProtocol=https;AccountName=' + $StorageAccountName + ';AccountKey=' + $accounthcKey
$StorageContext = New-AzureStorageContext -ConnectionString $storageAccountConnectionString 
$container_name = 'hitelementrysink'  
New-AzureStorageContainer -Context $StorageContext -Name $container_name;
