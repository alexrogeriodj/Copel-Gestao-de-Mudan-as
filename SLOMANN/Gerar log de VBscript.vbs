' Ajuste o número de psts a serem feitos backup. *Obs.: comece por 0* '

ReDim pst(0)

' Defina o local referente a cada arquivo a ser feito backup '

pst(0) = "C:\Users\teste-pc-1\Documents\Arquivos do Outlook\backup1"

' Defina o local onde serão copiados os psts '

BackupPath = "C:\Users\teste-pc-1\Desktop\Backup Shaddai\backup\"

' Escolha entre manter ou não backups antigos. Use TRUE/FALSE '

KeepHistory = TRUE

' Tempo em milisegundos para que o Outlook feche '

delay = 30000

'Escolha entre iniciar ou não o Outlook do processo. Use TRUE/FALSE '

start = TRUE

sleepTime=10


Set objShell = CreateObject("WScript.Shell")

X = objShell.Popup("Seu Microsoft Outlook será finalizado em "& sleepTime &" segundos para execução do backup dos e-mails, por favor feche-o adequadamente para evitar problemas de perda de dados.", sleepTime, "Backup", 0)

Set WshShell = WScript.CreateObject("WScript.Shell") 
Set fso = CreateObject("Scripting.FileSystemObject") 
Set objOutputFile = fso.OpenTextFile("temp.vbs", 2, -1) 
objOutputFile.WriteLine "Wscript.echo ""O processo de backup está em andamento. Em instantes o Outlook abrirá"""
objOutputFile.WriteLine "Wscript.quit"
objOutputFile.Close 
WshShell.Run "temp.vbs", 1, False 


' Fechar Outlook '
Call CloseOutlook(delay)

Call BackupPST(pst, BackupPath, KeepHistory)

' Abrir Outlook após o processo '
If start = TRUE Then
  Call OpenOutlook()
End If


Sub CloseOutlook(delay)
  strComputer = "."
  Set objWMIService = GetObject("winmgmts:" _
  & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

  ' Fechar Outlook de forma não agressiva '
  For Each Process in objWMIService.InstancesOf("Win32_Process")
    If StrComp(Process.Name,"OUTLOOK.EXE",vbTextCompare) = 0 Then
      Set objOutlook = CreateObject("Outlook.Application")
      objOutlook.Quit
      WScript.Sleep delay
      Exit For
    End If
  Next

  ' Checagem se o Outlook estiver aberto '
  ' Se sim, será forçado o fechamento '

  Set colProcessList = objWMIService.ExecQuery _
  ("Select * from Win32_Process Where Name = 'Outlook.exe'")
  For Each objProcess in colProcessList
    objProcess.Terminate()
  Next
  Set objWMIService = Nothing
  Set objOutlook = Nothing
  set colProcessList = Nothing
End Sub

' Criação da pasta com o nome yy-mm-dd '

Sub BackupPST(pst, BackupPath, KeepHistory)
  Set fso = CreateObject("Scripting.FileSystemObject")

  If KeepHistory = True Then
    ArchiveFolder = Year(Now) & "-" & Month(Now) & "-" & Day(Now)
    BackupPath = BackupPath & ArchiveFolder & "\"
  End If

 ' Caso a pasta já exista, os arquivos dentro dela serão atualizados '

  If fso.FolderExists(BackupPath) = False Then
    fso.CreateFolder BackupPath
  End If

  For Each pstPath in pst
    If fso.FileExists(pstPath) Then
      fso.CopyFile pstPath, BackupPath, True
    End If
  Next
  Set fso = Nothing
End Sub


' Outlook será aberto '
Sub OpenOutlook()
  Set objShell = CreateObject("WScript.Shell")
  objShell.Run "Outlook.exe"
End Sub