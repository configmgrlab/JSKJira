function ConvertTo-JSKJiraBase64 {
    [CmdletBinding()]
    param (
        # The string to convert to Base64
        [Parameter(Mandatory)]
        [string]
        $String,

        # The encoding to use
        [Parameter(Mandatory=$false)]
        [ValidateSet("ASCII","BigEndianUnicode","Default","Latin1","Unicode","UTF32","UTF7","UTF8")]
        [string]
        $Encoding = 'UTF8'
    )
    
    begin {} # Begin
    
    process {
        # Convert the string to a byte array
        $Bytes = [System.Text.Encoding]::$Encoding.GetBytes($String)

        # Convert the byte array to a Base64 string
        $Base64 = [System.Convert]::ToBase64String($Bytes)

        # Output the Base64 string
        Write-Output $Base64
        
    } # Process
    
    end {} # End
}