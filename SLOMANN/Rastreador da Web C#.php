//Usando Abot//

using  System ;
usando o  sistema . Rosqueamento . Tarefas ;
usando o  Abot2 . N�cleo ;
usando o  Abot2 . Crawler ;
usando o  Abot2 . Poco ;
usando  Serilog ;

namespace  TestAbotUse
{
     Programa de aula
    {
         tarefa ass�ncrona  est�tica principal ( string [] args ) 
        {
            Log . Logger  =  new  LoggerConfiguration ()
                . MinimumLevel . Informa��es ()
                . WriteTo . Console ()
                . CreateLogger ();

            Log . Logger . Informa��es ( " Demonstra��o iniciando! " );

            aguarde  DemoSimpleCrawler ();
            aguarde  DemoSinglePageRequest ();
        }

         Tarefa ass�ncrona est�tica  privada DemoSimpleCrawler ()  
        {
            var  config  =  new  CrawlConfiguration
            {
                MaxPagesToCrawl  =  10 , //
                 Rastrear apenas 10 p�ginas MinCrawlDelayPerDomainMilliSeconds  =  3000  // Aguarde tantos milissegundos entre solicita��es
            };
            var  crawler  =  novo  PoliteWebCrawler ( config );

            rastreador . PageCrawlCompleted  + =  PageCrawlCompleted ; // V�rios eventos dispon�veis ...

            var  crawlResult  =  aguardar  rastreador . CrawlAsync ( novo  Uri ( " http: // !!!!!!!! YOURSITEHERE !!!!!!!!! .com " ));
        }

         Tarefa ass�ncrona est�tica  privada DemoSinglePageRequest ()  
        {
            var  pageRequester  =  novo  PageRequester ( novo  CrawlConfiguration (), novo  WebContentExtractor ());

            var  crawledPage  =  aguardar  pageRequester . MakeRequestAsync ( novo  Uri ( " http://google.com " ));
            Log . Logger . Informa��es ( " {result} " , novas
            {
                url  =  crawledPage . Uri ,
                 status  =  Converter . ToInt32 ( crawledPage . HttpResponseMessage . StatusCode )
            });
        }

         PageCrawlCompleted nulo est�tico  privado ( remetente do objeto , PageCrawlCompletedArgs e )   
        {
            var  httpStatus  =  e . CrawledPage . HttpResponseMessage . StatusCode ;
            var  rawPageText  =  e . CrawledPage . Conte�do . Texto ;
        }
    }
}


//Configura��o Abot//

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
	Console . WriteLine ( $ " Sobre o rastreamento do link { pageToCrawl . Uri . AbsoluteUri }, encontrado na p�gina { pageToCrawl . ParentUri . AbsoluteUri } " );
}

void  crawler_ProcessPageCrawlCompleted ( objeto  remetente , PageCrawlCompletedArgs  e )
{
	CrawledPage  crawledPage  =  e . CrawledPage ;

	if ( crawledPage . WebException  ! =  null  ||  crawledPage . HttpWebResponse . StatusCode  ! =  HttpStatusCode . OK )
		 Console . WriteLine ( $ " Falha no rastreamento da p�gina { crawledPage . Uri . AbsoluteUri } " );
	outro 
		Console . WriteLine ( $ "O rastreamento da p�gina foi bem-sucedido { crawledPage . Uri . AbsoluteUri } ");

	if ( string . IsNullOrEmpty ( crawledPage . Content . Text ))
		 Console . WriteLine ( $ "A p�gina n�o tinha conte�do { crawledPage . Uri . AbsoluteUri } " );
	
	var  htmlAgilityPackDocument  =  crawledPage . HtmlDocument ; // Analisador Html Agility Pack 
	var  angleSharpHtmlDocument  =  crawledPage . AngleSharpHtmlDocument ; // Analisador AngleSharp
}

void  crawler_PageLinksCrawlDisallowed ( remetente do objeto  , PageLinksCrawlDisallowedArgs e ) 
{
	CrawledPage  crawledPage  =  e . CrawledPage ;
	Console . WriteLine ( $ " N�o rastreou os links na p�gina { crawledPage . Uri . AbsoluteUri } devido a { e . DisallowedReason } " );
}

