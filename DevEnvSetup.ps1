$scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

function Install-NeededFor {
    param(
        [string] $packageName = ''
        , [bool] $defaultAnswer = $true
    )
    if ($packageName -eq '') { return $false }

    $yes = '6'
    $no = '7'
    $msgBoxTimeout = '-1'
    $defaultAnswerDisplay = 'Yes'
    $buttonType = 0x4;
    if (!$defaultAnswer) { $defaultAnswerDisplay = 'No'; $buttonType = 0x104; }

    $answer = $msgBoxTimeout
    try {
        $timeout = 10
        $question = "Do you need to install $($packageName)? Defaults to `'$defaultAnswerDisplay`' after $timeout seconds"
        $msgBox = New-Object -ComObject WScript.Shell
        $answer = $msgBox.Popup($question, $timeout, "Install $packageName", $buttonType)
    }
    catch {
    }

    if ($answer -eq $yes -or ($answer -eq $msgBoxTimeout -and $defaultAnswer -eq $true)) {
        write-host "Installing $packageName"
        return $true
    }

    write-host "Not installing $packageName"
    return $false
}

if (Install-NeededFor 'chocolatey') {
    Invoke-Expression ((new-object net.webclient).DownloadString("http://chocolatey.org/install.ps1"))
}

if (Install-NeededFor 'vscode') {
    cinst vscode -y
    cinst vscode-powershell -y
    cinst vscode-csharp -y
    cinst vscode-editorconfig -y
    cinst vscode-docker -y
    cinst chocolatey-vscode -y
}

if (Install-NeededFor 'golang') {
    cinst golang -y
}

if (Install-NeededFor 'python') {
    cinst python2 -y
}

if (Install-NeededFor 'nodejs') {
    cinst nodejs -y

    if (Install-NeededFor 'angular cli') {
    	Invoke-Expression "refreshenv"
        Invoke-Expression "npm install -g @angular/cli"
    }
}

if (Install-NeededFor 'docker') {
    cinst docker-desktop -y
    cinst docker-kitematic -y
}

if (Install-NeededFor 'kubernetes') {
    cinst kubernetes-cli -y
    cinst kubernetes-helm -y
}

write-host "Installing required dotnet frameworks"
cinst dotnet-version -y
cinst dotnetcore-sdk -y

write-host "Installing general development tools"
cinst git -y
cinst cmder -y
cinst notepadplusplus.install -y
cinst sublimetext3 -y
cinst postman -y
cinst tortoisegit -y

write-host "Installing web browsers"
cinst googlechrome -y
cinst firefox -y

write-host "Installing chat apps"
cinst slack -y
cinst discord -y

write-host "Installing misc applications"
cinst evernote -y
cinst vlc -y
cinst winrar -y
cinst spotify -y

write-host "Refreshing environment variables in current window"
Invoke-Expression "refreshenv"

write-host "Copying .gitconfig"
New-Item $HOME\.gitconfig -type file -value ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/Jbond312/DevEnvSetup/master/.gitconfig'))

write-host "Copying .bashrc"
New-Item $HOME\.bashrc -type file -value ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/Jbond312/DevEnvSetup/master/.bashrc'))

Invoke-Expression "refreshenv"

Write-Host "Enabling the Linux subsystem"
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -All -NoRestart

Write-Host "Enabling Hyper-V"
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart

Write-Host "Finished setting up environment"
