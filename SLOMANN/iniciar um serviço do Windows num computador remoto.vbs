SC <pcremoto> <comando> <servico> <opcao1> ... <opcaon>

SC \\REMOTE start Messenger
 NOME_SERVIÇO     : Messenger        
    TIPO               : 20  WIN32_SHARE_PROCESS
    ESTADO             : 2  START_PENDING
                       (NOT_STOPPABLE, NOT_PAUSABLE, IGNORES_SHUTDOWN))
    WIN32_EXIT_CODE    : 0  (0x0)        
    SERVICE_EXIT_CODE  : 0  (0x0)        
    CHECKPOINT         : 0x0        
    WAIT_HINT          : 0x7d0        
    PID                : 1068        
    FLAGS              :


[SC] StartService Falhou 1058:
O serviço não pode ser iniciado porque está desactivado 
ou não tem dispositivos activados associados.

SC \\REMOTE config Messenger start= demand
[SC] ChangeServiceConfig Êxito