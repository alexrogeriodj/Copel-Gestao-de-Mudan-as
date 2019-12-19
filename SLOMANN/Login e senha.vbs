Private Sub Comando0_Click()
'By JPaulo@2010 Janeiro
On Error Resume Next
NomeUsuario = InputBox("Exemplo: CPF 776.816.126-29", "Usuário")
SenhaUsuario = InputBox("999999", "Senha")
Dim ie As Object
Set ie = CreateObject("internetexplorer.application")
ie.Visible = True
'apiShowWindow ie.Hwnd, SW_MAXIMIZE
ie.navigate "http://nfpaulistana.prefeitura.sp.gov.br/"
While ie.Busy
DoEvents
Wend
ie.Document.All("j_username").Value = NomeUsuario
ie.Document.All("j_password").Value = SenhaUsuario

ie.Document.All("enviar").Click
SendKeys "{ENTER}", True

While ie.Busy

DoEvents
Wend

Set ie = Nothing
End Sub