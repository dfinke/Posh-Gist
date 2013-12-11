function Test-Gist {
    param(
        [Parameter(Mandatory)]        
        [string]$FileName
    )    

    Get-GistAuthHeader | Out-Null    
    (Get-Gist $Global:cred.UserName $FileName) -ne $null
}