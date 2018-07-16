# Feature selection
library(caret)

library(dplyr)
# Read the data
total_data_mod <- readRDS("total_data_mod.rds")

# # calculate correlation matrix
correlationMatrix <- cor(total_data_mod)
# summarize the correlation matrix
print(correlationMatrix)
# find attributes that are highly corrected (ideally >0.75)
highlyCorrelated <- findCorrelation(correlationMatrix, cutoff=0.75)
# print indexes of highly correlated attributes
print(highlyCorrelated)

colnames(total_data_mod)[highlyCorrelated]

# Feature Selection
total_data<-
  total_data_mod%>%
  select(-Total_Income,-ApplicantIncome,-CoapplicantIncome,-LoanAmount,-Loan_Per_month,-debt_income_ratio)

saveRDS(total_data, "total_data.rds")