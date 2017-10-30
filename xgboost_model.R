train_info_log1=read.csv(file = 'E:/file_of_the_R/repeatbuyers/out_put_file/train_info_log1.csv',header = TRUE)
complte_test=read.csv(file = 'F:/file_of_the_R/repeatbuyers/out_put_file/complte_test.csv',header = TRUE)


# set.seed(1234)
# sam=sample(dim(train_info_log1)[1],floor(dim(train_info_log1)[1]*0.75))
# train1=train_info_log1[sam,]
# test1=train_info_log1[-sam,]
# train1=as.matrix(train1)
# test1=as.matrix(test1)
# xgb1=xgboost(data=train1[,-1],label=train1[,1],nround = 10,objective = "binary:logistic")
# predict=predict(xgb1,newdata = test1[,-1],type='class')
# predict=predict(xgb1,newdata = test1[,-1])$class
# predict=predict(xgb1,newdata = test1[,-1])
# predict=predict(xgb1,newdata = test1[,-1],type='response')
# head(predict)
# head(test1)
# table(test1[,1],predict)

library(xgboost)
str(train_info_log1)
head(train_info_log1)
train_info_log2=as.matrix(train_info_log1)
head(train_info_log2)
table(train_info_log1$label)
xgb=xgboost(data=train_info_log2[,-1],label=train_info_log2[,1],nrounds = 10, objective = "binary:logistic")

head(test_order)
testorder=as.matrix(test_order)
pre=predict(xgb,newdata = testorder,type='response')

sub$prob<-pre
sum(is.na(sub$prob))
write.csv(sub,file = 'E:/file_of_the_R/repeatbuyers/out_put_file/sample_submission4.csv',row.names=F)