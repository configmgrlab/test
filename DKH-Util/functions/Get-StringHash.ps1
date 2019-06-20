<#
.SYNOPSIS
Generate a MD5 Hash

.DESCRIPTION
Function to generate a MD5 hash from a string

.PARAMETER String
Input parameter for of the string to convert

.EXAMPLE
Get-StringHash -String test

.NOTES
===========================================================================
	 Created with: 	Visual Studio Code 1.33.1
	 Created on:   	20/06/2019
	 Created by:   	Nicholai T. Kjærgaard
	 Organization: 	Syspeople ApS
	 Filename:     	Get-StringHash.ps1
===========================================================================
#>

Function Get-StringHash 
{ 
    param
    (
        
        # Input of string to convert
        [Parameter(Mandatory)]
        [String]
        $String
    )
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($String)
    $algorithm = [System.Security.Cryptography.HashAlgorithm]::Create('MD5')
    $StringBuilder = New-Object System.Text.StringBuilder 
  
    $algorithm.ComputeHash($bytes) | 
    ForEach-Object { 
        $null = $StringBuilder.Append($_.ToString("x2")) 
    } 
  
    $StringBuilder.ToString() 
}