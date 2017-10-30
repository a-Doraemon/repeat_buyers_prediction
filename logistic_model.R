train_info_log1=read.csv(file = 'E:/file_of_the_R/repeatbuyers/out_put_file/train_info_log1.csv',header = TRUE)
complte_test=read.csv(file = 'F:/file_of_the_R/repeatbuyers/out_put_file/complte_test.csv',header = TRUE)

#Logistic�ع飺
train_info_log1$label<-as.factor(train_info_log1$label)
lg=glm(label~age_range+gender+click+add_to_act+purchase+add_to_favourite,family = binomial(link = 'logit'),data=train_info_log1)
train_info_log1$label=as.numeric(train_info_log1$label)
corr=cor(train_info_log1)
library(corrplot)
corrplot(corr,method = 'circle')

pre=predict(lg,newdata=complte_test,type='response')

sub$prob<-pre
sum(is.na(sub$prob))
write.csv(sub,file = 'E:/file_of_the_R/repeatbuyers/out_put_file/sample_submission4.csv',row.names=F)
