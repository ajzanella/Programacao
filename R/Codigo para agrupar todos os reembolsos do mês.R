# R para gerar arquivo SISCOSERV - RAS

## Pacotes para execução das funções
	library(Hmisc)
	library(date)
	library(zoo)
	memory.limit(size = 4000)
	library(sqldf)
	library(stringr)
	library(XML)
	library(kulife)
	library(xml2)

	#Instalação do pacote para leitura do arquivo dbf
	library(foreign)

	#ler o arquivo inicial da RAs para montar o arquivo RP

DataHoje <-format(Sys.time(), "%Y%m%d")
# Ler arquivo em csv com as informações

#para fazer manual

DataHoje<-"20160901"

################################
#####Diretorio do Siscoserv#####
################################
dir1<-"C:/Users/angelo/Google Drive/Drive Pagarme/07 Financeiro/03 Controladoria/02 Fluxo de Caixa/05 Reembolso"
################################
#####Diretorio do Siscoserv#####
################################









rm_accent <- function(str,pattern="all") {
  # Rotinas e funções úteis V 1.0
  # rm.accent - REMOVE ACENTOS DE PALAVRAS
  # Função que tira todos os acentos e pontuações de um vetor de strings.
  # Parâmetros:
  # str - vetor de strings que terão seus acentos retirados.
  # patterns - vetor de strings com um ou mais elementos indicando quais acentos deverão ser retirados.
  #            Para indicar quais acentos deverão ser retirados, um vetor com os símbolos deverão ser passados.
  #            Exemplo: pattern = c("´", "^") retirará os acentos agudos e circunflexos apenas.
  #            Outras palavras aceitas: "all" (retira todos os acentos, que são "´", "`", "^", "~", "¨", "ç")
  if(!is.character(str))
    str <- as.character(str)

  pattern <- unique(pattern)

  if(any(pattern=="Ç"))
    pattern[pattern=="Ç"] <- "ç"

  symbols <- c(
    acute = "áéíóúÁÉÍÓÚýÝ",
    grave = "àèìòùÀÈÌÒÙ",
    circunflex = "âêîôûÂÊÎÔÛ",
    tilde = "ãõÃÕñÑ",
    umlaut = "äëïöüÄËÏÖÜÿ",
    cedil = "çÇ",
    espace = "Æ‡£‚ƒ"
  )

  nudeSymbols <- c(
    acute = "aeiouAEIOUyY",
    grave = "aeiouAEIOU",
    circunflex = "aeiouAEIOU",
    tilde = "aoAOnN",
    umlaut = "aeiouAEIOUy",
    cedil = "cC",
    espace = "acuea"
  )

  accentTypes <- c("´","`","^","~","¨","ç")

  if(any(c("all","al","a","todos","t","to","tod","todo")%in%pattern)) # opcao retirar todos
    return(chartr(paste(symbols, collapse=""), paste(nudeSymbols, collapse=""), str))

  for(i in which(accentTypes%in%pattern))
    str <- chartr(symbols[i],nudeSymbols[i], str)

  return(str)
}








anoatual<-substr(DataHoje,1,4)
mesatual<-substr(DataHoje,5,6)

#verificar e criar pastas do Siscoserv
dir<-(paste(dir1,anoatual,mesatual,"01 Transferencias", sep="/"))
setwd(paste(dir1,anoatual,mesatual, sep="/"))
lista<-list.dirs(dir)
n<-length(lista)-1
lista_pastas<-lista[1:n+1]




#Criar um looping para entrar na pasta, acessar o csv e ir incluindo na tabela. até o final. E gerar o arquivo csv com todas.
i=1
while (i<=n) 
{

arquivocsv<-read.csv(paste(lista_pastas[i],sort(list.files(lista_pastas[i],"csv"), decreasing = TRUE)[1], sep="/"), strip.white = TRUE, sep = ";", header = FALSE, dec=",")
nrow(arquivocsv)

names(arquivocsv)[1]= "Col1"
names(arquivocsv)[2]= "Col2"
names(arquivocsv)[3]= "Col3"
names(arquivocsv)[4]= "Col4"
names(arquivocsv)[5]= "Col5"

#id<-c(1:nrow(arquivocsv))
#arquivocsv<-cbind(id,arquivocsv)
dia<-0
dia[i]<-substr(lista_pastas[i],str_locate( lista_pastas[i],"01 Transferencias")[2]+2,str_locate( lista_pastas[i],"01 Transferencias")[2]+3)
if(arquivocsv[4,2]=="Data"){
	adicional<-0
} else
{
	adicional<-4 #tem o adicional, pois os computadores macs modificam o excel e quando salvamos em csv ele pula linhas.
}
	nomesolicitante<-arquivocsv[2+adicional,3]
	iniarq<-4
	fimarq<-7+1
	j=1
	k=1
	Data<-0
	Descricao<-0
	Valor<-0
	Solicitante<-0
	narquivo<-0
	Concatenar<-0
	linha<-nrow(arquivocsv)
	while (j<(nrow(arquivocsv)-iniarq-fimarq))
	{
		if(arquivocsv[4+j+adicional,2]=="")
		{
			j=j+1
		} else 
		{

			if(arquivocsv[4+j+adicional,2]=="Total")
			{
				j=j+10
			} else
			{
				Data[k]<-as.character(arquivocsv[4+j+adicional,2])
				Descricao[k]<-as.character(arquivocsv[4+j+adicional,3])
				Descricao[k]<-rm_accent(Descricao[k],pattern="all")
				Valor[k]<-as.character(arquivocsv[4+j+adicional,4])
				Solicitante[k]<-as.character(nomesolicitante)
				Solicitante[k]<-rm_accent(as.character(nomesolicitante),pattern="all")
				narquivo[k]<-i
				if(narquivo[k]<10)
				{
					Concatenar[k]<-paste(paste(dia[i]," - arq 0",narquivo[k],sep=""), Solicitante[k], sep=" - ")
				} else
				{
					Concatenar[k]<-paste(paste(dia[i]," - arq ",narquivo[k],sep=""), Solicitante[k], sep=" - ")
				}
				j=j+1
				k=k+1
			}
		}
		
	}
base<-cbind(Data, Descricao, Valor, Solicitante,narquivo, Concatenar)
	names(base)[5]= "Arquivo"
	names(base)[6]= "Concatenar"

		if(i==1)
		{
		basefinal<-base
		} else 
		{
		basefinal<-rbind(basefinal, base)
		}
	print(i)
	print(linha)
i=i+1
}



	#base_sisco
#write.csv2(basefinal, file="C:/Users/angelo/Google Drive/Drive Pagarme/07 Financeiro/fim.csv", row.names = FALSE, sep=";")
write.table(basefinal, file=paste(getwd(),"/Reembolso_Agrupado.csv", sep=""), sep=";", row.names = FALSE, col.names = TRUE)

#Falta pegar o dia que foi feito o reembolso para incluir na planilha e bater com o extrato

