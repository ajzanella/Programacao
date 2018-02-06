#####Create folders

#Put the Dir to list the client names
MainDir <- "C:/Users/ajzan/Desktop/Wealth3/egali"
Year<-2018
YearSubFolder<-c("Advice and Research", "Application and Statement", "Correspondence", "Info from Client")
AdviceSubFolder<-c("Review","ROA","SOA")

ClientNames<-list.files(MainDir,full.names = FALSE, recursive = FALSE)

i=1
while (i <=length(ClientNames)) {
	if (dir.exists(paste(MainDir,ClientNames[i], sep = "/")) == TRUE) {
		if (dir.exists(paste(MainDir,ClientNames[i],Year, sep = "/")) == TRUE) {
			j=1
			while (j<=length(YearSubFolder)){
				if (j==1){
					if (dir.exists(paste(MainDir,ClientNames[i],Year,YearSubFolder[j], sep = "/")) == TRUE) {
						k=1
						while (k<=length(AdviceSubFolder)){
							if (dir.exists(paste(MainDir,ClientNames[i],Year,YearSubFolder[j],AdviceSubFolder[k], sep = "/")) == TRUE) {
								#if the folder exist, dont do anything (because the folder was created)
							}
							else{
								dir.create(file.path(MainDir,ClientNames[i],Year,YearSubFolder[j],AdviceSubFolder[k])) #1#
								print(list.files(paste(MainDir,ClientNames[i],Year,YearSubFolder[j],sep="/"),full.names = TRUE, recursive = FALSE)[k]) #print the full dir to check if the dir was created
							}
							k=k+1
						}
					}
					else{
						dir.create(file.path(MainDir,ClientNames[i],Year,YearSubFolder[j])) #2#
						print(list.files(paste(MainDir,ClientNames[i],Year,sep="/"),full.names = TRUE, recursive = FALSE)[j]) #print the full dir to check if the dir was created
					}
				}
				else{
					#j!=3
					if (dir.exists(paste(MainDir,ClientNames[i],Year,YearSubFolder[j], sep = "/")) == TRUE) {
						#if the folder exist, dont do anything (because the folder was created)
					}
					else{
						dir.create(file.path(MainDir,ClientNames[i],Year,YearSubFolder[j])) #3# 
						print(list.files(paste(MainDir,ClientNames[i],Year,sep="/"),full.names = TRUE, recursive = FALSE)[j]) #print the full dir to check if the dir was created
					}
				}
				j=j+1
			}
		}	
		else{
			#dontexistyear
			dir.create(file.path(MainDir,ClientNames[i],Year)) #4# 
			print(list.files(paste(MainDir,ClientNames[i],sep="/"),full.names = TRUE, recursive = FALSE))
			m=1
			while (m<=length(YearSubFolder)){
				dir.create(file.path(MainDir,ClientNames[i],Year,YearSubFolder[m])) #4# 
				print(list.files(paste(MainDir,ClientNames[i],Year,sep="/"),full.names = TRUE, recursive = FALSE)[m])
				if (m == 1) { 
					n=1
					while(n<=length(AdviceSubFolder)){
						dir.create(file.path(MainDir,ClientNames[i],Year,YearSubFolder[m],AdviceSubFolder[n])) #4#
						print(list.files(paste(MainDir,ClientNames[i],Year,YearSubFolder[m],sep="/"),full.names = TRUE, recursive = FALSE)[n]) 
						n=n+1
					}
				}
				#else do nothing
				m=m+1
			}
		}
		if (!dir.exists(paste(MainDir,ClientNames[i],"AML", sep = "/")) == TRUE) {
			dir.create(file.path(MainDir,ClientNames[i],"AML")) #5#
		}
		if (!dir.exists(paste(MainDir,ClientNames[i],"WILL", sep = "/")) == TRUE) {
			dir.create(file.path(MainDir,ClientNames[i],"WILL")) #5#			
		}
	}
	#dont exist client ------ do nothing
	i=i+1
}


find_folder <- function(MainDir, SubDir, comparable){
	i=1
	var_find_folder <- 0
	while i <= length(comparable){
	#verify if find igual,
		if (SubDir == comparable[i]){  #and maindir with subdir exist, return 1 to not create a folder
			var_find_folder <-1
			i = i + 1000
		}else{
			#if no, verify if is similar,
			if(comparable[i]=="Advice and Research"){
				#
				if (((grep("Adv", SubDir)>0) || (grep("Rese", SubDir)>0)) && dir.exists(paste(MainDir,SubDir, sep = "/")) ){
					var_find_folder <-1
					i = i + 1000
				}
			}else{
				if(comparable[i]=="Application and Statement"){
					#
					if (((grep("App", SubDir)>0) || (grep("Stat", SubDir)>0)) && dir.exists(paste(MainDir,SubDir, sep = "/")) ){
						var_find_folder <-1
						i = i + 1000
					}
				} else{
					if(comparable[i]=="Correspondence"){
						#
						if ((grep("Corr", SubDir)>0) && dir.exists(paste(MainDir,SubDir, sep = "/")) ){
							var_find_folder <-1
							i = i + 1000
						}
					} else{
						if(comparable[i]=="Info from Client"){
							#
							if (((grep("Info", SubDir)>0) || (grep("Client", SubDir)>0)) && dir.exists(paste(MainDir,SubDir, sep = "/")) ){
								var_find_folder <-1
								i = i + 1000
							}
						}	
					}
				}
			}
		}
		i=i+1
	}
	return(var_find_folder)
}

####How connect two functions. Issue with MainDir and SubDir. Subdir and comparable is igual.


#for ROA, SOA or Review don't need because if the name was wrote wrong, dont have anything to find and know. And i will create a new folder.
#se o return nao retornar e encerrar a funcao, criar uma variavel e rodar tudo e no final retornar o valor da variavel.