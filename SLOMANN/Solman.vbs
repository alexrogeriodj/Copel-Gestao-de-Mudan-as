' Cria os objetos a serem manipulados
Dim wShell
Set wShell = CreateObject("WScript.Shell")

' Abre o site no navegador padrao
wShell.Run "http://itsmprd.copel.nt/sap(bD1wdCZjPTEwMCZkPW1pbg==)/bc/bsp/sap/crm_ui_start/default.htm"

' Tempo que ele deve esperar até o site abrir (15 segundos)
Wscript.Sleep 15000

' Preciona TAB ate chegar no usuário e senha
wshell.SendKeys "{TAB}"
WShell.SendKeys "{TAB}"
WShell.SendKeys "{TAB}"
WShell.SendKeys "{TAB}"
WShell.SendKeys "{TAB}"

wshell.SendKeys "{TAB}"
WShell.SendKeys "{TAB}"
WShell.SendKeys "{TAB}"
WShell.SendKeys "{TAB}"
WShell.SendKeys "{TAB}"

wshell.SendKeys "{TAB}"
WShell.SendKeys "{TAB}"
WShell.SendKeys "{TAB}"
WShell.SendKeys "{TAB}"
WShell.SendKeys "{TAB}"

' Inseri o usuário
WShell.SendKeys "alex.tenorio@copel.com"

' Preciona tab pra colocar a senha
WShell.SendKeys "{TAB}"

' Digita a senha
WShell.SendKeys "chinabrasil2019@"

' Preciona o Enter pra entrar no email do site
WShell.SendKeys "{ENTER}"