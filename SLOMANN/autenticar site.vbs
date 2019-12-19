Private Sub Form_Load()

Dim IE As Object
Set IE = CreateObject("internetexplorer.application")

vCon = "Application"

IE.Visible = True
IE.Navigate "http://www.vbmania.com.br/pages/index.php"
Do While IE.Busy
Loop
Do Until IE.Document.ReadyState = "complete"
Loop

IE.Document.All("TxtConteudo").innerText = vCon
'IE.Document.All("Pesquisar").Click

Set IE = Nothing

End Sub
