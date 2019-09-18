Function Get-ObjectFromXMLs {

    param (
        [parameter(mandatory=$true)]
        [string]
        $Path
    )

    [XML]$XML = Get-Content -Path $Path -Raw

    $Lines = $XML.GetElementsByTagName("LINES")
    $Rows = $XML.GetElementsByTagName("LINE")
    $Counts = 2..$Lines.RowCount

    $Header = $Rows[1]

    $Out = [System.Collections.ArrayList]::new()

    foreach ($Count in $Counts) {
     
        $Obj = @{ }
        $Row = $Rows[$Count]
        $RowLength = $Row.CELL.Length - 1
        $RowLengths = 0..$RowLength

        foreach ($Length in $RowLengths) {
            $obj.Add($Header.CELL[$Length].'#text', $Row.CELL[$Length].'#text')
        }
        $Out.Add($Obj) | Out-Null
    }
    $out
}
