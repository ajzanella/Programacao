	library(jsonlite)
	library(stringr)
	
	setwd("C:/Users/ajzan/Desktop")

	#trello.json.data<-fromJSON("C:/Users/ajzan/Desktop/trello file export.json", flatten=TRUE)
	trello.json.data<-fromJSON("C:/Users/ajzan/Desktop/trello file export3.json", flatten=TRUE)

	#######################
	### set up variable ###
	#######################
		
		#Card
		card_id<-trello.json.data$actions$id
		card_idMemberCreator<-trello.json.data$actions$idMemberCreator
		card_type<-trello.json.data$actions$type
		card_date<-trello.json.data$actions$date
		card_data_text<-trello.json.data$actions$data.text
		card_data_idMember<-trello.json.data$actions$data.idMember
		card_data_dateLastEdited<-trello.json.data$actions$data.dateLastEdited
		card_data_idMemberAdded<-trello.json.data$actions$data.idMemberAdded
		card_data_memberType<-trello.json.data$actions$data.memberType
		card_data_idOriginalCommenter<-trello.json.data$actions$data.idOriginalCommenter
		card_data_deactivated<-trello.json.data$actions$data.deactivated
		card_data_checkItem_textData<-trello.json.data$actions$data.checkItem.textData
		card_data_checkItem_state<-trello.json.data$actions$data.checkItem.state
		card_data_checkItem_name<-trello.json.data$actions$data.checkItem.name
		card_data_checkItem_id<-trello.json.data$actions$data.checkItem.id
		card_data_checklist_name<-trello.json.data$actions$data.checklist.name
		card_data_checklist_id<-trello.json.data$actions$data.checklist.id
		card_data_card_shortLink<-trello.json.data$actions$data.card.shortLink
		card_data_card_idShort<-trello.json.data$actions$data.card.idShort
		card_data_card_name<-trello.json.data$actions$data.card.name
		card_data_card_id<-trello.json.data$actions$data.card.id
		card_data_card_due<-trello.json.data$actions$data.card.due
		card_data_card_dueComplete<-trello.json.data$actions$data.card.dueComplete
		card_data_card_pos<-trello.json.data$actions$data.card.pos
		card_data_card_idList<-trello.json.data$actions$data.card.idList
		card_data_card_closed<-trello.json.data$actions$data.card.closed
		card_data_card_desc<-trello.json.data$actions$data.card.desc
		card_data_board_shortLink<-trello.json.data$actions$data.board.shortLink
		card_data_board_name<-trello.json.data$actions$data.board.name
		card_data_board_id<-trello.json.data$actions$data.board.id
		card_data_board_prefs_permissionLevel<-trello.json.data$actions$data.board.prefs.permissionLevel
		card_data_board_prefs_selfJoin<-trello.json.data$actions$data.board.prefs.selfJoin
		card_data_list_name<-trello.json.data$actions$data.list.name
		card_data_list_id<-trello.json.data$actions$data.list.id
		card_data_list_closed<-trello.json.data$actions$data.list.closed
		card_data_list_pos<-trello.json.data$actions$data.list.pos
		card_data_old_due<-trello.json.data$actions$data.old.due
		card_data_old_dueComplete<-trello.json.data$actions$data.old.dueComplete
		card_data_old_name<-trello.json.data$actions$data.old.name
		card_data_old_pos<-trello.json.data$actions$data.old.pos
		card_data_old_idList<-trello.json.data$actions$data.old.idList
		card_data_old_closed<-trello.json.data$actions$data.old.closed
		card_data_old_desc<-trello.json.data$actions$data.old.desc
		card_data_old_prefs_permissionLevel<-trello.json.data$actions$data.old.prefs.permissionLevel
		card_data_old_prefs_selfJoin<-trello.json.data$actions$data.old.prefs.selfJoin
		card_data_listAfter_name<-trello.json.data$actions$data.listAfter.name
		card_data_listAfter_id<-trello.json.data$actions$data.listAfter.id
		card_data_listBefore_name<-trello.json.data$actions$data.listBefore.name
		card_data_listBefore_id<-trello.json.data$actions$data.listBefore.id
		card_data_attachment_url<-trello.json.data$actions$data.attachment.url
		card_data_attachment_name<-trello.json.data$actions$data.attachment.name
		card_data_attachment_id<-trello.json.data$actions$data.attachment.id
		card_data_attachment_previewUrl<-trello.json.data$actions$data.attachment.previewUrl
		card_data_attachment_previewUrl2x<-trello.json.data$actions$data.attachment.previewUrl2x
		card_data_cardSource_shortLink<-trello.json.data$actions$data.cardSource.shortLink
		card_data_cardSource_idShort<-trello.json.data$actions$data.cardSource.idShort
		card_data_cardSource_name<-trello.json.data$actions$data.cardSource.name
		card_data_cardSource_id<-trello.json.data$actions$data.cardSource.id
		card_data_boardSource_id<-trello.json.data$actions$data.boardSource.id
		card_data_plugin_url<-trello.json.data$actions$data.plugin.url
		card_data_plugin_public<-trello.json.data$actions$data.plugin.public
		card_data_plugin_name<-trello.json.data$actions$data.plugin.name
		card_data_plugin_id<-trello.json.data$actions$data.plugin.id
		card_data_member_name<-trello.json.data$actions$data.member.name
		card_data_member_id<-trello.json.data$actions$data.member.id
		card_data_boardTarget_id<-trello.json.data$actions$data.boardTarget.id
		card_data_organization_name<-trello.json.data$actions$data.organization.name
		card_data_organization_id<-trello.json.data$actions$data.organization.id
		card_memberCreator_id<-trello.json.data$actions$memberCreator.id
		card_memberCreator_avatarHash<-trello.json.data$actions$memberCreator.avatarHash
		card_memberCreator_fullName<-trello.json.data$actions$memberCreator.fullName
		card_memberCreator_initials<-trello.json.data$actions$memberCreator.initials
		card_memberCreator_username<-trello.json.data$actions$memberCreator.username
		card_member_id<-trello.json.data$actions$member.id
		card_member_avatarHash<-trello.json.data$actions$member.avatarHash
		card_member_fullName<-trello.json.data$actions$member.fullName
		card_member_initials<-trello.json.data$actions$member.initials
		card_member_username<-trello.json.data$actions$member.username
		card_data_card_idAttachmentCover<-trello.json.data$actions$data.card.idAttachmentCover
		card_data_old_idAttachmentCover<-trello.json.data$actions$data.old.idAttachmentCover
		card_data_attachment_edgeColor<-trello.json.data$actions$data.attachment.edgeColor




		#Checklist

		checklist_id<-trello.json.data$checklists$id
		checklist_name<-trello.json.data$checklists$name
		checklist_idBoard<-trello.json.data$checklists$idBoard
		checklist_idCard<-trello.json.data$checklists$idCard
		checklist_pos<-trello.json.data$checklists$pos
		checklist_checkItems<-trello.json.data$checklists$checkItems 
		checklist_limits_checkItems_perChecklist_status<-trello.json.data$checklists$limits.checkItems.perChecklist.status
		checklist_limits_checkItems_perChecklist_disableAt<-trello.json.data$checklists$limits.checkItems.perChecklist.disableAt
		checklist_limits_checkItems_perChecklist_warnAt<-trello.json.data$checklists$limits.chaeckItems.perChecklist.warnAt


	###################
	###bind variable###
	###################

		#Card
		a_card_data_base<-cbind(card_id, card_idMemberCreator, card_type, card_date, card_data_text, card_data_idMember, card_data_dateLastEdited, card_data_idMemberAdded, 
		card_data_memberType, card_data_idOriginalCommenter, card_data_deactivated, card_data_checkItem_textData, card_data_checkItem_state, card_data_checkItem_name, 
		card_data_checkItem_id, card_data_checklist_name, card_data_checklist_id, card_data_card_shortLink, card_data_card_idShort, card_data_card_name, card_data_card_id, 
		card_data_card_due, card_data_card_dueComplete, card_data_card_pos, card_data_card_idList, card_data_card_closed, card_data_card_desc, card_data_board_shortLink, 
		card_data_board_name, card_data_board_id, card_data_board_prefs_permissionLevel, card_data_board_prefs_selfJoin, card_data_list_name, card_data_list_id, 
		card_data_list_closed, card_data_list_pos, card_data_old_due, card_data_old_dueComplete, card_data_old_name, card_data_old_pos, card_data_old_idList, 
		card_data_old_closed, card_data_old_desc, card_data_old_prefs_permissionLevel, card_data_old_prefs_selfJoin, card_data_listAfter_name, card_data_listAfter_id, 
		card_data_listBefore_name, card_data_listBefore_id, card_data_attachment_url, card_data_attachment_name, card_data_attachment_id, card_data_attachment_previewUrl, 
		card_data_attachment_previewUrl2x, card_data_cardSource_shortLink, card_data_cardSource_idShort, card_data_cardSource_name, card_data_cardSource_id, 
		card_data_boardSource_id, card_data_plugin_url, card_data_plugin_public, card_data_plugin_name, card_data_plugin_id, card_data_member_name, card_data_member_id, 
		card_data_boardTarget_id, card_data_organization_name, card_data_organization_id, card_memberCreator_id, card_memberCreator_avatarHash, card_memberCreator_fullName, 
		card_memberCreator_initials, card_memberCreator_username, card_member_id, card_member_avatarHash, card_member_fullName, card_member_initials, card_member_username,
		card_data_card_idAttachmentCover, card_data_old_idAttachmentCover, card_data_attachment_edgeColor)


		#Checklist
		a_checklist_data_base<-cbind(checklist_id, checklist_name, checklist_idBoard, checklist_idCard, checklist_pos, checklist_checkItems, 
		checklist_limits_checkItems_perChecklist_status, checklist_limits_checkItems_perChecklist_disableAt, checklist_limits_checkItems_perChecklist_warnAt)

	################################
	###check if have new variable###
	################################

	variable_name_on_code<-colnames(a_card_data_base)
	variable_name_on_trello<-paste("card_",str_replace_all(names(trello.json.data$actions), "[.]", "_"), sep="")
	i=1
	a_error_code<-array(data = 1,dim = length(variable_name_on_code))
	while (i <= length(variable_name_on_code)){
		j=1
		while (j <=length(variable_name_on_trello)){
			if (variable_name_on_code[i] == variable_name_on_trello[j]){
				a_error_code[i] <- 0
				j=length(variable_name_on_trello)+1
			} else{
				j=j+1
			}
		}
		i=i+1
	}

	i=1
		a_error_trello<-array(data = 1,dim = length(variable_name_on_trello))
		while (i <= length(variable_name_on_trello)){
			j=1
			while (j <=length(variable_name_on_code)){
				if (variable_name_on_trello[i] == variable_name_on_code[j]){
					a_error_trello[i] <- 0
					j=length(variable_name_on_code)+1
				} else{
					j=j+1
				}
			}
			i=i+1
		}

