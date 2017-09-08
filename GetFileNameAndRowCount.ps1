$Path = "[put path here]"
$Output  = "[put output file here"
$OutputLine 
$outputline = "Filename | Rows"
Write-output $outputline | out-file $output
#Change *.csv to appropriate file type below
ForEach ($File in (Get-ChildItem $Path -Include *.csv -Recurse))
{
  
   $outputLine = $file.FullName  
    
   $outputline = $outputline + " | " + ((Get-Content $File.FullName |Measure-object -line).lines )
   Write-output $outputline | out-file $output -append 
   
}
