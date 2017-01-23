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

setwd("C:/Users/angelo/Google Drive/Drive Pagarme/07 Financeiro/02 Contabilidade/01 Peças Contábeis/2016/00 Zatz/Balancete 092016/V2/")

#a<-read.xlsx(paste(getwd(),"RAZAO JANEIRO 03052016 V3.xlsx", sep="/"), 1,"Relatório Razão Contábil", header = TRUE)
basemes<-read.csv(paste(getwd(),"RZSetSet PAGARME 24102016.csv", sep="/"), strip.white = TRUE, sep = ";", header = FALSE)

#criar um vetor para ver o tamanho de cada lançamento
ind<-0
n_conta<-0
i=1
j=1
tam=0
while (i<=nrow(basemes)){
		if(substr(basemes[i,1],2,2)=="." & (substr(basemes[i,1],3,3)!="" | substr(basemes[i,1],3,3)!="/")){
				ind[j]<-i
				n_conta[i]<-substr(basemes[i,1],1,30)


				if(j>1){
						tam[j-1]<-ind[j] - ind[j-1] - 5
				}

				j=j+1
		}

		
		n_conta[i]
		i=i+1
}
lim_ind<-j
ind[lim_ind]<-nrow(basemes)+1

#criar coluna com o nome da conta
contas<-0
i=1
j=1
while(i<=nrow(basemes)){
		if(ind[j+1]==i){
				j=j+1
				#j
		}
		contas[i]<-n_conta[ind[j]]
		i=i+1
ind[j+1]
i

}
basemes<-cbind(basemes, contas)

#configurar as variáveis
#Data, conta contabil, historico, valor

basemes[,6]<-str_replace_all(basemes[,6], "[.]", "")
basemes[,6]<-str_replace_all(basemes[,6], "[,]", ".")
basemes[,6]<-round(as.numeric(basemes[,6]), digits = 2)

basemes[,7]<-str_replace_all(basemes[,7], "[.]", "")
basemes[,7]<-str_replace_all(basemes[,7], "[,]", ".")
basemes[,7]<-round(as.numeric(basemes[,7]), digits = 2)

basemes[,8]<-str_replace_all(basemes[,8], "[.]", "")
basemes[,8]<-str_replace_all(basemes[,8], "[,]", ".")
basemes[,8]<-round(as.numeric(basemes[,8]), digits = 2)

basemes[,3]<-as.numeric(basemes[,3])
basemes[,9]<-str_replace_all(basemes[,9], "[.]", "")

#renomear as colunas

names(basemes)[1]= "Data"
names(basemes)[3]= "Lanc"
names(basemes)[4]= "contra_partida"
names(basemes)[5]= "Descricao"
names(basemes)[6]= "Debito"
names(basemes)[7]= "Credito"
names(basemes)[8]= "Saldo"
names(basemes)[9]= "Contas"

	#filtrar as linhas que interessam
	nrow(basemes)
	baserecusada<-basemes[(is.na(basemes[,6])|is.na(basemes[,8])),]
	nrow(baserecusada)
	nrow(basemes)-nrow(baserecusada)
	basemes<-basemes[(!is.na(basemes[,6]) & !is.na(basemes[,8])),]
	nrow(basemes)

#ordenar para juntar debito e credito
valor<-matrix(0, nrow(basemes),ncol=1)
Deb<-matrix(0, nrow(basemes),ncol=1)
Cred<-matrix(0, nrow(basemes),ncol=1)
DebCred<-matrix(0, nrow(basemes),ncol=1)
DebCredt<-matrix(0, nrow(basemes),ncol=1)


valor<-basemes[,6]+basemes[,7]
i=1
while(i<=nrow(basemes)){
		if(basemes[i,6]==0){
				Cred[i]<-1
				DebCred[i]<-"C"
		}
		if(basemes[i,7]==0){
				Deb[i]<-1
				DebCred[i]<-"D"
		}
		DebCredt[i]<-Deb[i]+Cred[i]

		i=i+1
}

sum(DebCredt)==nrow(DebCredt)

basemes<-cbind(basemes, valor, DebCred)

#basemes<-order(basemes$Valor, basemes$Data, basemes$Descricao, na.last = TRUE, decreasing = FALSE)
attach(basemes)
basemes<-basemes[order(Data, valor, Lanc, DebCred),]

basemes$Data<-as.Date(paste(substr(basemes$Data,7,10),substr(basemes$Data,4,5),substr(basemes$Data,1,2) ,sep=""), "%Y%m%d")

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
		if(basemes$DebCred[i]=="C"){
				lp[i]<-"002"
				CustoC[i]<-"001"
				ContaC[i]<-basemes[i,9]
				CentroCustoC[i]<-"1011"
		}
		if(basemes$DebCred[i]=="D"){
				lp[i]<-"001"
				CustoD[i]<-"001"
				ContaD[i]<-basemes[i,9]
				CentroCustoD[i]<-"1011"
		}
		i=i+1
}

#montas um vector com o layout do Microsiga
#basefinal<-paste(lp,substring(basemes$Data,9,10),substring(basemes$Data,6,7),
#	substring(basemes$Data,3,4),substring(paste(ContaD,"                    ",sep=""),1,20),
#	substring(paste(ContaC,"                    ",sep=""),1,20), substring("                    ",1,9),
#	substring("                    ",1,9),substring(paste(basemes$Descricao,"                                   ",sep=""),1,40),
#	substring(paste(format(basemes$valor, nsmall = 2),"             ",sep=""),1,12), 
#	substring(paste(CustoD,"             ",sep=""),1,9),substring(paste(CustoC,"             ",sep=""),1,9)
#	,sep="")


basefinal<-paste(lp,substring(basemes$Data,9,10),substring(basemes$Data,6,7),
	substring(basemes$Data,3,4),substring(paste(ContaD,"                    ",sep=""),1,20),
	substring(paste(ContaC,"                    ",sep=""),1,20), substring(paste(CentroCustoD,"             ",sep=""),1,9),
	substring(paste(CentroCustoC,"             ",sep=""),1,9),substring(paste(basemes$Descricao,"                                   ",sep=""),1,40),
	substring(paste(format(basemes$valor, nsmall = 2),"             ",sep=""),1,12), 
	substring(paste(CustoD,"             ",sep=""),1,9),substring(paste(CustoC,"             ",sep=""),1,9)
	,sep="")

#basefinal<-paste(lp,"311215",substring(paste(ContaD,"                    ",sep=""),1,20),
#	substring(paste(ContaC,"                    ",sep=""),1,20), substring(paste(CentroCustoD,"           ",sep=""),1,9),
#	substring(paste(CentroCustoC,"             ",sep=""),1,9),substring(paste("saldo final de 2015","                                   ",sep=""),1,40),
#	substring(paste(as.numeric(formatC((basemes$valor), digits =22, format="f")),"             ",sep=""),1,12), 
#	substring(paste(CustoD,"             ",sep=""),1,9),substring(paste(CustoC,"             ",sep=""),1,9)
#	,sep="")


nchar(basefinal)
length(basefinal)
#setwd("C:/Users/angelo/Google Drive/Drive Pagarme/07 Financeiro/02 Contabilidade/01 Peças Contábeis/2016/00 Zatz/Balancete 032016/V3/")
write.table(basefinal, file=paste(getwd(),"Razao_Adm_Layout_Microsiga_Set_V2.txt", sep="/"), sep="\n", dec=",", row.names = FALSE,col.names = FALSE, quote = FALSE)


#a<-rep("d",5)
#a<-str_replace_all(a, "[d]", " ")
