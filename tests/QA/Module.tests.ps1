BeforeAll {
    $rootFolder = "{0}/../.." -f $PSScriptRoot | Convert-Path

    $ProjectName = (Get-Item $rootFolder).Name
}

Describe 'Files should exist' {
    it "Should have a Functions folder" {
        $functionsFolder = "{0}/source/functions" -f $rootFolder | Convert-Path
        Test-Path $functionsFolder | Should -Be $true
    }

    It "Should have a Tests folder" {
        $testsFolder = "{0}/tests" -f $rootFolder | Convert-Path
        Test-Path $testsFolder | Should -Be $true
    }

    It "Should have a QA folder" {
        $qaFolder = "{0}/tests/QA" -f $rootFolder | Convert-Path
        Test-Path $qaFolder | Should -Be $true
    }

    It "Should have a Unit folder" {
        $unitFolder = "{0}/tests/unit" -f $rootFolder | Convert-Path
        Test-Path $unitFolder | Should -Be $true
    }

    It "Should have a Integration folder" {
        $integrationFolder = "{0}/tests/integration" -f $rootFolder | Convert-Path
        Test-Path $integrationFolder | Should -Be $true
    }

    It "Should have a Module folder" {
        $moduleFolder = "{0}/source" -f $rootFolder | Convert-Path
        Test-Path $moduleFolder | Should -Be $true
    }

    It "Should have a Module.psd1 file" {
        $moduleManifest = "{0}/source/{1}.psd1" -f $rootFolder, $ProjectName | Convert-Path
        Test-Path $moduleManifest | Should -Be $true
    }

    It "Should have a Module.psm1 file" {
        $moduleScript = "{0}/source/{1}.psm1" -f $rootFolder, $ProjectName | Convert-Path
        Test-Path $moduleScript | Should -Be $true
    }

    It "Should have a README.md file" {
        $readme = "{0}/source/README.md" -f $rootFolder | Convert-Path
        Test-Path $readme | Should -Be $true
    }

    It "Should have a build.ps1 file" {
        $buildScript = "{0}/build.ps1" -f $rootFolder | Convert-Path
        Test-Path $buildScript | Should -Be $true
    }

    It "Should have a build folder" {
        $buildFolder = "{0}/build" -f $rootFolder | Convert-Path
        Test-Path $buildFolder | Should -Be $true
    }

    it "Should have a .devcontainer folder" {
        $devcontainer = "{0}/.devcontainer" -f $rootFolder | Convert-Path
        Test-Path $devcontainer | Should -Be $true
    }

    it "Should have a .gitignore file" {
        $gitignore = "{0}/.gitignore" -f $rootFolder | Convert-Path
        Test-Path $gitignore | Should -Be $true
    }

    it "Should have a .devcontainer.json file" {
        $devcontainerJson = "{0}/.devcontainer/devcontainer.json" -f $rootFolder | Convert-Path
        Test-Path $devcontainerJson | Should -Be $true
    }

    it "Should have a Dockerfile file" {
        $dockerfile = "{0}/.devcontainer/Dockerfile" -f $rootFolder | Convert-Path
        Test-Path $dockerfile | Should -Be $true
    }
}

Describe "Module Manifest" {
    It "Should have a valid module manifest" {
        $moduleManifest = "{0}/source/{1}.psd1" -f $rootFolder, $ProjectName | Convert-Path
        $manifest = Test-ModuleManifest -Path $moduleManifest
        $manifest | Should -Be $true
    }

    It "Should import the module" {
        $moduleManifest = "{0}/source/{1}.psd1" -f $rootFolder, $ProjectName | Convert-Path
        $module = Import-Module -Name $moduleManifest -PassThru
        $module | Should -Not -Be $null
    }

    It should "Name should be the same as the name in psd1" {
        $moduleManifest = "{0}/source/{1}.psd1" -f $rootFolder, $ProjectName | Convert-Path
        $manifest = Import-Module -Name $moduleManifest -PassThru
        $manifest.Name | Should -Be 'JSKJira'
    }
}