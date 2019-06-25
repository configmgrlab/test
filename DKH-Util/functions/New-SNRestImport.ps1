<#
.SYNOPSIS
Function to Create rest message to ServiceNow

.DESCRIPTION
Function to import CI's in ServiceNow from Rest

.PARAMETER UserName
Input Parameter for ServiceNow UserName

.PARAMETER Pass
Input parameter for ServiceNow Secret

.PARAMETER ImportSetTable
Input parameter for ServiceNow importset tables

.PARAMETER InstanceName
Input parameter for ServiceNow instance name

.PARAMETER Body
Input parameter for the body of a rest message

.EXAMPLE
New-SNRestImport -UserName sp-ntk -Pass PAX99pax -ImportSetTable u_building_import -InstanceName kongsvangtest -Body $Obj

.NOTES
===========================================================================
	 Created with: 	Visual Studio Code 1.33.1
	 Created on:   	20/06/2019
	 Created by:   	Nicholai T. Kjærgaard
	 Organization: 	Syspeople ApS
	 Filename:     	New-SNRestImport.ps1
===========================================================================
#>

function New-SNRestImport {
    param (
        
        # Input parameter for ServiceNow username
        [Parameter(Mandatory)]
        [string]
        $UserName,

        # Input paramter for ServiceNow Secret
        [Parameter(Mandatory)]
        [string]
        $Pass,

        # Parameter for which ServiceNow table to call
        [Parameter(Mandatory)]
        [string]
        $ImportSetTable,

        # Parameter for selecting Environment
        [Parameter(Mandatory)]
        [string]
        $InstanceName,

        # Input paramenter for the body
        [Parameter(Mandatory = $true)]
        [hashtable]
        $Body
    )

    # Eg. User name="admin", Password="admin" for this code sample.
    $user = $UserName
    $pass = $Pass

    # Build auth header
    $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $user, $pass)))

    # Set proper headers
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add('Authorization', ('Basic {0}' -f $base64AuthInfo))
    $headers.Add('Accept', 'application/json')
    $headers.Add('Content-Type', 'application/json')


    # Specify the URI
    $Uri = "https://" + $InstanceName + ".service-now.com/api/now/import/" + $ImportSetTable

    # Specify HTTP method
    $method = "post"

    # Convert body to JSON
    $JSON = ConvertTo-Json -InputObject $Body

    $JSON = [System.Text.Encoding]::UTF8.GetBytes($JSON)

    # Send HTTP request
    $response = Invoke-WebRequest -Headers $headers -Method $method -Uri $uri -Body $JSON -UseBasicParsing

    return $response

}
