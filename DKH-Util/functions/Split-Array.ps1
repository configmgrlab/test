<#
.SYNOPSIS
Split array in to smaller arrays

.DESCRIPTION
Function to split array into smaller arrays

.PARAMETER InputObject
Input parameter for the array to split

.PARAMETER SplitSize
Size of the array

.EXAMPLE
Split-Array -InputObject $arr -SplitSize 10

.NOTES
Version:        0.1
Author:         ntk@syspeople.dk
Creation:       25/06/2019
Purpose/Change: First draft
#>

function Split-Array {
    param (
        
    # Input object
    [Parameter(Mandatory)]
    [System.Object[]]
    $InputObject,
    
    # Size of array
    [int]
    $SplitSize = 100
    )

    $length = $InputObject.Length

    for ($Index = 0; $Index -lt $length; $Index += $SplitSize) {
        
        
        , ($InputObject[$index..($index + $splitSize - 1)])
    }
    
}