function Get-GistAuthHeader {

    if(!$Global:cred) { $Global:cred = Get-Credential ''}

    $authInfo = "{0}:{1}" -f $Global:cred.UserName, $Global:cred.GetNetworkCredential().Password
    $authInfo = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($authInfo))

    @{
        "Authorization" = "Basic " + $authInfo
        "Content-Type" = "application/json"
    }
}