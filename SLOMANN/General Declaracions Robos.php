Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Dim Sess0 As Object
Dim Mensagem As String

Em Form Load digite:

Inicio do sistema. Obt�m o objeto Session necess�rio.
Set Sess0 = System.ActiveSession
If (Sess0 Is Nothing) Then
MsgBox "N�o foi poss�vel criar o objeto Session. Anulando a reprodu��o da macro."
Exit sub
End If
If Not Sess0.Visible Then Sess0.Visible = True
Set MyScreen = Sess0.Screen

Intru��es de input e output de dados no terminal
Sleep 20
MyScreen.MoveTo 3, 15 Move o cursor para linha 12, coluna 18.
Sess0.Screen.SendKeys ("commando") Insere a palavra commando na linha 12 col 18.
Sess0.Screen.SendKeys ("<Enter>") Confirma o commando com a tecla Enter.
Sleep 30
Mensagem = MyScreen.Area(1, 6, 1, 20)