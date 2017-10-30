train_info_log=read.csv(file = 'E:/file_of_the_R/data_file/train_info_log.csv',header = TRUE)
head(train_info_log)
library(mice)
train_info_log=subset(train_info_log,select=-c(user_id,merchant)) #或者train_info_log=train_info_log[,-1] train_info_log=train_info_log[,-1]
as.data.frame(table(train_info_log$add_to_act))
# 用众数代替缺失值：
train_info_log$add_to_act[is.na(train_info_log$add_to_act)]<-0
train_info_log$age_range[train_info_log$age_range==8]<-7
train_info_log$age_range[train_info_log$age_range==0]<-NA
train_info_log$gender[train_info_log$gender==2]<-NA
train_info_log=na.omit(train_info_log)
md.pattern(train_info_log)
table(train_info_log$label)
write.csv(train_info_log,file = 'F:/file_of_the_R/repeatbuyers/out_put_file/train_info_log1.csv',row.names = FALSE)