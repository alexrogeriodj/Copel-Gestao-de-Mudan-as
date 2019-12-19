//Usando Abot//

using  System ;
usando o  sistema . Rosqueamento . Tarefas ;
usando o  Abot2 . Núcleo ;
usando o  Abot2 . Crawler ;
usando o  Abot2 . Poco ;
usando  Serilog ;

namespace  TestAbotUse
{
     Programa de aula
    {
         tarefa assíncrona  estática principal ( string [] args ) 
        {
            Log . Logger  =  new  LoggerConfiguration ()
                . MinimumLevel . Informações ()
                . WriteTo . Console ()
                . CreateLogger ();

            Log . Logger . Informações ( " Demonstração iniciando! " );

            aguarde  DemoSimpleCrawler ();
            aguarde  DemoSinglePageRequest ();
        }

         Tarefa assíncrona estática  privada DemoSimpleCrawler ()  
        {
            var  config  =  new  CrawlConfiguration
            {
                MaxPagesToCrawl  =  10 , //
                 Rastrear apenas 10 páginas MinCrawlDelayPerDomainMilliSeconds  =  3000  // Aguarde tantos milissegundos entre solicitações
            };
            var  crawler  =  novo  PoliteWebCrawler ( config );

            rastreador . PageCrawlCompleted  + =  PageCrawlCompleted ; // Vários eventos disponíveis ...

            var  crawlResult  =  aguardar  rastreador . CrawlAsync ( novo  Uri ( " http: // !!!!!!!! YOURSITEHERE !!!!!!!!! .com " ));
        }

         Tarefa assíncrona estática  privada DemoSinglePageRequest ()  
        {
            var  pageRequester  =  novo  PageRequester ( novo  CrawlConfiguration (), novo  WebContentExtractor ());

            var  crawledPage  =  aguardar  pageRequester . MakeRequestAsync ( novo  Uri ( " http://google.com " ));
            Log . Logger . Informações ( " {result} " , novas
            {
                url  =  crawledPage . Uri ,
                 status  =  Converter . ToInt32 ( crawledPage . HttpResponseMessage . StatusCode )
            });
        }

         PageCrawlCompleted nulo estático  privado ( remetente do objeto , PageCrawlCompletedArgs e )   
        {
            var  httpStatus  =  e . CrawledPage . HttpResponseMessage . StatusCode ;
            var  rawPageText  =  e . CrawledPage . Conteúdo . Texto ;
        }
    }
}


//Configuração Abot//

var  crawlConfig  =  new  CrawlConfiguration ();
crawlConfig . CrawlTimeoutSeconds  =  100 ;
crawlConfig . MaxConcurrentThreads  =  10 ;
crawlConfig . MaxPagesToCrawl  =  1000 ;
crawlConfig . UserAgentString  =  " Mozilla / 5.0 (Windows NT 10.0; Win64; x64) AppleWebKit / 537.36 (KHTML, como Gecko) Chrome / 74.0.3729.169 Safari / 537.36 " ;
crawlConfig . ConfigurationExtensions . Adicionar ( "SomeCustomConfigValue1 " , " 1111 " );
 crawlConfig . ConfigurationExtensions . Add ( " SomeCustomConfigValue2 " , " 2222 " );
 etc ...

//Eventos de Abot//

rastreador . PageCrawlStarting  + =  crawler_ProcessPageCrawlStarting ;
rastreador . PageCrawlCompleted  + =  crawler_ProcessPageCrawlCompleted ;
rastreador . PageCrawlDisallowed  + =  crawler_PageCrawlDisallowed ;
rastreador . PageLinksCrawlDisallowed  + =  crawler_PageLinksCrawlDisallowed ;
void  crawler_ProcessPageCrawlStarting ( remetente do objeto  , PageCrawlStartingArgs e ) 
{
	PageToCrawl  pageToCrawl  =  e . PageToCrawl ;
	Console . WriteLine ( $ " Sobre o rastreamento do link { pageToCrawl . Uri . AbsoluteUri }, encontrado na página { pageToCrawl . ParentUri . AbsoluteUri } " );
}

void  crawler_ProcessPageCrawlCompleted ( objeto  remetente , PageCrawlCompletedArgs  e )
{
	CrawledPage  crawledPage  =  e . CrawledPage ;

	if ( crawledPage . WebException  ! =  null  ||  crawledPage . HttpWebResponse . StatusCode  ! =  HttpStatusCode . OK )
		 Console . WriteLine ( $ " Falha no rastreamento da página { crawledPage . Uri . AbsoluteUri } " );
	outro 
		Console . WriteLine ( $ "O rastreamento da página foi bem-sucedido { crawledPage . Uri . AbsoluteUri } ");

	if ( string . IsNullOrEmpty ( crawledPage . Content . Text ))
		 Console . WriteLine ( $ "A página não tinha conteúdo { crawledPage . Uri . AbsoluteUri } " );
	
	var  htmlAgilityPackDocument  =  crawledPage . HtmlDocument ; // Analisador Html Agility Pack 
	var  angleSharpHtmlDocument  =  crawledPage . AngleSharpHtmlDocument ; // Analisador AngleSharp
}

