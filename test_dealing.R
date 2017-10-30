test_info_log=read.csv(file='E:/file_of_the_R/data_file/test_info_log.csv',header = TRUE)
sub=read.csv(file='E:/file_of_the_R/data_file/data_format1/test_format1.csv',header = TRUE)
head(test_info_log)
head(sub)
test_order=merge(sub,test_info_log,by.x=c('user_id','merchant_id'),by.y=c('user_id','merchant_id'),all.y=TRUE,sort=FALSE)
test_order=subset(test_order,select = -prob.x)
names(test_order)
library(data.table)
setnames(test_order,'prob.y','prob')
head(test_order)
head(sub)
test_order=subset(test_order,select = -c(user_id,merchant_id,prob))
library(mice)
test_order$add_to_act[is.na(test_order$add_to_act)]<-0
test_order$age_range[test_order$age_range==8]<-7
test_order$age_range[test_order$age_range==0]<-NA
test_order$gender[test_order$gender==2]<-NA
head(test_order)
md.pattern(test_order)

# 1、以下是用众数或者均值代替缺失值进行缺失值处理：
a=as.data.frame(table(test_order$click))
plot(a,xlim = c(0,40))
as.data.frame(table(test_order$click))  
mean(test_order$click,na.rm = T)  #9.120221
#用均值代替缺失值：
test_order$click[is.na(test_order$click)]<-9

as.data.frame(table(test_order$purchase))
mean(test_order$purchase,na.rm = T)
test_order$purchase[is.na(test_order$purchase)]<-1

as.data.frame(table(test_order$add_to_favourite))
mean(test_order$add_to_favourite,na.rm = T)
test_order$add_to_favourite[is.na(test_order$add_to_favourite)]<-0

md.pattern(test_order)
as.data.frame(table(test_order$age_range))
as.data.frame(table(test_order$gender))
#用众数代替缺失值：
test_order$gender[is.na(test_order$gender)]<-0
test_order$age_range[is.na(test_order$age_range)]<-3

write.csv(test_info_log,file = 'F:/file_of_the_R/repeatbuyers/out_put_file/complte_test.csv',row.names = FALSE)



#-------------------------------------------------------------------------------------------------------

# 2、以下是用R包进行缺失值处理的：（时间比较久）
library(hot.deck)
imputed=hot.deck(test_order,m=1)
max(test_info_log$click,na.rm = T)
options(digits = 1)

as.data.frame(table(test_order$add_to_favourite))
as.data.frame(table(test_order$add_to_act))
head(test_order)
test_order1=test_order[1:50000,]
test_order2=test_order[50001:100000,]
test_order3=test_order[100001:150000,]
test_order4=test_order[150001:200000,]
test_order5=test_order[200001:261477,]
library(dplyr)
test_order=mutate(test_order,age_range=as.factor(age_range),gender=as.factor(gender),click=as.factor(click),add_to_act=as.factor(add_to_act),purchase=as.factor(purchase),add_to_favourite=as.factor(add_to_favourite))
head(test_order1)
library(mice)
micemod1=mice(test_order1,m=1,method = 'cart')
complete_test1=complete(micemod1)
micemod2=mice(test_order2,m=1,method = 'cart')
complete_test2=complete(micemod2)
micemod3=mice(test_order3,m=1,method = 'cart')
complete_test3=complete(micemod3)
micemod4=mice(test_order4,m=1,method = 'cart')
complete_test4=complete(micemod4)
micemod5=mice(test_order5,m=1,method = 'cart')
complete_test5=complete(micemod5)
complte_test=rbind(complete_test1,complete_test2,complete_test3,complete_test4,complete_test5)
md.pattern(complte_test)

write.csv(test_info_log,file = 'F:/file_of_the_R/repeatbuyers/out_put_file/complte_test.csv',row.names = FALSE)