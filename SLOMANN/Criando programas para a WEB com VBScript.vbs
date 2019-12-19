<SCRIPT LANGUAGE="VBscript">
 Sub Mostra_mensagem()
    MsgBox "Olá , isto é um teste", 0, "Teste"
 End Sub

 Call Mostra_mensagem 
</SCRIPT>

<p align="center">
<input type="botao" value="Clique aqui" name="MsgBotao">
<p>

<SCRIPT LANGUAGE="VBscript">
 Sub msgbotao_OnClick
    MsgBox "Voce clicou no botao ! ", 0, "Clique aqui"
 End Sub
</SCRIPT>