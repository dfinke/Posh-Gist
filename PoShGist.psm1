. (Join-Path $PSScriptRoot Get-Gist.ps1)
. (Join-Path $PSScriptRoot Get-GistAuthHeader.ps1)
. (Join-Path $PSScriptRoot Get-GistContent.ps1)
. (Join-Path $PSScriptRoot Send-Gist.ps1)

function Add-MenuItem {
    param([string]$DisplayName, $SB, $ShortCut)

    $menu=$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus | Where {$_.DisplayName -Match $DisplayName}

    if($menu) {
        [void]$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Remove($menu)
    }

    [void]$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Add($DisplayName, $SB, $ShortCut)
}

Add-MenuItem "_Send Gist" { Send-Gist } "CTRL+Shift+S"