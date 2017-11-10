$Path = "[put path here]"
$Output  = "[put output file here"
$OutputLine 
$outputline = "Filename | Rows | Columns"
Write-output $outputline | out-file $output
#Change *.csv to appropriate file type below
ForEach ($File in (Get-ChildItem $Path -Include *.csv -Recurse))
{
  
   $outputLine = $file.FullName  
   $numberOfColumns = ((([array](get-content $file))[0]) -split ",").count
   
   $outputline = $outputline + " | " + ((Get-Content $File.FullName |Measure-object -line).lines ) + " | " + $numberOfColumns
   Write-output $outputline | out-file $output -append 
   
}
