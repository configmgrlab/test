<#
.SYNOPSIS
Function to Create rest message to ServiceNow

.DESCRIPTION
Function to import CI's in ServiceNow from Rest

.PARAMETER UserName
Input Parameter for ServiceNow UserName

.PARAMETER Pass
Input parameter for ServiceNow Secret

.PARAMETER ImportSet
Parameter for selection of importset table

.PARAMETER Environment
Parameter for selecting ServiceNow environment

.PARAMETER Body
Input parameter for the body of a rest message

.EXAMPLE
New-SNRestImport -UserName sp-ntk -Pass Password -ImportSet Building -Environment Production -Body $output 

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
        [ValidateSet("Rooms", "Building")]
        $ImportSet,

        # Parameter for selecting Environment
        [Parameter(Mandatory)]
        [ValidateSet("Prod","Test")]
        $Environment,

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

    # Specify table to call
    switch ($ImportSet) {
        "Rooms" {
            $ImportSet = "u_room_import"
        }
        "Building" {
            $ImportSet = "u_building_import"
        }
    }

    # Specify environment to call
    switch ($Environment) {
        "Prod" {
            $Uri = "https://kongsvang.service-now.com/api/now/import/"+$ImportSet
        }
        "Test" {
            $Uri = "https://kongsvang.service-now.com/api/now/import/"+$ImportSet
        }
    }

    # Specify HTTP method
    $method = "post"

    # Convert body to JSON
    $JSON = ConvertTo-Json -InputObject $Body

    $JSON = [System.Text.Encoding]::UTF8.GetBytes($JSON)

    # Send HTTP request
    $response = Invoke-WebRequest -Headers $headers -Method $method -Uri $uri -Body $JSON -UseBasicParsing

    return $response

}