void  crawler_PageCrawlDisallowed ( remetente do objeto  , PageCrawlDisallowedArgs e ) 
{
	PageToCrawl  pageToCrawl  =  e . PageToCrawl ;
	Console . WriteLine ( $ " N�o rastreou a p�gina { pageToCrawl . Uri . AbsoluteUri } devido a { e . DisallowedReason } " );
}

//Objetos personalizados e o saco de rastreamento din�mico//

var  crawler  crawler  =  novo  PoliteWebCrawler ();
rastreador . CrawlBag . MyFoo1  =  novo  Foo ();
rastreador . CrawlBag . MyFoo2  =  novo  Foo ();
rastreador . PageCrawlStarting  + =  crawler_ProcessPageCrawlStarting ;
...
void  crawler_ProcessPageCrawlStarting ( remetente do objeto  , PageCrawlStartingArgs e ) 
{
    // Obtenha suas inst�ncias Foo do objeto 
    CrawlContext var  foo1  =  e . CrawlConext . CrawlBag . MyFoo1 ;
    var  foo2  =  e . CrawlConext . CrawlBag . MyFoo2 ;

    // Adicione tamb�m um valor din�mico ao PageToCrawl ou CrawledPage 
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
	var  decis�o  =  nova  CrawlDecision { Allow  =  true };
	if ( pageToCrawl . Uri . Authority  ==  " google.com " )
		 retorna  nova  CrawlDecision { Allow  =  false , Raz�o  =  " N�o deseja rastrear p�ginas do Google " };
	
	 decis�o de devolu��o ;
});

rastreador . ShouldDownloadPageContent (( crawledPage , crawlContext ) =>
{
	var  decis�o  =  nova  CrawlDecision { Allow  =  true };
	if ( ! crawledPage . Uri . AbsoluteUri . Contains ( " .com " ))
		 retorna  new  CrawlDecision { Allow  =  false , Reason  =  "Fa�a o download apenas do conte�do da p�gina bruta para .com tlds " };

	 decis�o de devolu��o ;
});

rastreador . ShouldCrawlPageLinks (( crawledPage , crawlContext ) =>
{
	var  decis�o  =  nova  CrawlDecision { Allow  =  true };
	if ( crawledPage . Content . Bytes . Length  <  100 )
		 retorna  new  CrawlDecision { Allow  =  false , Motivo  =  " Apenas rastrear links em p�ginas que tenham pelo menos 100 bytes " };

	 decis�o de devolu��o ;
});

//Implementa��es personalizadas//
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
/// Determina quais p�ginas devem ser rastreadas, se o conte�do bruto deve ser baixado e se os links em uma p�gina devem ser rastreados 
/// </ summary > 
interface p�blica  ICrawlDecisionMaker 
{
	/// < summary > 
	/// Decide se a p�gina deve ser rastreada 
	/// </ summary > 
	CrawlDecision  ShouldCrawlPage ( PageToCrawl  pageToCrawl , CrawlContext  crawlContext );

	/// < summary > 
	/// Decide se os links da p�gina devem ser rastreados 
	/// </ summary > 
	CrawlDecision  ShouldCrawlPageLinks ( CrawledPage  crawledPage , CrawlContext  crawlContext );

	/// < summary > 
	/// Decide se o conte�do da p�gina deve ser baixado 
	/// </ summary > 
	CrawlDecision  ShouldDownloadPageContent ( CrawledPage  crawledPage , CrawlContext  crawlContext );
}

//IThreadManager//

/// < summary > 
/// Lida com os detalhes da implementa��o de multithreading 
/// </ summary > 
interface p�blica  IThreadManager : IDisposable 
{
	/// < sum�rio > 
	/// N�mero m�ximo de threads a serem usados. 
	/// </ summary > 
	int  MaxThreads { get ; }

	/// < summary > 
	/// Executa a a��o de forma ass�ncrona em um thread separado 
	/// </ summary > 
	/// < param  name = " action " > A a��o para executar </ param > 
	void  DoWork ( a��o de  a��o ) ;

