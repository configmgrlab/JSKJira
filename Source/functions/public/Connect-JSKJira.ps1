function Connect-JSKJira {
    [CmdletBinding()]
    param (
        # username
        [Parameter(Mandatory)]
        [string]
        $UserName,

        # Personal Access Token
        [Parameter(Mandatory)]
        [securestring]
        $PAT,

        # Jira Server
        [Parameter(Mandatory)]
        [ValidateSet('Prod', 'Dev')]
        [string]
        $Server
    )
    
    begin {
        switch ($Server) {
            Prod { $InstanceName = 'jskprod' }
            Dev { $InstanceName = 'jysk-sandbox-974' }
        }
    } # Begin
    
    process {

        # Create the credential object
        $Credential = ConvertTo-JSKJiraBase64 -String ('{0}:{1}' -f $UserName, (ConvertFrom-SecureString -SecureString $PAT -AsPlainText))

        # Configure the base URL
        $BaseUrl = 'https://{0}.atlassian.net/rest/api/3' -f $InstanceName

        # Create Jira Header
        $Headers = @{
            Authorization = 'Basic {0}' -f $Credential
        }

        # Add base header to script scope
        $script:BaseHeaders = $Headers
        $script:BaseUrl = $BaseUrl

        Write-Output "Connected to Jira Server: $Server"
    } # Process
    
    end {} # End
}