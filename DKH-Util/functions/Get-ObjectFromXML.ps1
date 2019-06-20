<#
.SYNOPSIS
Return an array from XML

.DESCRIPTION
Function to create an array of hashtables from a XML file

.PARAMETER Path
Path for the XML files

.EXAMPLE
Get-ObjectFromXML -Path C:\ServiceNow\DKH\Levels.xml

.NOTES
===========================================================================
	 Created with: 	Visual Studio Code 1.33.1
	 Created on:   	20/06/2019
	 Created by:   	Nicholai T. Kjærgaard
	 Organization: 	Syspeople ApS
	 Filename:     	Get-ObjectFromXMl.ps1
===========================================================================
#>

function Get-ObjectFromXML {
    
    param (
        # Path for XML files
        [Parameter(Mandatory = $true)]
        [string]
        $Path
    )

    [XML]$XML = Get-Content -Path $Path -Raw

    # 
    $Lines = $XML.GetElementsByTagName("LINES")

    # 
    $Rows = $XML.GetElementsByTagName("LINE")

    $Header = $Rows[1]

    $out = [System.Collections.ArrayList]::new()

    for ($i = 2; $i -lt $Lines.RowCount; $i++) {

        $obj = @{ }
        $row = $Rows[$i]

        for ($j = 0; $j -lt $row.CELL.Length; $j++) {
            
            $obj.Add($Header.CELL[$j].'#text', $row.CELL[$j].'#text')
        }

        $null = $out.Add($obj)
        
    }

    return $out
    
}