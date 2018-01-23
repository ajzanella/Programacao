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
	}
	#dont exist client ------ do nothing
	i=i+1
}
