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

#a<-read.xlsx(paste(getwd(),"RAZAO JANEIRO 03052016 V3.xlsx", sep="/"), 1,"Relatório Razão Contábil", header = TRUE)
basemes<-read.csv(paste(getwd(),sort(list.files(getwd(),"csv"), decreasing = TRUE)[1], sep="/"), strip.white = TRUE, sep = ";", header = TRUE, dec=",")
#leitura do arquivo xml retorno
basexml<-read_xml(paste(getwd(),"RAS/Retorno",sort(list.files(paste(getwd(),"RAS/Retorno", sep="/"),".xml"), decreasing = TRUE)[1], sep="/"))





#ler o retorno do Siscoserv sobre a RAS para retirar informações importantes
	# extrair os dados importantes do arquivo retorno
	nrasemp<-substr(xml_find_all(basexml, ".//NumeroRASEmpresa"), str_locate(xml_find_all(basexml, ".//NumeroRASEmpresa"), "<NumeroRASEmpresa>")[,2]+1
,str_locate(xml_find_all(basexml, ".//NumeroRASEmpresa"), "</NumeroRASEmpresa>")[,1]-1)
	nras<-substr(xml_find_all(basexml, ".//NumeroRAS"), str_locate(xml_find_all(basexml, ".//NumeroRAS"), "<NumeroRAS>")[,2]+1
,str_locate(xml_find_all(basexml, ".//NumeroRAS"), "</NumeroRAS>")[,1]-1)
	arqxml<-substr(xml_find_all(basexml, ".//NomeArquivoXML"), str_locate(xml_find_all(basexml, ".//NomeArquivoXML"), "<NomeArquivoXML>")[,2]+1
,str_locate(xml_find_all(basexml, ".//NomeArquivoXML"), "</NomeArquivoXML>")[,1]-1)
	noper<-substr(xml_find_all(basexml, ".//NumeroOperacaoEmpresa"), str_locate(xml_find_all(basexml, ".//NumeroOperacaoEmpresa"), "<NumeroOperacaoEmpresa>")[,2]+1
,str_locate(xml_find_all(basexml, ".//NumeroOperacaoEmpresa"), "</NumeroOperacaoEmpresa>")[,1]-1)
 	nomearq<-substr(arqxml,str_locate(arqxml, substr(DataHoje,1,4))[,1],str_locate(arqxml, ".xml")[,1]-1)


#criar uma base com o retorno para poder ordenar
baseretorno2<-cbind(nrasemp,nras,arqxml,noper,nomearq)


baseretorno<-merge(basemes, baseretorno2, by.x = "ID", by.y = "nrasemp")
#gerar um txt para incluir na planilha o n da ras



#criar um vetor do tamanho correto da base, considerando cabeçalho
base_sisco<-c(0:11)
nrow(basemes)
length(base_sisco)

#Desenvolver o arquivo todo
i=1
while (i<=nrow(basemes)){
	base_sisco[1]<-paste("<?xml version=","1.0"," encoding=","UTF-8","?>",sep='"')
	base_sisco[2]<-paste("<InclusaoPagamento xmlns:xsi=","http://www.w3.org/2001/XMLSchema-instance"," xsi:noNamespaceSchemaLocation=","inclusao_pagamento.xsd",">",sep='"')
	base_sisco[3+0]<-paste("<NumeroRASEmpresa>",baseretorno[i,1],"</NumeroRASEmpresa>", sep="")
	base_sisco[3+1]<-paste("<IdPagamentoEmpresa>",paste(substring(DataHoje,3,8),formatC(baseretorno[i,18], digits = 0, width = 2, flag="0"), sep=""),"</IdPagamentoEmpresa>", sep="")
	base_sisco[3+2]<-paste("<NumeroPagamento>",baseretorno[i,18],"</NumeroPagamento>", sep="")
	base_sisco[3+3]<-paste("<DataPagamento>",substring(baseretorno[i,15],7,10),"-",substring(baseretorno[i,15],4,5),"-",substring(baseretorno[i,15],1,2),"</DataPagamento>", sep="")
	base_sisco[3+4]<-paste("<ItemPagamento>", sep="")
	base_sisco[3+5]<-paste("<IdItemPagamentoEmpresa>",paste(substring(DataHoje,3,8),formatC(baseretorno[i,18], digits = 0, width = 2, flag="0"), sep=""),"</IdItemPagamentoEmpresa>", sep="")
	base_sisco[3+6]<-paste("<NumeroOperacaoEmpresa>",baseretorno[i,18],"</NumeroOperacaoEmpresa>", sep="")
	base_sisco[3+7]<-paste("<ValorPago>",formatC(baseretorno[i,13], format = "f", digits = 2),"</ValorPago>", sep="")
	base_sisco[3+8]<-paste("</ItemPagamento>", sep="")
	base_sisco[3+9]<-paste("</InclusaoPagamento>", sep="")

	#base_sisco
write.table(base_sisco, file=paste(getwd(),"RP",paste("RPINC",baseretorno[i,24],".xml", sep=""), sep="/"), sep="\n", dec=",", row.names = FALSE, col.names = FALSE, quote = FALSE)

	i=i+1	
}

write.table(baseretorno, file=paste(getwd(),"RAS",paste("RASRetorno",".txt", sep=""), sep="/"), sep="\t", dec=",", row.names = FALSE, col.names = TRUE, quote = FALSE)

