On Error Resume Next

Dim objFSO, objFSO1, objFSO2, outFile, outFile2, strTextFile, strData, arrLines, host, host1

CONST ForReading = 1
 'Abrir arquivo servers.txt e efetuar leitura dos nomes dos servidores
 strTextFile = "servers.txt"
 Set objFSO1 = CreateObject("Scripting.FileSystemObject")
 strData = objFSO1.OpenTextFile(strTextFile,ForReading).ReadAll
 arrLines = Split(strData,vbCrLf)

'Geração de um arquivo de log de erros, onde os hostnames que não pingam serão inclusos.
 strFileName2 = "log_erro.txt"
 Set objFSO2 = CreateObject("Scripting.FileSystemObject")
 Set outFile2 = objFSO2.OpenTextFile(strFileName2, 2, True)
 outfile2.writeline "Hosts não encontrados"

'Para efetuar pesquisa onde se digita o servername em vez de buscar em um TXT,
 'deve-se comentar a Linha FOR abaixo e a linha host = cstr, e descomentar host =inputbox
 'tambem comentar o next no final do script

For Each host1 in arrLines
	host = cstr(host1)
	'host= InputBox("Digite o nome do host ou IP: ", "Plano de Produção ", "127.0.0.1")
	'Criação do txt com nome do host para relatório.
	strFileName = host & ".txt"

	'Verificação da existência do host (se o mesmo pinga) - e report no arquivo de log em caso de falha.
	Set WshShell = WScript.CreateObject("WScript.Shell")
		theCmd = "ping " & host & " -n 1 -w 9999"
		Return = WshShell.Run(theCmd, 0, true)
	If Return <> 0 Then
		outfile2.writeline "" & host
		hostcount = 1
	End If

	'A verificação do hostcount serve para não gerar hostname.txt de hosts que não estão pingando, obviamente com resultado em branco.
	If hostcount <> 1 then
		Set objFSO = CreateObject("Scripting.FileSystemObject")
		Set outFile = objFSO.OpenTextFile(strFileName, 2, True)
		strComputer = host
		Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\CIMV2")
		Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_ComputerSystem")
		Set objWMIDateTime = CreateObject("WbemScripting.SWbemDateTime")
		'Início da geração do relatório em TXT
		For Each objItem in colItems
			outFile.WriteLine "-------------------------------------------------------"
			outFile.WriteLine "### Plano de Produção semanal Servidor:  " & objItem.Name & " ###"
			outFile.WriteLine "-------------------------------------------------------"
			outFile.WriteLine "" & vbCrLf
			'HOST
			outFile.WriteLine "# INFORMAÇÕES DO HOST: "
			outFile.WriteLine "-------------------------------------------------------"
			outFile.WriteLine "" & vbCrLf
			theCmd = "ping " & host & " -n 1 -w 9999"
			Return = WshShell.Run(theCmd, 0, true)
			If Return = 0 Then
				outFile.WriteLine "Status: ONLINE"
				outFile.WriteLine "HostName: " & objItem.Name
				outFile.WriteLine "DNSName: " & objItem.DNSHostName '
				outFile.WriteLine "Domain: " & objItem.Domain
				outFile.WriteLine "Workgroup: " & objItem.Workgroup '
				outFile.WriteLine "" & vbCrLf
			End If
		Next
		'SISTEMA OPERACIONAL
		outFile.WriteLine "# SISTEMA OPERACIONAL: "
		outFile.WriteLine "-------------------------------------------------------"
		outFile.WriteLine "" & vbCrLf

		Set colOS = objWMIService.InstancesOf("Win32_OperatingSystem")
			For each objOS in colOS
				objWMIDateTime.Value = objOS.LastBootUpTime
				LastBoot = objWMIDateTime.GetVarDate
				TimeUp = TimeSpan(objWMIDateTime.GetVarDate,Now) & " (hh:mm:ss)"
			Next
		Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_OperatingSystem")
			For Each objItem in colItems
				cInstdate = CStr(objItem.InstallDate)
				outFile.WriteLine "Sistema Operacional: " & objItem.Caption
				outFile.WriteLine "Service Pack: " & objItem.ServicePackMajorVersion
				outFile.WriteLine "Dir. Sistema: " & objItem.SystemDirectory
				outFile.WriteLine "Data da Instalacao: " & Mid(cInstDate, 7, 2) & "/" & Mid(cInstDate, 5, 2) & "/" &  Mid(cInstDate, 1, 4) & " (" &    objItem.InstallDate & ")"
				outFile.WriteLine "Último Boot: " & LastBoot
				outFile.WriteLine "Tempo Ligado: " & TimeUp
				outFile.WriteLine "Organização: " & objItem.Organization
				outFile.WriteLine "Registro: " & objItem.RegisteredUser & VbCrLf
			Next
		outFile.WriteLine "" & vbCrLf

		'SERVIÇOS DO WINDOWS
		outFile.WriteLine "# SERVIÇOS: "
		outFile.WriteLine "-------------------------------------------------------"
		outFile.WriteLine "" & vbCrLf

		Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
		Set colRunningServices = objWMIService.ExecQuery("SELECT * FROM Win32_Service WHERE StartMode = 'Auto'")
			For Each objService in colRunningServices
				outFile.WriteLine objService.State & VbTab & VbTab & objService.DisplayName
			Next
		outFile.WriteLine vbCrLf & vbCrLf

		'SOFTWARES
		outFile.WriteLine "# SOFTWARES: "
		outFile.WriteLine "-------------------------------------------------------"
		outFile.WriteLine "" & vbCrLf
		Set oShell = CreateObject("wscript.Shell")
		Set env = oShell.environment("Process")
		Const HKEY_LOCAL_MACHINE = &H80000002
		Const UnInstPath = "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\"
		Set oReg=GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\default:StdRegProv")
		oReg.EnumKey HKEY_LOCAL_MACHINE, UnInstPath, arrSubKeys

		For Each subkey In arrSubKeys
			If Left (subkey, 1) <> "{" Then 'Para não listar as aplicações com chamadas de chave
			If Left (subkey, 2) <> "KB" Then 'Para não listar os KBs da Microsoft
			software = software & subkey & vbCrLf
		End If
	End If
 Next

