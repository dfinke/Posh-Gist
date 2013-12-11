function Get-GistContent {
    param(
    	[Parameter(ValueFromPipelineByPropertyName)]
    	[string]$RawUrl
    )
    
    Begin   { $Header = Get-GistAuthHeader }
    Process { Invoke-RestMethod -Uri $RawUrl -Headers $Header }
}