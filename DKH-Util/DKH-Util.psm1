try
{
  $ScriptDir = (Split-Path -parent $MyInvocation.MyCommand.Definition)
    
  Get-ChildItem "$ScriptDir\Functions\*" -Include *.ps1 -Exclude *tests.ps1 |  ForEach-Object { . $_.FullName }
}
catch
{
  "Error was $_"
  $line = $_.InvocationInfo.ScriptLineNumber
  "Error was in Line $line"
}