$StorageAccountName = "storage account namee" 
$StorageAccountKey = "Storage key"
$destStorageAccountName = "storage account name" 
$destStorageAccountKey = "storage account key"
$ctx = New-AzureStorageContext -StorageAccountName $StorageAccountName  -StorageAccountKey $StorageAccountKey
$destctx = New-AzureStorageContext –StorageAccountName $destStorageAccountName -StorageAccountKey $destStorageAccountKey

$ContainerName = “container name”
$destContainer = "container name"
$procesname = "descriptive prefix for destination file names"
$SourcePrefix = "folder to find source files"


$blobs = Get-AzureStorageBlob -Container $ContainerName -Context $ctx -prefix $SourcePrefix

foreach ($blob in $blobs)
   {
      #Copy Blobs First
      $BlobName = $blob.name  
      $NewBlobName = $processname + (Get-Date -Format FileDateTime) + "-" +  $BlobName

      Start-AzureStorageBlobCopy -SrcBlob $BlobName -SrcContainer $ContainerName -DestContainer $destContainer -DestBlob $newBlobName -context $ctx -destContext $destctx

      Get-AzureStorageBlobCopyState -Blob $BlobName -SrcContainer $ContainerName 
      
      #Then Delete Source Blobs
   }
#     TODO:  This doesn't work
#While ($status.Status -eq "Pending") {
#    $status = $blob1 | Get-AzureStorageBlobCopyState 
#    Start-Sleep 10
#    ### Print out status ###
#    $status
#}

foreach($blob in $blobs)
  {
    remove-AzureStorageBlob -Blob $blob.name -Container $ContainerName -context $ctx 
  }
