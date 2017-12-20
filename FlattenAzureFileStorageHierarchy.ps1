$StorageAccountName = "acctname" 
$StorageAccountKey = "key"

$ctx = New-AzureStorageContext -StorageAccountName $StorageAccountName  -StorageAccountKey $StorageAccountKey

#FileShare Name
$ContainerName = "ShareName" 
$destContainer = "DestShareName"


$destPath = ""

$path = "First Level folder"

$directories = Get-AzureStorageFile -ShareName $ContainerName  -Context $ctx -Path $path | where {$_.GetType().Name -eq "CloudFileDirectory"} | Get-AzureStorageFile

foreach($directory in $directories)
{
  $dirpath = $path + "/" +  $directory.name
  $files = Get-AzureStorageFile -ShareName $ContainerName -path $dirpath -Context $ctx | Get-AzureStorageFile
  
   foreach($file in $Files)
   { 
    $filepath = $dirpath + "/" +  $file.name
    $destfileloc =  $file.name
    start-azurestoragefilecopy -srcshareName $ContainerName -srcFilePath $filepath -DestShareName $destContainer -DestFilePath $destfileloc  -Context $ctx -destContext $ctx -Force
   }

  
  #optionally - 
  
  #remove-azurestoragefile  -sharename $containername -path $path2  -context $ctx 
}