void  crawler_PageLinksCrawlDisallowed ( remetente do objeto  , PageLinksCrawlDisallowedArgs e ) 
{
	CrawledPage  crawledPage  =  e . CrawledPage ;
	Console . WriteLine ( $ " Não rastreou os links na página { crawledPage . Uri . AbsoluteUri } devido a { e . DisallowedReason } " );
}

void  crawler_PageCrawlDisallowed ( remetente do objeto  , PageCrawlDisallowedArgs e ) 
{
	PageToCrawl  pageToCrawl  =  e . PageToCrawl ;
	Console . WriteLine ( $ " Não rastreou a página { pageToCrawl . Uri . AbsoluteUri } devido a { e . DisallowedReason } " );
}

//Objetos personalizados e o saco de rastreamento dinâmico//

var  crawler  crawler  =  novo  PoliteWebCrawler ();
rastreador . CrawlBag . MyFoo1  =  novo  Foo ();
rastreador . CrawlBag . MyFoo2  =  novo  Foo ();
rastreador . PageCrawlStarting  + =  crawler_ProcessPageCrawlStarting ;
...
void  crawler_ProcessPageCrawlStarting ( remetente do objeto  , PageCrawlStartingArgs e ) 
{
    // Obtenha suas instâncias Foo do objeto 
    CrawlContext var  foo1  =  e . CrawlConext . CrawlBag . MyFoo1 ;
    var  foo2  =  e . CrawlConext . CrawlBag . MyFoo2 ;

    // Adicione também um valor dinâmico ao PageToCrawl ou CrawledPage 
    e . PageToCrawl . PageBag . Bar  =  novo  Bar ();
}

//Cancelamento//

CancellationTokenSource  cancellationTokenSource  =  new  CancellationTokenSource ();

var  crawler  =  novo  PoliteWebCrawler ();
resultado var  = aguardar rastreador . CrawlAsync ( novo Uri ( " addurihere " ), cancellationTokenSource );    

//Personalizando o comportamento do rastreamento//

var  crawler  =  novo  PoliteWebCrawler ();

rastreador . ShouldCrawlPage (( pageToCrawl , crawlContext ) => 
{
	var  decisão  =  nova  CrawlDecision { Allow  =  true };
	if ( pageToCrawl . Uri . Authority  ==  " google.com " )
		 retorna  nova  CrawlDecision { Allow  =  false , Razão  =  " Não deseja rastrear páginas do Google " };
	
	 decisão de devolução ;
});

rastreador . ShouldDownloadPageContent (( crawledPage , crawlContext ) =>
{
	var  decisão  =  nova  CrawlDecision { Allow  =  true };
	if ( ! crawledPage . Uri . AbsoluteUri . Contains ( " .com " ))
		 retorna  new  CrawlDecision { Allow  =  false , Reason  =  "Faça o download apenas do conteúdo da página bruta para .com tlds " };

	 decisão de devolução ;
});

rastreador . ShouldCrawlPageLinks (( crawledPage , crawlContext ) =>
{
	var  decisão  =  nova  CrawlDecision { Allow  =  true };
	if ( crawledPage . Content . Bytes . Length  <  100 )
		 retorna  new  CrawlDecision { Allow  =  false , Motivo  =  " Apenas rastrear links em páginas que tenham pelo menos 100 bytes " };

	 decisão de devolução ;
});

//Implementações personalizadas//
//PoliteWebCrawler//

var  rastreador  =  novo  PoliteWebCrawler (
    	 novo  CrawlConfiguration (),
	 nova  YourCrawlDecisionMaker (),
	 nova  YourThreadMgr (), 
	 nova  YourScheduler (), 
	 nova  YourPageRequester (), 
	 nova  YourHyperLinkParser (), 
	 nova  YourMemoryManager (), 
    	 nova  YourDomainRateLimiter ,
	 novo  YourRobotsDotTextFinder ());

//IPageRequester e IHyperLinkParser//

var  crawler  =  novo  PoliteWebCrawler (
	 nulo , 
	 nulo , 
    	 nulo ,
    	 nulo ,
	 novo  YourPageRequester (), 
	 novo  YourHyperLinkParser (), 
	 nulo ,
    	 nulo , 
	 nulo );

//ICrawlDecisionMaker//

/// < summary > 
/// Determina quais páginas devem ser rastreadas, se o conteúdo bruto deve ser baixado e se os links em uma página devem ser rastreados 
/// </ summary > 
interface pública  ICrawlDecisionMaker 
{
	/// < summary > 
	/// Decide se a página deve ser rastreada 
	/// </ summary > 
	CrawlDecision  ShouldCrawlPage ( PageToCrawl  pageToCrawl , CrawlContext  crawlContext );

