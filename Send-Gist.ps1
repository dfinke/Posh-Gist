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
 
    $BaseUri = $Uri = "https://api.github.com/gists"    
    $Method  = 'POST'
 
    $targetGist = Get-Gist $Global:cred.UserName $fileName
    if($targetGist) {
 
        $r=[System.Windows.MessageBox]::Show("Gist already exists. Do you want to overwrite?", "Confirmation", "YesNo", "Question")
        
        if($r -eq "no") {return}

        $Uri = $BaseUri + "/$($targetGist.GistID)" 
        $Method = "Patch"
    }

    $resp = Invoke-RestMethod -Uri $Uri -Method $Method -Headers $Header -Body ($gist | ConvertTo-Json)

    Start-Process $resp.'html_url'
}