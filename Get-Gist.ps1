function Get-Gist {
    
    param(
        [Parameter(Mandatory)]
        [string]$User,
        [string]$FileName
    )    

    $(ForEach($gist in (Invoke-RestMethod -Headers (Get-GistAuthHeader) -Uri "https://api.github.com/users/$($User)/gists")) {

        $GetFileName = {($gist.files| Get-Member -MemberType NoteProperty).Name}
        [PSCustomObject]@{            
            FileName = &$GetFileName
            Url      = $gist.url
            RawUrl   = ($gist.files).(&$GetFileName).raw_url
            GistID   = Split-Path -Leaf $gist.url
        }
    }) | Where-Object {$_.FileName -match $FileName}
}