	/// < summary > 
	/// Decide se os links da página devem ser rastreados 
	/// </ summary > 
	CrawlDecision  ShouldCrawlPageLinks ( CrawledPage  crawledPage , CrawlContext  crawlContext );

	/// < summary > 
	/// Decide se o conteúdo da página deve ser baixado 
	/// </ summary > 
	CrawlDecision  ShouldDownloadPageContent ( CrawledPage  crawledPage , CrawlContext  crawlContext );
}

//IThreadManager//

/// < summary > 
/// Lida com os detalhes da implementação de multithreading 
/// </ summary > 
interface pública  IThreadManager : IDisposable 
{
	/// < sumário > 
	/// Número máximo de threads a serem usados. 
	/// </ summary > 
	int  MaxThreads { get ; }

	/// < summary > 
	/// Executa a ação de forma assíncrona em um thread separado 
	/// </ summary > 
	/// < param  name = " action " > A ação para executar </ param > 
	void  DoWork ( ação de  ação ) ;

	/// < summary > 
	/// Se existem threads em execução 
	/// </ summary > 
	bool  HasRunningThreads ();

	/// < summary > 
	/// Abortar todos os threads em execução 
	/// </ summary > 
	void  AbortAll ();
}

//IScheduler//

/// < summary > 
/// Manipula o gerenciamento da prioridade de quais páginas precisam ser rastreadas 
/// </ summary > 
interface pública  IScheduler 
{
	/// < summary > 
	/// Contagem de itens restantes que estão atualmente agendados 
	/// </ summary > 
	int  Count { get ; }

	/// < summary > 
	/// Agenda o parâmetro a ser rastreado 
	/// </ summary > 
	void  Add ( página PageToCrawl  );

	/// < summary > 
	/// Agenda o parâmetro a ser rastreado 
	/// </ summary > 
	void  Add ( IEnumerable < PageToCrawl > páginas );

	/// < resumo > 
	/// Obtém a próxima página para rastreamento 
	/// </ resumo > 
	PageToCrawl  GetNext ();

	/// < summary > 
	/// Limpar todas as páginas agendadas no momento 
	/// </ summary > 
	void  Clear ();
}

//IPageRequester//

interface  pública IPageRequester
{
	/// < summary > 
	/// Faça uma solicitação da Web http para o URL e faça o download do seu conteúdo 
	/// </ summary > 
	CrawledPage  MakeRequest ( Uri  uri );

	/// < summary > 
	/// Faça uma solicitação http da Web para o URL e faça o download do seu conteúdo com base na decisão param func 
	/// </ summary > 
	CrawledPage  MakeRequest ( Uri  uri , Func < CrawledPage , CrawlDecision > shouldDownloadContent );
}

//IHyperLinkParser//

/// < summary > 
/// Manipula a análise de hyperlikns fora do html bruto 
/// </ summary > 
interface pública  IHyperLinkParser 
{
	/// < summary > 
	/// Analisa o html para extrair hiperlinks, converte cada um em um URL absoluto 
	/// </ summary > 
	IEnumerable < Uri > GetLinks ( CrawledPage  crawledPage );
}

//IMemoryManager//

/// < summary > 
/// Lida com monitoramento / uso de memória 
/// </ summary > 
interface pública  IMemoryManager : IMemoryMonitor , IDisposable 
{
	/// < sumário > 
	/// Se o processo atual que hospeda esta instância está alocado / usando acima do valor do parâmetro de memória em mb 
	/// </ summary > 
	bool  IsCurrentUsageAbove ( int  sizeInMb );

	/// < summary > 
	/// Se existe pelo menos o valor param da memória disponível em mb 
	/// </ summary > 
	bool  IsSpaceAvailable ( int  sizeInMb );

//IDomainRateLimiter//

/// < summary > 
/// Limites de taxa ou acelerações por domínio 
/// </ summary > 
interface pública  IDomainRateLimiter 
{
	/// < summary > 
	/// Se o domínio do parâmetro tiver sido sinalizado para limitar a taxa, ele será limitado de acordo com o atraso mínimo de rastreamento configurado 
	/// </ summary > 
	void  RateLimit ( Uri  uri );

	/// < summary > 
	/// Adicione uma entrada de domínio para que o domínio possa ter uma taxa limitada de acordo com o atraso mínimo de rastreamento 
	/// </ summary > 
	void  AddDomain ( Uri  uri , long  minCrawlDelayInMillisecs );
}

//IRobotsDotTextFinder//

/// < summary > 
/// Localiza e cria a abstração do arquivo robots.txt 
/// </ summary > 
interface pública  IRobotsDotTextFinder 
{
	/// < summary > 
	/// Encontra o arquivo robots.txt usando o rootUri. 
        /// 
	 IRobotsDotText  Find ( Uri  rootUri );
}



