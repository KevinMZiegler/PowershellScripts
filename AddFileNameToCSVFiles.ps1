$InputPath = "c:\temp"
$OutputPath = "E:\Output\"

ForEach ($File in (Get-ChildItem $InputPath -Include *.txt -Recurse))
{
   $OutputFilePath = $outputpath + "\" + $file.name 
 #  User -delimited below for tab delimited files
 #  Import-Csv $file.FullName -delimiter "`t"  |
   Import-Csv $file.FullName   |
   Select-Object *,@{Name='FileName';Expression={$file.fullname}} | 
   
   Export-Csv $outputfilepath  -NoTypeInformation
    


}
