‘Script de Login

On error Resume Next

Err.clear 0

‘Desconectando e Mapeando Unidades de Disco

Set WshNetwork = Wscript.CreateObject(“Wscript.Network”)

WshNetwork.RemoveNetworkDrive “E:”, True, True

WshNetwork.RemoveNetworkDrive “H:”, True, True

WshNetwork.RemoveNetworkDrive “P:”, True, True

WshNetwork.RemoveNetworkDrive “K:”, True, True

WshNetwork.MapNetworkDrive “E:”,”\\192.168.1.250\ESCOLA”,”true”

WshNetwork.MapNetworkDrive “H:”,”\\192.168.1.250\FINANCEIRO”,”true”

WshNetwork.MapNetworkDrive “P:”,”\\192.168.1.250\Publico”,”true”

WshNetwork.MapNetworkDrive “K:”,”\\192.168.1.250\DADOS”,”true”

‘Sincroniza o horario da estacao com o servidor

Set objWMIService = GetObject(“winmgmts:\\” & strComputer & “\root\CIMV2”)

Set objShell = CreateObject(“WScript.shell”)

strCmd = “net time \\192.168.1.250 /set /yes”

set objexec = objshell.exec(strcmd)

‘Criando atalhos automaticamente na área de trabalho

strAppPath = “http://192.168.1.250:9675/portal/”

Set wshShell = CreateObject(“WScript.Shell”)

objDesktop = wshShell.SpecialFolders(“Desktop”)

set oShellLink = WshShell.CreateShortcut(objDesktop & “\Help Desk – Suporte.lnk”)

oShellLink.TargetPath = strAppPath

oShellLink.WindowStyle = “1”

oShellLink.IconLocation = “\\192.168.1.250\publico\icone\spiceworks.ico”

oShellLink.Description = “Help Desk – Suporte”

oShellLink.Save

strAppPath = “\\192.168.1.250\publico\suporte\suporte.exe”

Set wshShell = CreateObject(“WScript.Shell”)

objDesktop = wshShell.SpecialFolders(“Desktop”)

set oShellLink = WshShell.CreateShortcut(objDesktop & “\Suporte Remoto.lnk”)

oShellLink.TargetPath = strAppPath

oShellLink.WindowStyle = “1”

oShellLink.IconLocation = “\\192.168.1.250\publico\suporte\spiceworks.ico”

oShellLink.WorkingDirectory = “\\192.168.1.250\publico\suporte\”

oShellLink.Description = “Suporte Remoto”

oShellLink.Save

Wscript.Quit