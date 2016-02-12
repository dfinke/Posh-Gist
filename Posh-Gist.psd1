# Module manifest for module Posh-Gist
# Generated by: Josh Einstein
# Generated on: 2016-02-12

@{

    Description = "Fork of Doug Finke's Posh-Gist module."
    ModuleVersion = '1.0'
    GUID = 'bd4390dc-a8ad-4bce-8d69-f53ccf8e4163'
    Author = 'Doug Finke'
    CompanyName = ''
    Copyright = ''


    RequiredModules = @()
    RequiredAssemblies = @()

    RootModule = 'PoshGist.psm1'
    ScriptsToProcess = @()
    TypesToProcess = @()
    FormatsToProcess = @()
    NestedModules = @()

    FunctionsToExport = @(
        'Get-Gist'
        'Get-GistAuthHeader'
        'Get-GistContent'
        'Remove-Gist'
        'Send-Gist'
        'Test-Gist'
    )
    #CmdletsToExport = '*'
    #VariablesToExport = '*'
    #AliasesToExport = '*'

}
