function Remove-Gist {
    param(
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]$GistID
    )

    Begin { $Header = Get-GistAuthHeader }
    Process { Invoke-RestMethod -Method 'Delete' -Uri "https://api.github.com/gists/$($GistID)" -Headers $Header }
}