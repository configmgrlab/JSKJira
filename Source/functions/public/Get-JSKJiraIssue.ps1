function Get-JSKJiraIssue {
    [CmdletBinding()]
    param (
        # The issue key
        [Parameter(Mandatory)]
        [string]
        $IssueKey
    )
    
    begin {
        # Check if Connect-JSKJira has been run
        if (-not $Global:BaseUrl -or -not $Global:BaseHeaders) {
            throw "Connect-JSKJira has not been run. Please run Connect-JSKJira first."
        }
    } # Begin
    
    process {
        # Create the URL
        $Url = '{0}/issue/{1}' -f $BaseUrl, $IssueKey

        # Invoke the REST API
        $Response = Invoke-RestMethod -Uri $Url -Headers $BaseHeaders -Method Get

        # Output the response
        Write-Output $Response

    } # Process
    
    end {} # End
}