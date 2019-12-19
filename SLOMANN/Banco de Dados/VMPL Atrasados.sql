CREATE TABLE dbo.VMPL_Atrasados 
   (Incidentes ID int PRIMARY KEY NOT NULL,  
    ID Int ) NOT NULL,  
    Responsavel varchar NULL,  
    Notificador varchar not null, 
    Equipe de Suporte, not null,
    Criado em Date, not null,
    Prioridade varchar [1: muito elevado, 2: elevado, 3: médio, 4: baixo], not null,
    Status varchar [Ação do cliente IRT excedido, Ação do cliente MTP advertência, Ação do cliente MTP excedido, Concluido, Concluido IRT excedido, Concluido MTP excedido, Em andamento, Em atendimento externo, Encaminhado, Encaminhado MTP excedido, Novo, Solução Proposta MTP excedido],
    Status MTP varchar [MTP advertência, MTP excedido],
    Patrimônio Int, not null,
    Responsavel varchar, not null,
    Descrição varchar, not null,
    Categoria varchar, not null,
    Data Agendada date, not null,
    Status do Documento, varchar [Documento Bloqueado],
    Status IRT varchar, not null,
    Modificado em "date, hour", not null,
    Criado por varchar, not null,
    Consequência varchar, [Baixa, Elevada, Média, Muito elevada],
    Urgência varchar, [Baixa, Elevada, Média, Muito elevada],
   
     USE SolmanData  
     GO  
     --Create a new database called SolmanData.  
     CREATE DATABASE SolmanData;
     Press the F5 key to execute the code and create the database.
     USE SolmanData  
     GO  
     --Create a new database called SolmanData.  
     CREATE DATABASE TestData;  
     Press the F5 key to execute the code and create the database.  
     USE [SolmanData];  
     GO  

    CREATE USER [804821] FOR LOGIN [computer_name\804821];  
    GO    
)  