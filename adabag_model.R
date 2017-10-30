train_info_log1=read.csv(file = 'E:/file_of_the_R/data_file/train_info_log1.csv',header = TRUE)
complte_test=read.csv(file = 'F:/file_of_the_R/data_file/complte_test.csv',header = TRUE)

library(adabag)
adaboosttree=boosting(label~.,data=train_info_log)

pre=predict(adaboosttree,newdata=test_order)$prob

sub$prob<-pre
sum(is.na(sub$prob))
write.csv(sub,file = 'E:/file_of_the_R/data_file/repeat_buyers/out_put_file/sample_submission4.csv',row.names=F)