$StorageAccountName = "StorageAcct" 
$StorageAccountKey = "storagekey"

$ctx = New-AzureStorageContext -StorageAccountName $StorageAccountName  -StorageAccountKey $StorageAccountKey

$ContainerName = "sharename"
$x=1

$directories = Get-AzureStorageFile -ShareName $ContainerName  -Context $ctx | where {$_.GetType().Name -eq "CloudFileDirectory"} 

foreach($directory in $directories)
{
  
  $dirpath =  $directory.name
  $files = Get-AzureStorageFile -ShareName $ContainerName -path $dirpath -Context $ctx | Get-AzureStorageFile
  
   foreach($file in $Files)
   { 
    $filepath = $dirpath + "/" +  $file.name
    $destfileloc =  $file.name
    remove-AzureStorageFile -ShareName $containername -path $filepath  -Context $ctx 
    $x=$x+1
    write-output "files removed: " + $x 
   }

  
  remove-AzureStorageDirectory -ShareName @ContainerName -Path $directory.name -Context $ctx 
 
}
