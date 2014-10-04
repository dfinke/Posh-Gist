function Get-GistAuthHeader {

    if(!$Global:GitHubCred) { $Global:GitHubCred = Get-Credential ''}

    $authInfo = "{0}:{1}" -f $Global:GitHubCred.UserName, $Global:GitHubCred.GetNetworkCredential().Password
    $authInfo = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($authInfo))

    @{
        'Authorization' = 'Basic ' + $authInfo
        'Content-Type' = 'application/json'
    }
}