##########################
###delete old variables###
##########################
a_a<-ls()
a_ = length(ls())-1
del_var<-c()
while (a_ > 0){
	if(substring(a_a[a_],1,2)!="a_"){
		del_var<-append(del_var, a_a[a_])
#		rm(a_a[a_])
	}
	a_=a_-1
} 
rm(list = del_var)
rm(a_)
rm(a_a)

a_card_data_base<-as.data.frame(a_card_data_base)
a_checklist_data_base<-as.data.frame(a_checklist_data_base)

if (sum(a_error_code)+sum(a_error_trello)==0){

	#########################################
	#### First report - Pages to sign 1 #####
	#########################################

	#maybe can reduce time doing a subset with only checklist that i need (ex. Niki sign page)


	n = length(a_checklist_data_base$checklist_name)   
	i = 1
	report1<-c()
	report2<-c()
	while (i <= n) {
		#find some word into one string
		if(grepl("Niki",a_checklist_data_base$checklist_name[i])==1) {
			#if find, save the name of card
			new_table<-matrix(unlist(a_card_data_base$card_data_card_name[a_card_data_base$card_data_card_id==a_checklist_data_base$checklist_idCard[i]]))
 			#report1<-append(report1, toString(subset(new_table, new_table!="NA")[1]))
 			aux<-substring(names(unlist(a_checklist_data_base[i,]$checklist_checkItems)),1,5)
 			j=1
 			ncolaux=1
 			while(j<=length(aux)-1){
 				if(aux[j]==aux[j+1]){
 					j=j+1
 					ncolaux = j
 				} else{
 					j=j+length(aux)
 				}
 			}
			table_decision <- matrix(unlist(a_checklist_data_base[i,]$checklist_checkItems), ncol = length(aux)/ncolaux,byrow = FALSE)
			table_decision <- subset(table_decision, table_decision[,1]=="incomplete")
 			if(nrow(table_decision)>0){
 				j=1
 				m<-nrow(table_decision)
 				list_incomplete_sign<-""
 				while (j<=m){
 					list_incomplete_sign<-paste(list_incomplete_sign ,table_decision[j,4],sep=" ,")
 					j=j+1
 				}
 				report2<-c(report2,substring(list_incomplete_sign,3,10000))
 			}  #o report 2 esta criando as duas coisas pra assinar como sendo linhas separadas
			 			if (length(report2)!=0){
 				report1<-append(report1, toString(subset(new_table, new_table!="NA")[1]))
 			}
		}	
		i = i + 1
	}
	report<-as.data.frame(cbind(report1,report2))
names(report)[1]="Name"
names(report)[2]="Documents to sign"

	#########################################
	#### First report - Pages to sign 2 #####
	#########################################
	
	#n_card_data_base<-subset(a_card_data_base, a_card_data_base$card_data_checklist_name!="NA")
	#n = length(n_card_data_base$card_data_checklist_name)   
	#i = 1
	#report1<-c()
	#report2<-c()
	#while (i <= n) {
		#find some word into one string
	#	if(grepl("Niki",n_card_data_base$card_data_checklist_name[i])==1) {
			#if find, save the name of card
	#		new_table<-matrix(unlist(n_card_data_base$card_data_card_name[n_card_data_base$card_data_card_id[i]==a_checklist_data_base$checklist_idCard]))
 	#		report1<-append(report1, toString(subset(new_table, new_table!="NA")[1]))
 	#		aux<-substring(names(unlist(a_checklist_data_base[n_card_data_base$card_data_card_id[i]==a_checklist_data_base$checklist_idCard,]$checklist_checkItems)),1,5)
 	#		j=1
 	#		ncolaux=1
 	#		while(j<=length(aux)-1){
 	#			if(aux[j]==aux[j+1]){
 	#				j=j+1
 	#				ncolaux = j
 	#			} else{
 	#				j=j+length(aux)
 	#			}
 	#		}
	#		table_decision <- matrix(unlist(a_checklist_data_base[n_card_data_base$card_data_card_id[i]==a_checklist_data_base$checklist_idCard,]$checklist_checkItems), ncol = length(aux)/ncolaux,byrow = FALSE)
	#		table_decision <- subset(table_decision, table_decision[,1]=="incomplete")
 	#		if(nrow(table_decision)>0){
 	#			j=1
 	#			m<-nrow(table_decision)
 	#			list_incomplete_sign<-""
 	#			while (j<=m){
 	#				list_incomplete_sign<-paste(list_incomplete_sign ,table_decision[j,4],sep=" ,")
 	#				j=j+1
 	#			}
 	#			report2<-c(report2,substring(list_incomplete_sign,3,10000))
 	#		}  #o report 2 esta criando as duas coisas pra assinar como sendo linhas separadas
	#	}	
	#	i = i + 1
	#}
	#report_additional<-as.data.frame(cbind(report1,report2))

	#names(report_additional)[1]="Name"
	#names(report_additional)[2]="Documents to sign"

	#report<-rbind(report,report_additional)

write.table(report, file=paste(getwd(),"Report_Pages_to_Sign_Niki.txt", sep="/"), sep="\t", dec=",", row.names = FALSE,col.names = TRUE, quote = FALSE)

##########################################################################


	#############################################################
	#### First report - Pages to sign Outstanding Documents #####
	#############################################################

	#maybe can reduce time doing a subset with only checklist that i need (ex. Niki sign page)


	n = length(a_checklist_data_base$checklist_name)   
	i = 1
	report1<-c()
	report2<-c()
	while (i <= n) {
		#find some word into one string
		if(grepl("Outstanding",a_checklist_data_base$checklist_name[i])==1) {
			#if find, save the name of card
			new_table<-matrix(unlist(a_card_data_base$card_data_card_name[a_card_data_base$card_data_card_id==a_checklist_data_base$checklist_idCard[i]]))
 			#report1<-append(report1, toString(subset(new_table, new_table!="NA")[1]))
 			aux<-substring(names(unlist(a_checklist_data_base[i,]$checklist_checkItems)),1,5)
 			j=1
 			ncolaux=1
 			while(j<=length(aux)-1){
 				if(aux[j]==aux[j+1]){
 					j=j+1
 					ncolaux = j
 				} else{
 					j=j+length(aux)
 				}
 			}
			table_decision <- matrix(unlist(a_checklist_data_base[i,]$checklist_checkItems), ncol = length(aux)/ncolaux,byrow = FALSE)
			table_decision <- subset(table_decision, table_decision[,1]=="incomplete")
 			if(nrow(table_decision)>0){
 				j=1
 				m<-nrow(table_decision)
 				list_incomplete_sign<-""
 				while (j<=m){
 					list_incomplete_sign<-paste(list_incomplete_sign ,table_decision[j,4],sep=" ,")
 					j=j+1
 				}
 				report2<-c(report2,substring(list_incomplete_sign,3,10000))
 			}  #o report 2 esta criando as duas coisas pra assinar como sendo linhas separadas
 			if (length(report2)!=0){
 				report1<-append(report1, toString(subset(new_table, new_table!="NA")[1]))
 			}
		}	
		i = i + 1
	}
	report<-as.data.frame(cbind(report1,report2))

names(report)[1]="Name"
names(report)[2]="Documents to sign"
#####Have error
######check
write.table(report, file=paste(getwd(),"Report_Pages_to_Sign_Outstanding_Documents.txt", sep="/"), sep="\t", dec=",", row.names = FALSE,col.names = TRUE, quote = FALSE)








} else{
	print(paste("Check the variable names, have ", sum(a_error_code)+sum(a_error_trello)," error(s). Start again",sep=""))
}



#agregate by card
#card.data.base<-sort(card.data.base, )
#card.data.base[1:15,]





#after do everything for card
#merge with another tables (like checklist)


#use actions to know what happend and i need to find the comments in a card
#use cards to know about the card and merge
#use checklist to know which activity is done or not




