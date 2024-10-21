Describe 'Connect-JSKJira Tests' {
    BeforeAll {
        # Assuming ConvertTo-JSKJiraBase64 is a function that needs to be mocked
        Mock ConvertTo-JSKJiraBase64 { return 'mockedBase64' }

        # Import the Connect-JSKJira function
        . /workspaces/JSKJira/functions/public/Connect-JSKJira.ps1
    }

    It 'Connects to Prod Server correctly' {
        $securePassword = ConvertTo-SecureString 'dummyToken' -AsPlainText -Force
        Connect-JSKJira -UserName 'dummyUser' -PAT $securePassword -Server 'Prod'
        $script:BaseUrl | Should -Be 'https://jskprod.atlassian.net/rest/api/3'
        $script:BaseHeaders.Authorization | Should -Be 'Basic mockedBase64'
    }

    It 'Connects to Dev Server correctly' {
        $securePassword = ConvertTo-SecureString 'dummyToken' -AsPlainText -Force
        Connect-JSKJira -UserName 'dummyUser' -PAT $securePassword -Server 'Dev'
        $script:BaseUrl | Should -Be 'https://jysk-sandbox-974.atlassian.net/rest/api/3'
        $script:BaseHeaders.Authorization | Should -Be 'Basic mockedBase64'
    }

    It 'Fails without mandatory parameters' {
        { Connect-JSKJira } | Should -Throw
    }

    It 'Handles invalid server parameter' {
        $securePassword = ConvertTo-SecureString 'dummyToken' -AsPlainText -Force
        { Connect-JSKJira -UserName 'dummyUser' -PAT $securePassword -Server 'Invalid' } | Should -Throw
    }
}