function Send-Gist {

    $fileName = Split-Path -Leaf $psISE.CurrentFile.FullPath
    $contents = $psISE.CurrentFile.Editor.Text

    $gist = @{
      "description"="Description for $($fileName)"
      "public"= $true
      "files"= @{
        "$($fileName)"= @{
          "content"= "$($contents)"
        }
      }
    }

    $Header = Get-GistAuthHeader
 
    $targetGist = Get-Gist $Global:cred.UserName $fileName
    if($targetGist) {
        $resp = Invoke-RestMethod -Uri "https://api.github.com/gists/$($targetGist.GistID)" -Method Patch -Headers $Header -Body ($gist | ConvertTo-Json)
    } else {    
        $resp = Invoke-RestMethod -Uri 'https://api.github.com/gists' -Method Post -Headers $Header -Body ($gist | ConvertTo-Json)
    }

    Start-Process $resp.'html_url'
}