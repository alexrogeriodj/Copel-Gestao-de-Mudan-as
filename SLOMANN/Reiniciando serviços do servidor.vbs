'=================================================== =========== 
'RESTARTSERVICE - User Script 
' --------------------------------- --------------------------- 
'Esse script foi projetado para permitir que os usuários finais reiniciem um serviço parado. 
'=================================================== =========== 
'CRIADO POR: rormeister - Membro do Spiceworks em geral 
' 
'NOTAS: 
' Script de chamada de .CMD (através de um atalho na área de trabalho 
do usuário 
) 'O usuário deve ter permissão para a pasta / arquivo compartilhar no servidor 'Modificar constantes "insideQuotes" para atender às suas necessidades 
' Você precisará do nome correto do serviço 
'Salvar .CMD e .VBS em uma pasta comum 
' Criar a.
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
' eco off 
' cls 
'eco ... reiniciando (seu processo) Serviço 
' eco ... pausando 10 segundos 
'eco ... essa janela será fechada automaticamente 
' eco ... não feche manualmente 
'eco ... ligue para o Suporte se você tiver problemas 
'echo    
' cscript / nologo \\ SHARESERVER \ SHAREFOLDER \ RestartServices.vbs    
'REM (observe que não há espaços no caminho / arquivo) 
' ~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~ 
' 
' CAVEAT: 
'O autor não testou este código específico, mas todas as funcionalidades foram mantidas intactas. 
'O software é fornecido COMO ESTÁ e o autor não assume nenhuma responsabilidade por ele'
Supõe-se que o usuário tenha conhecimento prático de VBScript, .CMD e outras ferramentas de manipulação do Windows. 
' 
' ================================================== ============= 
'ALTERAÇÕES: 
' 27/07/2011 - Script criado, script original 
'======================= ======================================

Option Explicit 
ON  erro  GOTO  0

'// Constantes 
Const  START_SVC  =  "ProperNameOfYourService"

«// Membros 
Dim  objWMI

'/////////////////////////////////////////////////// /////////////////////////////// 
// ENTRY POINT

'Durma por 10 segundos antes de iniciarmos o 
wScript . Sleep  10000

'Crie nosso objeto WMI para recuperar os serviços. 
Set  objWMI  =  GetObject ( "winmgmts: {impersonationLevel = personificar}! \\. \ Root \ cimv2" ) 

'Reinicie o serviço - 
chamada do  agente do bisTrack eConnect RestartServ ( START_SVC )

'Clean Up 
Set  objWMI  =  Nothing

'Saia do script 
WScript . Sair ( 0 )


'/////////////////////////////////////////////////// ///////////////////////////// 
'// METODOS / FUNÇÕES

'// StartServ: inicia um nome de serviço especificado (se existir). 
Sub  StartServ  ( sServiceName ) 
	Dim  colServices  
	Dim  objService

	'Obter coleção de serviços 
	Set  colServices  =  objWMI . ExecQuery  ( "SELECT * FROM Win32_Service WHERE Name = '"  &  sServiceName  &  "'" )  
	Se  não  ( colServices não  é  nada )  Em seguida,

		'Start Service - deve ser apenas um item na coleção Services 
		For  Each  objService  em  colServices 
			objService . StartService () 
		Avançar 
					
	Terminar  se

	'Limpeza 
	Set  colServices  =  Nothing 
	Set  objService  =  Nothing 
End  Sub

'// new section 
' Start Service 
'Não usado - deixado como exemplo do StartService que assume que o serviço está realmente parado 
strServiceName  =  "Alerter" 
Defina  objWMIService  =  GetObject ( "winmgmts: {impersonationLevel = personificar}! \ root. cimv2 " ) 
Defina  colListOfServices  =  objWMIService . ExecQuery  ( "Select * from Win32_Service Where Name = '"  &  strServiceName  &  "'" ) 
Para  Cada  objService  em  colListOfServices 
    objService .
Próximo

'// RestartServ: O mesmo que StartServ, apenas Pára primeiro, aguarda 10 segundos e inicia 
Sub  RestartServ ( sServiceName ) 
	Dim  colServices  
	Dim  objService 
	No  erro  Continuar  Avançar
	
	'Obter coleção de serviços 
	Set  colServices  =  objWMI . ExecQuery  ( "SELECT * FROM Win32_Service WHERE Name = '"  &  sServiceName  &  "'" )  
	Se  não  ( colServices não  é  nada )  Em seguida,

		'Interrompa o serviço primeiro 
		Para  Cada  objService  em  colServices 
			objService . StopService () 
		Próximo 
		
		'Aguarde 10 segundos 
		wScript . Sleep  10000
		
		'Iniciar serviço 
		Para  cada  objService  Em  colServices 
			objService . StartService () 
		Avançar
		
	Terminar  se

	'Limpeza 
	Set  colServices  =  Nothing 
	Set  objService  =  Nothing 
End  Sub