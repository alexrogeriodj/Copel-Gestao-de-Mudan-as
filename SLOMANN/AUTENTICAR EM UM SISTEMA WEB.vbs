Sub x()
Dim ie As InternetExplorer
Dim C
Dim ULogin As Boolean, ieForm
Dim MyPass As String, MyLogin As String
redo:
MyLogin = Application.InputBox("Por Favor entre com o Login", "Minha caixa de e-mails", Default:="xxx@sercomtel.com.br", Type:=2)
MyPass = Application.InputBox("Por favor entre com a senha", "Senha", Default:="yyy", Type:=2)
If MyLogin = "" Or MyPass = "" Then GoTo redo
Set ie = New InternetExplorer
ie.Visible = True
ie.Navigate "https://webmail.sercomtel.com.br/src/login.php"

Do Until ie.ReadyState = READYSTATE_COMPLETE
Loop

ie.document.all("login_username").innerText = MyLogin
ie.document.all("secretkey").innerText = MyPass
ie.document.all("Submit").Click

If ULogin = False Then MsgBox "Usuário logado"
Set ie = Nothing
End Sub