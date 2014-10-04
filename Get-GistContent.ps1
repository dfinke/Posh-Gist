function Get-GistContent {
    param(
    	[Parameter(ValueFromPipelineByPropertyName)]
    	[string]$RawUrl,

        [Parameter()]
        [switch]$SendToISE
    )
    
    Begin   { $Header = Get-GistAuthHeader }

    Process {
        $gistContent = Invoke-RestMethod -Uri $RawUrl -Headers $Header

        if($SendToISE) {
            $newISETab = $psISE.CurrentPowerShellTab.Files.Add()
            $newISETab.Editor.Text = $gistContent
            $newISETab.Editor.SetCaretPosition(1,1)
        }

        else {
            Write-Output $gistContent
        }
    }
}