Public MatrizResultados As Variant
Public Total_Ocorrencias As Long
Private Sub ProcuraPersonalizada(ByVal TermoPesquisado As String)
Dim Busca As Range
Dim Primeira_Ocorrencia As String
Dim Resultados As String
    'Executa a busca
    Set Busca = Plan1.Cells.Find(What:=TermoPesquisado, After:=Plan1.Range("A1"), LookIn:=xlFormulas, _
        LookAt:=xlPart, SearchOrder:=xlByRows, SearchDirection:=xlNext, _
        MatchCase:=False, SearchFormat:=False)
    'Caso tenha encontrado alguma ocorrência...
    If Not Busca Is Nothing Then
        Primeira_Ocorrencia = Busca.Address
        Resultados = Busca.Row  'Lista o primeiro resultado na variavel
        'Neste loop, pesquisa todas as próximas ocorrências para
        'o termo pesquisado
        Do
            Set Busca = Plan1.Cells.FindNext(After:=Busca)
            'Condicional para não listar o primeiro resultado
            'pois já foi listado acima
            If Not Busca.Address Like Primeira_Ocorrencia Then
                Resultados = Resultados & ";" & Busca.Row
            End If
        Loop Until Busca.Address Like Primeira_Ocorrencia
        MatrizResultados = Split(Resultados, ";")
        'Atualiza dados iniciais no formulário
        SpinButton1.Max = UBound(MatrizResultados)  'Valor maximo do seletor de registros
        'habilita o seletor de registro
        SpinButton1.Enabled = True
        'indicador do seletor de registros
        Label_Registros_Contador.Caption = "1 de " & UBound(MatrizResultados) + 1
        'Box com o conteudo encontrado
        TextBox1.Text = Plan1.Cells(MatrizResultados(0), 1).Value
        TextBox2.Text = Plan1.Cells(MatrizResultados(0), 2).Value
        TextBox3.Text = Plan1.Cells(MatrizResultados(0), 3).Value
        TextBox4.Text = Plan1.Cells(MatrizResultados(0), 4).Value
    Else    'Caso nada tenha sido encontrado, exibe mensagem informativa
        SpinButton1.Enabled = False     'desabilita o seletor de registros
        Label_Registros_Contador.Caption = ""   'zera os resultados encontrados
        'limpa os campos do formulário
        TextBox1.Text = ""
        TextBox2.Text = ""
        TextBox3.Text = ""
        TextBox4.Text = ""
        MsgBox "Nenhum resultado para '" & TermoPesquisado & "' foi encontrado."
    End If
End Sub



Private Sub UserForm_Initialize()
    SpinButton1.Enabled = False
    Label_Registros_Contador.Caption = ""
End Sub
Private Sub btn_Procurar_Click()
    If Me.txt_Procurar.Text = "" Then
        MsgBox "Digite um valor para a pesquisa"
    Else
        Call ProcuraPersonalizada(Me.txt_Procurar.Text)
    End If
End Sub
Private Sub SpinButton1_Change()
Dim Linha As Long
Dim TotalOcorrencias As Long
    TotalOcorrencias = SpinButton1.Max + 1
    Linha = MatrizResultados(SpinButton1.Value)
    Label_Registros_Contador.Caption = SpinButton1.Value + 1 & " de " & TotalOcorrencias
    TextBox1.Text = Plan1.Cells(Linha, 1).Value
    TextBox2.Text = Plan1.Cells(Linha, 2).Value
    TextBox3.Text = Plan1.Cells(Linha, 3).Value
    TextBox4.Text = Plan1.Cells(Linha, 4).Value
End Sub