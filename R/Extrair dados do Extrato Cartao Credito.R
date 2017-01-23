library(pdftools)
library(Hmisc)
library(date)
library(zoo)
memory.limit(size = 4000)
library(sqldf)
library(stringr)
library(kulife)
library(xml2)
library(foreign)
library(rvest)

setwd("C:/Users/angelo/Google Drive/Drive Pagarme/07 Financeiro/02 Contabilidade/")
extensao<-"10 Bancos/03 Cartões Crédito/"
mesano<-format(Sys.time(), "%Y%m")
#listar todos os arquivos pdf no diretório
listapdf1<-as.matrix(sort(list.files(paste(getwd(),extensao,mesano,sep="/"),"PDF"), decreasing = TRUE))
listapdf2<-as.matrix(sort(list.files(paste(getwd(),extensao,mesano,sep="/"),"pdf"), decreasing = TRUE))
#agrupar a lista dos pdf
listapdf<-rbind(listapdf1,listapdf2)
#criar a var quantidade de arquivos pdf para utilizar no looping
quant_arq<-length(listapdf)
n<-1
#executar para cada arquivo pdf
while(n<=quant_arq){
		txt <- pdf_text(paste(paste(getwd(),extensao,mesano,sep="/"),listapdf[n], sep="/"))
		Extrato<-unlist(strsplit(txt,"\r\n",fixed = TRUE),recursive = TRUE, use.names = TRUE)
		Nomecartao<-substring(Extrato[13],str_locate(Extrato[13], " - ")[,2]+1,str_locate(Extrato[13], " - ")[,2]+10)
		DataVenc<-substring(Extrato[15],str_locate(Extrato[15], "Data de vencimento: ")[,2]+1,str_locate(Extrato[15], "Data de vencimento: ")[,2]+10)
		Data<-0
		Historico<-0
		ValorUS<-0
		ValorRS<-0
		Nome_Cartao<-0
		j<-17
		final<-0
		m<-0
		if(is.na(substring(Extrato[j],str_locate(Extrato[j], "SALDO ANTERIOR")[,1],str_locate(Extrato[j], "SALDO ANTERIOR")[,2]))){
				condicao<-0
		} else{
		 		condicao<-substring(Extrato[j],str_locate(Extrato[j], "SALDO ANTERIOR")[,1],str_locate(Extrato[j], "SALDO ANTERIOR")[,2])	
		}
		if(is.na(substring(Extrato[j+1],str_locate(Extrato[j+1], "PAGTO")[,1],str_locate(Extrato[j+1], "PAGTO")[,2]))){
				condicao2<-0
		} else{
				condicao2<-substring(Extrato[j+1],str_locate(Extrato[j+1], "PAGTO")[,1],str_locate(Extrato[j+1], "PAGTO")[,2])	
		}
		if(condicao=="SALDO ANTERIOR"){
				j=j+1
				m=m+1
				if(condicao2=="PAGTO"){
						j=j+1
						m=m+1
				}
		}
		while(final!="Total:"){
				#Se tiver uma virgula no hitorico, precisa pular.
				if(is.na(as.numeric(substring(Extrato[j],str_locate(Extrato[j], ",")[,1]+1,str_locate(Extrato[j], ",")[,1]+1)))){
						Data[j-16-m]<-gsub(" ","",substring(Extrato[j],str_locate(Extrato[j], "/")[,1]-2,str_locate(Extrato[j], "/")[,2]+2))
						Historico[j-16-m]<-gsub(" ","",substring(Extrato[j],str_locate(Extrato[j], "/")[,2]+3,str_locate(Extrato[j], ",")[,2]+str_locate(substring(Extrato[j],str_locate(Extrato[j], ",")[,2]+1,500), ",")[,1]-10))
						ValorUS[j-16-m]<-gsub(" ","",substring(Extrato[j],str_locate(Extrato[j], ",")[,2]+str_locate(substring(Extrato[j],str_locate(Extrato[j], ",")[,2]+1,500), ",")[,1]-10,str_locate(Extrato[j], ",")[,2]+str_locate(substring(Extrato[j],str_locate(Extrato[j], ",")[,2]+1,500), ",")[,2]+2))
						ValorRS[j-16-m]<-gsub(" ","",substring(Extrato[j],str_locate(Extrato[j], ",")[,2]+str_locate(substring(Extrato[j],str_locate(Extrato[j], ",")[,2]+1,500), ",")[,2]+3,500))
				} else{
						Data[j-16-m]<-gsub(" ","",substring(Extrato[j],str_locate(Extrato[j], "/")[,1]-2,str_locate(Extrato[j], "/")[,2]+2))
						Historico[j-16-m]<-gsub(" ","",substring(Extrato[j],str_locate(Extrato[j], "/")[,2]+3,str_locate(Extrato[j], ",")[,1]-10))
						ValorUS[j-16-m]<-gsub(" ","",substring(Extrato[j],str_locate(Extrato[j], ",")[,1]-10,str_locate(Extrato[j], ",")[,2]+2))
						ValorRS[j-16-m]<-gsub(" ","",substring(substring(Extrato[j],str_locate(Extrato[j], ",")[,2]+3,500),str_locate(substring(Extrato[j],str_locate(Extrato[j], ",")[,2]+3,500), ",")[,1]-10,str_locate(substring(Extrato[j],str_locate(Extrato[j], ",")[,2]+3,500), ",")[,2]+2))
				}
				Nome_Cartao[j-16-m]<-Nomecartao
				final<-substring(Extrato[j],str_locate(Extrato[j], "Total:")[,1],str_locate(Extrato[j], "Total:")[,2])
				if(is.na(final)){
						final<-0
				}
				j=j+1
		}
		BaseExtrato<-as.data.frame(cbind(Data,Historico, ValorUS, ValorRS,Nome_Cartao))
		BaseExtrato<-subset(BaseExtrato, !is.na(BaseExtrato[,1]))
		if(exists("Basefinal")){
				Basefinal<-rbind(Basefinal,BaseExtrato)
		} else{
				Basefinal<-BaseExtrato
		}
		n=n+1
}
Basefinal$ValorUS<-as.numeric(as.character(gsub(",",".",gsub("[R$]","",gsub("[.]","",gsub(" ","",Basefinal$ValorUS))))))
Basefinal$ValorRS<-as.numeric(as.character(gsub(",",".",gsub("[R$]","",gsub("[.]","",gsub(" ","",Basefinal$ValorRS))))))

write.table(Basefinal, file=paste(paste(getwd(),extensao,mesano,sep="/"),paste("Extrato_",mesano,".csv", sep=""), sep="/"), sep="\t", dec=",", row.names = FALSE, col.names = TRUE, quote = FALSE)

Base_siscoserv<-subset(Basefinal, Basefinal$ValorUS!=0)
#salvar a base
write.table(Base_siscoserv, file=paste(paste(getwd(),"02 Fiscal/03 SISCOSERV/01 ADMINISTRATIVO/03 Declaracoes",substr(mesano,1,4),paste(substr(mesano,5,6),substr(mesano,1,4),sep="_"),sep="/"),paste("Extrato_",mesano,".csv", sep=""), sep="/"), sep="\t", dec=",", row.names = FALSE, col.names = TRUE, quote = FALSE)

