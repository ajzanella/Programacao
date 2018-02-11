#####Create folders

#Put the Dir to list the client names
MainDir <- "C:/Users/ajzan/Desktop/Wealth3/egali"
Year<-2018
YearSubFolder<-c("Advice and Research", "Application and Statement", "Correspondence", "Info from Client")
AdviceSubFolder<-c("Review","ROA","SOA")

ClientNames<-list.files(MainDir,full.names = FALSE, recursive = FALSE)

####################
#Function



find_folder = function(MainDirF, SubDirF, comparable){
	ii=1
	var_find_folder <- 0
	while (ii <= length(SubDirF)){
	#verify if find igual,
		RealFolder<-SubDirF[ii]
		if (SubDirF [ii] == comparable){  #and maindirF with subdirF exist, return 1 to not create a folder
			var_find_folder <-1
			ii = ii + 1000
		}else{
			#if no, verify if is similar,
			if(comparable=="Advice and Research"){
				#
				if (((length(grep("Adv", SubDirF[ii])>0)>=1) || (length(grep("Rese", SubDirF[ii])>0)>=1)) && dir.exists(paste(MainDirF,SubDirF[ii], sep = "/")) ){
					var_find_folder <-1
					ii = ii + 1000
				}
			}else{
				if(comparable=="Application and Statement"){
					#
					if (((length(grep("App", SubDirF[ii])>0)>=1) || (length(grep("Stat", SubDirF[ii])>0)>=1)) && dir.exists(paste(MainDirF,SubDirF[ii], sep = "/")) ){
						var_find_folder <-1
						ii = ii + 1000
					}
				} else{
					if(comparable=="Correspondence"){
						#
						if ((length(grep("Corr", SubDirF[ii])>0)>=1) && dir.exists(paste(MainDirF,SubDirF[ii], sep = "/")) ){
							var_find_folder <-1
							ii = ii + 1000
						}
					} else{
						if(comparable=="Info from Client"){
							#
							if (((length(grep("Info", SubDirF[ii])>0)>=1) || (length(grep("Client", SubDirF[ii])>0)>=1)) && dir.exists(paste(MainDirF,SubDirF[ii], sep = "/")) ){
								var_find_folder <-1
								ii = ii + 1000
							}
						} else{
							if(comparable=="Review"){
								#
								if ((length(grep("Review", SubDirF[ii])>0)>=1) && dir.exists(paste(MainDirF,SubDirF[ii], sep = "/")) ){
									var_find_folder <-1
									ii = ii + 1000
								} 
							}else{
								if(comparable=="ROA"){
									#
									if ((length(grep("ROA", SubDirF[ii])>0)>=1) && dir.exists(paste(MainDirF,SubDirF[ii], sep = "/")) ){
										var_find_folder <-1
										ii = ii + 1000
									} 
								}else{
									if(comparable=="SOA"){
										#
										if ((length(grep("SOA", SubDirF[ii])>0)>=1) && dir.exists(paste(MainDirF,SubDirF[ii], sep = "/")) ){
											var_find_folder <-1
											ii = ii + 1000
										}
									} 
								}
							}
						}	
					}
				}
			}
		}
		ii=ii+1
	}
	if(var_find_folder==1){
		return(RealFolder)
	} else{
		return(comparable)
	}
}



######################


i=1
while (i <=length(ClientNames)) {
	if (dir.exists(paste(MainDir,ClientNames[i], sep = "/")) == TRUE) {
		if (dir.exists(paste(MainDir,ClientNames[i],Year, sep = "/")) == TRUE) {
			YearSubFolderReal<-list.files(paste(MainDir,ClientNames[i],Year, sep = "/"),full.names = FALSE, recursive = FALSE)
			j=1
			while (j<=length(YearSubFolder)){
					CorrectYearSubFolder<-find_folder(MainDir = paste(MainDir,ClientNames[i],Year, sep = "/"), SubDir = YearSubFolderReal, comparable = YearSubFolder[j])
					if (j==1){
						if (dir.exists(paste(MainDir,ClientNames[i],Year,CorrectYearSubFolder, sep = "/")) == TRUE) {
							AdviceSubFolderReal<-list.files(paste(MainDir,ClientNames[i],Year, CorrectYearSubFolder, sep = "/"),full.names = FALSE, recursive = FALSE)
							k=1
							while (k<=length(AdviceSubFolder)){
									CorrectAdviceSubFolder<-find_folder(MainDir = paste(MainDir,ClientNames[i],Year,CorrectYearSubFolder, sep = "/"), SubDir = AdviceSubFolderReal, comparable = AdviceSubFolder[k])
									if (dir.exists(paste(MainDir,ClientNames[i],Year,CorrectYearSubFolder,CorrectAdviceSubFolder, sep = "/")) == TRUE) { 
										#if the folder exist, dont do anything (because the folder was created)
									}
									else{
										dir.create(file.path(MainDir,ClientNames[i],Year,CorrectYearSubFolder,CorrectAdviceSubFolder)) #1#  
										print(list.files(paste(MainDir,ClientNames[i],Year,CorrectYearSubFolder,sep="/"),full.names = TRUE, recursive = FALSE)[k]) #print the full dir to check if the dir was created
									}
								k=k+1
							}
						}
						else{
							dir.create(file.path(MainDir,ClientNames[i],Year,CorrectYearSubFolder)) #2#
							print(list.files(paste(MainDir,ClientNames[i],Year,sep="/"),full.names = TRUE, recursive = FALSE)[j]) #print the full dir to check if the dir was created
						}
					}
					else{
						#j!=1
						if (dir.exists(paste(MainDir,ClientNames[i],Year,CorrectYearSubFolder, sep = "/")) == TRUE) {
							#if the folder exist, dont do anything (because the folder was created)
						}
						else{
							dir.create(file.path(MainDir,ClientNames[i],Year,YearSubFolder[j])) #3# 
							print(list.files(paste(MainDir,ClientNames[i],Year,sep="/"),full.names = TRUE, recursive = FALSE)[j])
							 #print the full dir to check if the dir was created
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
	i=i+1
}



#for ROA, SOA or Review don't need because if the name was wrote wrong, dont have anything to find and know. And i will create a new folder.
#se o return nao retornar e encerrar a funcao, criar uma variavel e rodar tudo e no final retornar o valor da variavel.