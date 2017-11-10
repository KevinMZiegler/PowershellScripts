$Path = "[put path here]"
$Output  = "[put output file here"
$OutputLine 
$outputline = "Filename | Rows | Columns"
Write-output $outputline | out-file $output
#Change *.csv to appropriate file type below
ForEach ($File in (Get-ChildItem $Path -Include *.csv -Recurse))
{
  
   $outputLine = $file.FullName  
   $numberOfColumns = ((($fileData -replace "(`"[^;]+?)`r`n",'$1') -split "`r`n" | Select -First 1).split($delimiter)).Count 
   
   $outputline = $outputline + " | " + ((Get-Content $File.FullName |Measure-object -line).lines ) + " | " + $numberOfColumns
   Write-output $outputline | out-file $output -append 
   
}
