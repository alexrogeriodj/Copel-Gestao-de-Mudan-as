from prettytable import PrettyTable
from prettytable import from_csv
from prettytable import from_html

 #Cria a tabela
x = PrettyTable(["Serviços",])

# Alinha as colunas
x.align["Id"] = "ID"
x.align["Notificador"] = "Notificador"
x.align["Equipe de Suporte"] = "Equipe de Suporte"
x.align["Criado em"] = "Criado em"
x.align["Prioridade"] = "Prioridade"
x.align["Status"] = "Status"
x.align["Status MTP"] = "Status MTP"
x.align["Patrimônio"] = "Patrimônio"
x.align ["Responsavel"] = "Responsavel"
x.align ["Descrição"] = "Descrição"
x.align ["Categoria"] = "Categoria"
x.align ["Data Agendada"] = "Data Agendada"
x.align ["Status Documento"] = "Status Documento"
x.align ["Status IRT"] = "Status IRT"
x.align ["Modificado em"] = "Modificado em"
x.align ["Criado por"] = "Criado por"
x.align ["Consequência"] = "Consequência"
x.align ["Urgência"] = "Urgência"
# Deixa um espaço entre a borda das colunas e o conteúdo (default)
x.padding_width = 1

x.add_row["Id"] = "ID"
x.add_row["Notificador"] = "Notificador"
x.add_row["Equipe de Suporte"] = "Equipe de Suporte"
x.add_row["Criado em"] = "Criado em"
x.add_row["Prioridade"] = "Prioridade"
x.add_row["Status"] = "Status"
x.add_row["Status MTP"] = "Status MTP"
x.add_row["Patrimônio"] = "Patrimônio"
x.add_row ["Responsavel"] = "Responsavel"
x.add_row ["Descrição"] = "Descrição"
x.add_row ["Categoria"] = "Categoria"
x.add_row ["Data Agendada"] = "Data Agendada"
x.add_row ["Status Documento"] = "Status Documento"
x.add_row ["Status IRT"] = "Status IRT"
x.add_row ["Modificado em"] = "Modificado em"
x.add_row ["Criado por"] = "Criado por"
x.add_row ["Consequência"] = "Consequência"
x.add_row ["Urgência"] = "Urgência"

x = PrettyTable()

x.add_column('Id' [not null ])
x.add_column('Notificador' [not null])
x.add_column('Equipe de Suporte' [OPERAÇÃO.COI/Curitiba-PR])
x.add_column('Criado em' [not null])
x.add_column('Prioridade' [1: muito elevado, 2: elevado, 3: médio, 4: baixo])
x.add_column('Status' [Ação do cliente IRT excedido, Ação do cliente MTP advertência, Ação do cliente MTP excedido, Concluiodo, Concluído IRT exedido, Concluído MTP advertência, Concluído MTP excedido, Em andamento, Em atendimento externo, Encaminhado, Encaminhado MTP excedido, Novo, Solução Proposta MTP excedido])
x.add_column('Status MTP' [MTP advertência, MTP excedido])
x.add_column('Patrimônio' [not null])"
x.add_column('Responsavel' [not null])
x.add_column('Descrição' [not null])
x.add_column('Categoria' [not null])
x.add_column('Data Agendada' [Date: dd.mm.aaaa])
x.add_column('Status Documento' [Documento Bloqueado])
x.add_column('Status IRT'[not null])
x.add_column('Modificado em'[Date:(dd.mm.aaaa, (Hour: Minute, Second)])
x.add_column('Criado por'[not null])
x.add_column('Consequência' [Baixa, Elevada, Média, Muito elevada])
x.add_column('Urgência'[Baixa, Elevada, Média, Muito elevada])