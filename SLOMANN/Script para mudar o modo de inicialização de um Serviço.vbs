'Script para mudar os serviços .NET Optmization (qualquer versão) para o modo de inicialização Manual
'Útil para evitar os alertas dos sistemas de monitoramento NetIQ, Prognosis e outros
strComputer = InputBox ("Digite o nome do servidor:", "Nome da Empresa")
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\CimV2") 
Set colListOfServices = objWMIService.ExecQuery ("Select * from Win32_Service Where Name Like 'clr_optimization%'")
  For Each objService in colListOfServices
    objService.ChangeStartMode("Manual")
    Wscript.Sleep 5000
    errReturnCode = objService.StartService()
  Next
MsgBox "Pronto! O Serviço foi alterado para Manual."