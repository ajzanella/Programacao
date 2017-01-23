## Pacotes para execução das funções
library(Hmisc)
library(date)
library(zoo)
memory.limit(size = 4000)
library(sqldf)
library(stringr)

#Instalação do pacote para leitura do arquivo dbf
library(foreign)
#library(xlsx)

setwd("C:/Users/angelo/Google Drive/Drive Pagarme/07 Financeiro/02 Contabilidade/00 Fechamento Contábil/2016 Arquivos Microsiga/02 Adm/201609")

#a<-read.xlsx(paste(getwd(),"RAZAO JANEIRO 03052016 V3.xlsx", sep="/"), 1,"Relatório Razão Contábil", header = TRUE)
basemes<-read.csv(paste(getwd(),"Ajustes Set V1.csv", sep="/"), strip.white = TRUE, sep = ";", header = TRUE)


basemes[,1]<-str_replace_all(basemes[,1], "[.]", "")


basemes[,3]<-str_replace_all(basemes[,3], "[.]", "")
basemes[,3]<-str_replace_all(basemes[,3], "[,]", ".")
basemes[,3]<-round(as.numeric(basemes[,3]), digits = 2)

#colocar no formato desejavel
lp<-matrix(0, nrow(basemes),ncol=1)
ContaD<-matrix("", nrow(basemes),ncol=1)
ContaC<-matrix("", nrow(basemes),ncol=1)
CustoC<-matrix("", nrow(basemes),ncol=1)
CustoD<-matrix("", nrow(basemes),ncol=1)
CentroCustoC<-matrix("", nrow(basemes),ncol=1)
CentroCustoD<-matrix("", nrow(basemes),ncol=1)

i=1
while(i<=nrow(basemes)){
		if(basemes$lanc[i]=="C"){
				lp[i]<-"002"
				CustoC[i]<-"001"
				ContaC[i]<-basemes[i,1]
				CentroCustoC[i]<-"1011"
		}
		if(basemes$lanc[i]=="D"){
				lp[i]<-"001"
				CustoD[i]<-"001"
				ContaD[i]<-basemes[i,1]
				CentroCustoD[i]<-"1011"
		}
		i=i+1
}


#montas um vector com o layout do Microsiga
basefinal<-paste(lp,"300916",substring(paste(ContaD,"                    ",sep=""),1,20),
	substring(paste(ContaC,"                    ",sep=""),1,20), substring(paste(CentroCustoD,"           ",sep=""),1,9),
	substring(paste(CentroCustoC,"             ",sep=""),1,9),substring(paste(basemes[,4],"                                   ",sep=""),1,40),
	substring(paste(as.numeric(formatC((basemes$valor), digits =22, format="f")),"             ",sep=""),1,12), 
	substring(paste(CustoD,"             ",sep=""),1,9),substring(paste(CustoC,"             ",sep=""),1,9)
	,sep="")

nchar(basefinal)
length(basefinal)
#setwd("C:/Users/angelo/Google Drive/Drive Pagarme/07 Financeiro/02 Contabilidade/01 Peças Contábeis/2016/00 Zatz/Balancete 022016/V4/")
write.table(basefinal, file=paste(getwd(),"Ajuste de caixa0916.txt", sep="/"), sep="\n", dec=".",row.names = FALSE, col.names = FALSE, quote = FALSE)



#formatC(basemes$valor, digits =2,  nsmall = 2, format="fg")
#a<-rep("d",5)
#a<-str_replace_all(a, "[d]", " ")
