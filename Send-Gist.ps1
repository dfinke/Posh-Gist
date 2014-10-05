function Send-Gist {
    param([string]$Path, [string]$Description)

    if($Path) {
        if (Test-Path -Path $Path) {
            $fileName = Split-Path -Path $Path -Leaf
            $contents = Get-Content -Path $Path -Raw
        }
        
        else {
            Write-Warning "$($Path) not found"
            break
        }
    }

    else {
        if($psISE) {
            $fileName = Split-Path -Leaf $psISE.CurrentFile.FullPath

            if($psISE.CurrentFile.Editor.SelectedText) {
                $contents = $psISE.CurrentFile.Editor.SelectedText
            }

            else {
                $contents = $psISE.CurrentFile.Editor.Text
            }
        }

        else {
            Write-Warning 'Using this function without the Path parameter only works in PowerShell ISE'
            break
        }
    }

    if($Description) {
        $gistDescription = $Description
    }
    
    else {
        $gistDescription = "Description for $($fileName)"
    }

    $gist = @{
      'description' = $gistDescription
      'public' = $true
      'files' = @{
        "$($fileName)" = @{
          'content' = "$($contents)"
        }
      }
    }

    $Header = Get-GistAuthHeader 
 
    $BaseUri = $Uri = 'https://api.github.com/gists'    
    $Method  = 'POST'
 
    $targetGist = Get-Gist $Global:GitHubCred.UserName $fileName
    if($targetGist) {
 
        $r = [System.Windows.MessageBox]::Show('Gist already exists. Do you want to overwrite?', 'Confirmation', 'YesNo', 'Question')
        
        if($r -eq 'no') {return}

        $Uri = $BaseUri + "/$($targetGist.GistID)" 
        $Method = 'Patch'
    }

    $resp = Invoke-RestMethod -Uri $Uri -Method $Method -Headers $Header -Body ($gist | ConvertTo-Json)

    Start-Process $resp.'html_url'
}