	/// < summary > 
	/// Se existem threads em execu��o 
	/// </ summary > 
	bool  HasRunningThreads ();

	/// < summary > 
	/// Abortar todos os threads em execu��o 
	/// </ summary > 
	void  AbortAll ();
}

//IScheduler//

/// < summary > 
/// Manipula o gerenciamento da prioridade de quais p�ginas precisam ser rastreadas 
/// </ summary > 
interface p�blica  IScheduler 
{
	/// < summary > 
	/// Contagem de itens restantes que est�o atualmente agendados 
	/// </ summary > 
	int  Count { get ; }

	/// < summary > 
	/// Agenda o par�metro a ser rastreado 
	/// </ summary > 
	void  Add ( p�gina PageToCrawl  );

	/// < summary > 
	/// Agenda o par�metro a ser rastreado 
	/// </ summary > 
	void  Add ( IEnumerable < PageToCrawl > p�ginas );

	/// < resumo > 
	/// Obt�m a pr�xima p�gina para rastreamento 
	/// </ resumo > 
	PageToCrawl  GetNext ();

	/// < summary > 
	/// Limpar todas as p�ginas agendadas no momento 
	/// </ summary > 
	void  Clear ();
}

//IPageRequester//

interface  p�blica IPageRequester
{
	/// < summary > 
	/// Fa�a uma solicita��o da Web http para o URL e fa�a o download do seu conte�do 
	/// </ summary > 
	CrawledPage  MakeRequest ( Uri  uri );

	/// < summary > 
	/// Fa�a uma solicita��o http da Web para o URL e fa�a o download do seu conte�do com base na decis�o param func 
	/// </ summary > 
	CrawledPage  MakeRequest ( Uri  uri , Func < CrawledPage , CrawlDecision > shouldDownloadContent );
}

//IHyperLinkParser//

/// < summary > 
/// Manipula a an�lise de hyperlikns fora do html bruto 
/// </ summary > 
interface p�blica  IHyperLinkParser 
{
	/// < summary > 
	/// Analisa o html para extrair hiperlinks, converte cada um em um URL absoluto 
	/// </ summary > 
	IEnumerable < Uri > GetLinks ( CrawledPage  crawledPage );
}

//IMemoryManager//

/// < summary > 
/// Lida com monitoramento / uso de mem�ria 
/// </ summary > 
interface p�blica  IMemoryManager : IMemoryMonitor , IDisposable 
{
	/// < sum�rio > 
	/// Se o processo atual que hospeda esta inst�ncia est� alocado / usando acima do valor do par�metro de mem�ria em mb 
	/// </ summary > 
	bool  IsCurrentUsageAbove ( int  sizeInMb );

	/// < summary > 
	/// Se existe pelo menos o valor param da mem�ria dispon�vel em mb 
	/// </ summary > 
	bool  IsSpaceAvailable ( int  sizeInMb );

//IDomainRateLimiter//

/// < summary > 
/// Limites de taxa ou acelera��es por dom�nio 
/// </ summary > 
interface p�blica  IDomainRateLimiter 
{
	/// < summary > 
	/// Se o dom�nio do par�metro tiver sido sinalizado para limitar a taxa, ele ser� limitado de acordo com o atraso m�nimo de rastreamento configurado 
	/// </ summary > 
	void  RateLimit ( Uri  uri );

	/// < summary > 
	/// Adicione uma entrada de dom�nio para que o dom�nio possa ter uma taxa limitada de acordo com o atraso m�nimo de rastreamento 
	/// </ summary > 
	void  AddDomain ( Uri  uri , long  minCrawlDelayInMillisecs );
}

//IRobotsDotTextFinder//

/// < summary > 
/// Localiza e cria a abstra��o do arquivo robots.txt 
/// </ summary > 
interface p�blica  IRobotsDotTextFinder 
{
	/// < summary > 
	/// Encontra o arquivo robots.txt usando o rootUri. 
        /// 
	 IRobotsDotText  Find ( Uri  rootUri );
}



