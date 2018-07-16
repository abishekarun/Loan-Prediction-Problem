library(dplyr)

# Feature Engineering

# Read the data
total_data_coded <- readRDS("total_data_coded.rds")

# Credit history into categories
total_data_coded <- 
  total_data_coded%>%
  mutate(credit_good = ifelse(Credit_History=="Yes",1,0))%>%
  mutate(credit_bad = ifelse(Credit_History=="No",1,0))%>%
  mutate(credit_unknown = ifelse(Credit_History=="Unknown",1,0))%>%
  select(-Credit_History)

# Adding New Numeric Variables & transformations
total_data_mod <-
  total_data_coded%>%
  mutate(Total_Income = ApplicantIncome + CoapplicantIncome,
         Loan_Per_month = LoanAmount/Loan_Amount_Term,
         debt_income_ratio = Total_Income/LoanAmount,
         debt_ratio_log=log(debt_income_ratio),
         Loan_Amount_Log=log(LoanAmount+1),
         ApplicantIncome_Log=log(ApplicantIncome+1),
         CoapplicantIncome_Log=log(CoapplicantIncome+1),
         Total_Income_Log = log(Total_Income+1),
         Loan_Per_month_Log = log(Loan_Per_month+1))

str(total_data_mod)

#Remove loan id from data
test_loan_id <- total_data_mod$Loan_ID[615:981]
total_data_mod$Loan_ID <- NULL

saveRDS(total_data_mod, "total_data_mod.rds")
saveRDS(test_loan_id, "test_id.rds")