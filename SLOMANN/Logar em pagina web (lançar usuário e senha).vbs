Simple sistema de login

ligin.html
CODE  
<html><body>
<form action="login.asp">
<h3>Login:</h3><input type="text" name="login" size="20"><br>
<h3>Senha:</h3><input type="password" name="senha" size="20"><br>
<input type="submit" value="Entrar">
</form></body></html> 



login.asp
CODE  
<%@Language=VBScript%>
<%response.buffer="true"%>
<%
'Recupero o texto que foi escrito no formulário
vlogin=request.form("login")
vsenha=request.form("senha")

'Faça conexão com o banco de dados
db=Server.MapPath("bd.mdb")
Set con = Server.CreateObject( "adodb.Connection" )
con.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & db & ";"
set rs=con.execute("select * from tabela_do_banco where login='"&vlogin&"' and senha='"&vsenha&"'")

'Se não for encontrado nenhum registro aparecerá uma mensagem de erro.
'Caso contrário o visitanmte receberá um nome de sessão para poder navegar nas demais paginas protegidas e será redirecionado para a página protegida
if rs.EOF then
response.write"Senha ou Login inválido! Volte e tente novamente."
else
session("logado")="sim"
response.redirect"pagina_protegida.asp"
end if
%>