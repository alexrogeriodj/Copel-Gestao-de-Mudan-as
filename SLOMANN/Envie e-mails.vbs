// Método Send//

"Variáveis membro
Private m_oSession As Session
Private m_oMessage As Message
Private m_oRecipient As Recipient
Private m_oAttachment As Attachment
 
Public Function Send (ByVal ListName As String, _
    ByVal ClientActive As Boolean, _
    ByVal Subject As String, _
    ByVal Body As String, _
    Optional ByVal Attachment As String) As Long
Dim sAddresses() As String
Dim lRecip As Long
Dim sName As String, sPath As String
Dim bShow As Boolean
    On Error Resume Next
    If m_oSession Is Nothing Then Exit Function
    If Len(ListName) = 0 Then Exit Function
    "Ative o sinalizador de lista de email
    goReg.EmailList = ListName
    If Not goReg.Enabled Then Exit Function
    bShow = True "o cliente de e-mail não executa
    If ClientActive Then bShow = False
    m_oSession.Logon ShowDialog:=bShow, _
        NewSession:=False
     
    "crie a mensagem
    Set m_oMessage = _
        m_oSession.Outbox.Messages.Add
    With m_oMessage
        .Subject = Subject
        .Text = Body
        .Importance = GetImportance _
            (goReg.Importance)
    End With
    "os endereços são delimitados por ponto e vírgula
    sAddresses = _
        Split(goReg.SendTo, ";")
    For lRecip = 0 _
        To UBound(sAddresses, 1)
        With m_oMessage.Recipients.Add
            .Name = sAddresses(lRecip)
            .Type = CdoTo
            .Resolve
        End With
    Next
 
    "um Anexo nesse exemplo
    If CheckAttachment _
        (Attachment, sPath, sName) Then
        With m_oMessage.Attachments.Add
            .Position = 1
            .Type = CdoFileData
            .Source = sPath
            .Name = sName
            .ReadFromFile sPath
        End With
    End If
    m_oMessage.Send
    "retorne 0=sucesso
    Send = Err
End Function


Read more: http://www.linhadecodigo.com.br/artigo/65/envie-e-mails-a-partir-do-vb.aspx#ixzz67ptadgHX