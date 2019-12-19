On Error Resume Next

 Const PAGE_LOADED = 4

 Set objIE = CreateObject("InternetExplorer.Application")

 Call objIE.Navigate("http://itsmprd.copel.nt/sap(bD1wdCZjPTEwMCZkPW1pbg==)/bc/bsp/sap/crm_ui_start/default.htm")

 objIE.Visible = True

 Do Until objIE.ReadyState = PAGE_LOADED : Call WScript.Sleep(100) : Loop

 objIE.Document.all.j_username.Value = "e804821"

 objIE.Document.all.j_password.Value = "chinabrasil2019@"

 If Err.Number <> 0 Then

 msgbox "Error: " & err.Description

 End If

  Call objIE.Document.all.loginform.submit

 Set objIE = Nothing 