function Get-JSKJiraProject {
    [CmdletBinding()]
    param ()
    
    begin {
        # Check if Connect-JSKJira has been run
        if (-not $Global:BaseUrl -or -not $Global:BaseHeaders) {
            throw "Connect-JSKJira has not been run. Please run Connect-JSKJira first."
        }
    }
    
    process {
        # Create the URL
        $Url = '{0}/project' -f $script:BaseUrl

        # Invoke the REST API
        $Response = Invoke-RestMethod -Uri $Url -Headers $BaseHeaders -Method Get

        # Output the response
        Write-Output $Response
    }
    
    end {}
}