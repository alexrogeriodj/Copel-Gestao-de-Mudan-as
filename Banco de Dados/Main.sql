def main():
    database = r"C:\sqlite\db\pythonsqlite.db"
 
    sql_create_projects_table = "DMs VMFI" CREATE TABLE IF NOT EXISTS projects (
    id integer PRIMARY KEY,
    Responsavel_atual text NOT NULL,
    Fim_Desejado date text,
    Status text NOT NULL,
    Administrador_de_Modificacoes text NOT NULL,
    Descricao_do_pedido_associado text NOT NULL,
    Responsavel_pela_Atividade text NOT NULL,
    Prioridade date text (baixo, medio, elevado, muito_elevado),
    Categoria text NOT NULL,
    Pedido_de_modificacao_associado date text,


    begin_date text,
    end_date text
                                    ); """
 
    sql_create_tasks_table = "DMs VMIF"CREATE TABLE IF NOT EXISTS projects (
    id integer PRIMARY KEY,
    Responsavel_atual text NOT NULL,
    Fim_Desejado date text,
    Status text NOT NULL,
    Administrador_de_Modificacoes text NOT NULL,
    Descricao_do_pedido_associado text NOT NULL,
    Responsavel_pela_Atividade text NOT NULL,
    Prioridade date text (baixo, medio, elevado, muito_elevado),
    Categoria text NOT NULL,
    Pedido_de_modificacao_associado date text,

sql_create_projects_table = "DMs VOPR" CREATE TABLE IF NOT EXISTS projects (
    id integer PRIMARY KEY,
    Responsavel_atual text NOT NULL,
    Fim_Desejado date text,
    Status text NOT NULL,
    Administrador_de_Modificacoes text NOT NULL,
    Descricao_do_pedido_associado text NOT NULL,
    Responsavel_pela_Atividade text NOT NULL,
    Prioridade date text (baixo, medio, elevado, muito_elevado),
    Categoria text NOT NULL,
    Pedido_de_modificacao_associado date text,


    begin_date text,
    end_date text
                                    ); """
 
    sql_create_tasks_table = "DMs VOPR"CREATE TABLE IF NOT EXISTS projects (
    id integer PRIMARY KEY,
    Responsavel_atual text NOT NULL,
    Fim_Desejado date text,
    Status text NOT NULL,
    Administrador_de_Modificacoes text NOT NULL,
    Descricao_do_pedido_associado text NOT NULL,
    Responsavel_pela_Atividade text NOT NULL,
    Prioridade date text (baixo, medio, elevado, muito_elevado),
    Categoria text NOT NULL,
    Pedido_de_modificacao_associado date text,


    begin_date text,
    end_date text
                                );"""
 
sql_create_projects_table = "DMs VMPL" CREATE TABLE IF NOT EXISTS projects (
    id integer PRIMARY KEY,
    Responsavel_atual text NOT NULL,
    Fim_Desejado date text,
    Status text NOT NULL,
    Administrador_de_Modificacoes text NOT NULL,
    Descricao_do_pedido_associado text NOT NULL,
    Responsavel_pela_Atividade text NOT NULL,
    Prioridade date text (baixo, medio, elevado, muito_elevado),
    Categoria text NOT NULL,
    Pedido_de_modificacao_associado date text,


    begin_date text,
    end_date text
                                    ); """
 
    sql_create_tasks_table = "DMs VMPL"CREATE TABLE IF NOT EXISTS projects (
    id integer PRIMARY KEY,
    Responsavel_atual text NOT NULL,
    Fim_Desejado date text,
    Status text NOT NULL,
    Administrador_de_Modificacoes text NOT NULL,
    Descricao_do_pedido_associado text NOT NULL,
    Responsavel_pela_Atividade text NOT NULL,
    Prioridade date text (baixo, medio, elevado, muito_elevado),
    Categoria text NOT NULL,
    Pedido_de_modificacao_associado date text,



    # create a database connection
    conn = create_connection(database)
 
    # create tables
    if conn is not None:
        # create projects table
        create_table(conn, sql_create_projects_table)
 
        # create tasks table
        create_table(conn, sql_create_tasks_table)
    else:
        print("Error! cannot create the database connection.")

if __name__ == '__main__':
    main()