<powershell>

#Function to store log data
function Write-Log {
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$Message
    )
    [pscustomobject]@{
        Time = (Get-Date -f g)
        Message = $Message
    } | Export-Csv -Path "c:\UserDataLog\UserDataLogFile.log" -Append -NoTypeInformation
 }
#Read input variables
$ServerName = "${ServerName1}"

#Create log file location
if (-not(Test-Path "C:\UserDataLog"))
{
    New-Item -ItemType directory -Path "C:\UserDataLog"
    Write-Log -Message "Created folder to store log file."
} else {
    Write-Log -Message "Folder already exists."
}
#Userdata location
Write-Log -Message "Userdata is stored at : $PSScriptRoot"
Write-Log -Message "Userdata script is stored at : $PSScriptRoot"

if (-not(Test-Path "C:\Program Files\Notepad++\notepad++.exe"))
{
Write-Log -Message "Download and install Notepad++"    
cd c:\UserDataLog
Invoke-WebRequest https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.3.3/npp.8.3.3.Installer.x64.exe -OutFile npp.8.3.3.Installer.x64.exe
.\npp.8.3.3.Installer.x64.exe /S
sleep 30
}

<#
#Check Windows feature 
if ((Get-WindowsFeature Web-Server).installed -ne 'True')
{
    Write-Log -Message "Windows feature is not installed and will be installed."
    Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature

    echo '<h1><center>TerraFrom is cool with Windows!!!!</center></h1>' > C:\inetpub\wwwroot\iisstart.htm

} else
{
    Write-Log -Message "Windows feature is already installed."
}
#>

#Check Computer ServerName
if ($env:COMPUTERNAME -eq $ServerName1)
{
    Write-Log -Message "The name of the machine is correct: $env:COMPUTERNAME"
} else {
    Write-Log -Message "The name of the machine is incorrect and needs to change from $env:COMPUTERNAME to $ServerName."
    Rename-Computer -NewName $ServerName -Restart -Force
    Write-Log -Message "The machine will be renamed and restarted."
}
</powershell>
# <persist>true</persist>