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

################################
#####Diretorio do Siscoserv#####
################################
dir<-"C:/Users/angelo/Google Drive/Drive Pagarme/07 Financeiro/02 Contabilidade/02 Fiscal/03 SISCOSERV/01 ADMINISTRATIVO/03 Declaracoes"
################################
#####Diretorio do Siscoserv#####
################################

#verificar e criar pastas do Siscoserv
if(dir.exists(dir)==FALSE){
dir.create(dir,recursive=T)
}
#verificar e criar pastas do Siscoserv
if(dir.exists(paste(dir,substr(DataHoje,1,4),paste(substr(DataHoje,5,6),substr(DataHoje,1,4),sep="_"), sep="/"))==FALSE){
dir.create(paste(dir,substr(DataHoje,1,4),paste(substr(DataHoje,5,6),substr(DataHoje,1,4),sep="_"), sep="/"),recursive=T)
}

setwd(paste(dir,substr(DataHoje,1,4),paste(substr(DataHoje,5,6),substr(DataHoje,1,4),sep="_"), sep="/"))
#a<-read.xlsx(paste(getwd(),"RAZAO JANEIRO 03052016 V3.xlsx", sep="/"), 1,"Relatório Razão Contábil", header = TRUE)
#verificar e criar pastas do Siscoserv
if(dir.exists(paste(getwd(),"RAS/Retorno", sep="/"))==FALSE){
dir.create(paste(getwd(),"RAS/Retorno", sep="/"),recursive=T)
}
#verificar e criar pastas do Siscoserv
if(dir.exists(paste(getwd(),"RP", sep="/"))==FALSE){
dir.create(paste(getwd(),"RP", sep="/"),recursive=T)
}

basemes<-read.csv(paste(getwd(),sort(list.files(getwd(),"csv"), decreasing = TRUE)[1], sep="/"), strip.white = TRUE, sep = ";", header = TRUE, dec=",")

#verificar se o valor está correto.
if (is.numeric((basemes$Valor..moeda[1]))==TRUE){

#criar um vetor do tamanho correto da base, considerando cabeçalho
base_sisco<-c(0:22)
nrow(basemes)
length(base_sisco)

#Desenvolver o arquivo todo
i=1
while (i<=nrow(basemes)){
	base_sisco[1]<-paste("<?xml version=","1.0"," encoding=","UTF-8","?>",sep='"')
	base_sisco[2]<-paste("<RetificarRAS xmlns:xsi=","http://www.w3.org/2001/XMLSchema-instance"," xsi:noNamespaceSchemaLocation=","retificar_RAS.xsd",">",sep='"')
	base_sisco[3+0 ]<-paste("<NumeroRASEmpresa>",basemes[i,2],"</NumeroRASEmpresa>", sep="")
	base_sisco[3+1 ]<-paste("<NomeVendedor>",basemes[i,3],"</NomeVendedor>", sep="")
	base_sisco[3+2 ]<-paste("<EnderecoVendedor>",basemes[i,4],"</EnderecoVendedor>", sep="")
	base_sisco[3+3 ]<-paste("<CodigoPaisVendedor>",basemes[i,5],"</CodigoPaisVendedor>", sep="")
	base_sisco[3+4 ]<-paste("<IdentificadorFiscal>", sep="")
	base_sisco[3+5 ]<-paste("<Nif>",basemes[i,6],"</Nif>", sep="")
	base_sisco[3+6 ]<-paste("</IdentificadorFiscal>", sep="")
	base_sisco[3+7 ]<-paste("<TipoVinculacao>","0","</TipoVinculacao>", sep="")
	base_sisco[3+8 ]<-paste("<Operacao>", sep="")
	base_sisco[3+9 ]<-paste("<NumeroOperacaoEmpresa>",paste(substring(DataHoje,3,8),formatC(basemes[i,18], digits = 0, width = 2, flag="0"), sep=""),"</NumeroOperacaoEmpresa>", sep="")
	#base_sisco[3+9 ]<-paste("<NumeroOperacaoEmpresa>",basemes[i,18],"</NumeroOperacaoEmpresa>", sep="")
	base_sisco[3+10]<-paste("<CodigoNbs>",basemes[i,7],"</CodigoNbs>", sep="")
	base_sisco[3+11]<-paste("<CodigoPaisDestino>",basemes[i,8],"</CodigoPaisDestino>", sep="")
	base_sisco[3+12]<-paste("<ModoPrestacao>",basemes[i,10],"</ModoPrestacao>", sep="")
	base_sisco[3+13]<-paste("<DataInicio>",substring(basemes[i,11],7,10),"-",substring(basemes[i,11],4,5),"-",substring(basemes[i,11],1,2),"</DataInicio>", sep="")
	base_sisco[3+14]<-paste("<DataConclusao>",substring(basemes[i,12],7,10),"-",substring(basemes[i,12],4,5),"-",substring(basemes[i,12],1,2),"</DataConclusao>", sep="")
	base_sisco[3+15]<-paste("<Valor>",formatC(basemes[i,13], format = "f", digits = 2),"</Valor>", sep="")
	base_sisco[3+16]<-paste("<CnpjGastoPessoal>","</CnpjGastoPessoal>", sep="")
	base_sisco[3+17]<-paste("<ExcluirGastoPessoal>","false","</CnpjGastoPessoal>", sep="")
	#	base_sisco[3+17]<-paste("<Enquadramento>", sep="")
#	base_sisco[3+18]<-paste("<CodigoEnquadramento>","0","</CodigoEnquadramento>", sep="")
#	base_sisco[3+19]<-paste("<NumeroRc>","</NumeroRc>", sep="")
#	base_sisco[3+20]<-paste("</Enquadramento>", sep="")
#	base_sisco[3+17]<-paste("<VinculacaoNumRE>","</VinculacaoNumRE>", sep="")
#	base_sisco[3+18]<-paste("<VinculacaoNumDI>","</VinculacaoNumDI>", sep="")
	base_sisco[3+18]<-paste("</Operacao>", sep="")
	base_sisco[3+19]<-paste("<InfoComplementar>","</InfoComplementar>", sep="")
	base_sisco[3+20]<-paste("<CodigoMoeda>",basemes[i,9],"</CodigoMoeda>", sep="")
	base_sisco[3+21]<-paste("</RetificarRAS>", sep="")

	#base_sisco
write.table(base_sisco, file=paste(getwd(),"RAS",paste("RASINC",DataHoje,"n",basemes[i,18],".xml", sep=""), sep="/"), sep="\n", dec=",", row.names = FALSE, col.names = FALSE, quote = FALSE)

	i=i+1	
}

} else
{
 print("Os valores estão em formato errado. Formate no CVS como número com decimal (,) e sem separador de milhar (.) ")
}











#criar um arquivo xml
#write.xml(basemes, file="siscoserv.txt")



#ler o txt criado para retirar os nomes Row e incluir os títulos 

#base<-read.table(paste(getwd(),"siscoserv.txt", sep="/"))




