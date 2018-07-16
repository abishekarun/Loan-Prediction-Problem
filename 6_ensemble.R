pred1<-readRDS("test_pred1.rds")
pred2<-readRDS("test_pred2.rds")
pred3<-readRDS("test_pred3.rds")
pred4<-readRDS("test_pred4.rds")
pred5<-readRDS("test_pred5.rds")
test_loan_id <- readRDS("test_id.rds")

algorithmList <- c('rf','C5.0', 'glm','knn','svmRadial')

finalPrediction <-function(a,b,c,d,e){
  a <- ifelse(a == 'Y', 1, 0)
  b <- ifelse(b == 'Y', 1, 0)
  c <- ifelse(c == 'Y', 1, 0)
  d <- ifelse(d == 'Y', 1, 0)
  e <- ifelse(e == 'Y', 1, 0)
  sum <- sum(a+b+c+d+e)
  output <- ifelse(sum>=3,'Y','N')
  return(output)
}

results <- mapply(finalPrediction,pred1,pred2,pred3,pred4,pred5)

output = data.frame(Loan_ID = test_loan_id,Loan_Status = results)

write.table(output,"submission.csv",row.names=FALSE, col.names=TRUE, sep=",")
