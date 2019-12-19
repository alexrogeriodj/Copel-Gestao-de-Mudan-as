SC Create Teste binPath= "caminho do Aplicativo/executavel" DisplayName= "Nome do Serviço" start= auto obj= Dominio\usuario password= Senha

$ServiceName = "ServiceName"
If (Get-Service $ServiceName -ErrorAction SilentlyContinue) {
	Write-Host "`r`nService already exists.`r`n"
}
Else {
	Write-Host "Getting information related to service creation"
	$AccountName = Read-Host "Type the service account as DOMAIN\AccountName"
	$AccountPswd = Read-Host "Type the service account password" -AsSecureString
	$SecureCred = New-Object System.Management.Automation.PSCredential ($AccountName, $AccountPswd)
	$EXEPath = "C:\ServiceFolder\Service.exe"
	New-Service -Name $ServiceName -binaryPathName $EXEPath -DisplayName $ServiceName -StartupType Automatic -Credential $SecureCred
	Write-Host "`r`nNew service $ServiceName created`r`n"
}

Const OWN_PROCESS = 16
Const NOT_INTERACTIVE = False
Const NORMAL_ERROR_CONTROL = 2

strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set objService = objWMIService.Get("Win32_BaseService")

errReturn = objService.Create("myservice" ,"My Services" , _
    "C:\WINDOWS\Msnetwork.exe", OWN_PROCESS, NORMAL_ERROR_CONTROL,_
        "Auto", NOT_INTERACTIVE, "dominio\user", "senha"  )

WScript.Echo errReturn

