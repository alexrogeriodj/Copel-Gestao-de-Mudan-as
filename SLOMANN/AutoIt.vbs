#include <IE.au3>
' Abre o Internet Explorer
Local $oIE = _IECreate("www.meusite.com", 1)

' Aguarda o carregamento da página
_IELoadWait($oIE)

' Captura os elementos pelo id
Local $oUsuario = _IEGetObjById($oIE, "usuario")
Local $oSenha = _IEGetObjById($oIE, "senha")
Local $oBotao = _IEGetObjById($oIE, "btn")

' Define os valores
$oUsuario.value = "foo"
$oSenha.value = "bar"

' Simula um clique
_IEAction($oBotao, "click")