'em separado listando apenas KBs da Microsoft
outFile.WriteLine software
outFile.WriteLine "# UPDATES MICROSOFT: "
outFile.WriteLine "-------------------------------------------------------"
outFile.WriteLine "" & vbCrLf
For Each subkey In arrSubKeys
	If Left (subkey, 1) <> "{" Then 'Para não listar as aplicações com chamadas de chave
		If Left (subkey, 2) = "KB" Then 'Para listar os KBs da Microsoft
			kbs = kbs & subkey & " "
		End If
	End If
Next

outFile.WriteLine kbs

' Finalizar variáveis
 Set objFSO = Nothing
 Set objFSO1 = Nothing
 Set objFSO2 = Nothing
 Set outFile = Nothing
	'Descomentar as linhas abaixo para quando a pesquisa for de 1 server sem leitura no servers.txt Isso exibirá o [hostname].txt aberto em tela.
	WshShell.Run("notepad.exe " & host & ".txt")
	'O Else abaixo zera o hostcount, pois caso uma máq não pingue, o hostcount será 1, e aqui zera o processo para o novo host.
Else
	hostcount = 0
End if

Next

Function TimeSpan(dt1, dt2)
	If (isDate(dt1) And IsDate(dt2)) = false Then
		TimeSpan = "00:00:00"
		Exit Function
        End If
        seconds = Abs(DateDiff("S", dt1, dt2))
        minutes = seconds \ 60
        hours = minutes \ 60
        minutes = minutes mod 60
        seconds = seconds mod 60

    If len(hours) = 1 then hours = "0" & hours

	TimeSpan = hours & ":" & _
    RIGHT("00" & minutes, 2) & ":" & _
    RIGHT("00" & seconds, 2)
End Function

 WScript.Echo "Concluído!"