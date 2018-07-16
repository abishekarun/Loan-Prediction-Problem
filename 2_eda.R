# Read the data
total_data_coded <- readRDS("total_data_coded.rds")

# str(total_data_coded)

# # Plots for checking skewing on numeric variables
hist(total_data_coded$LoanAmount)
hist(log(total_data_coded$LoanAmount))
hist(total_data_coded$ApplicantIncome)
hist(log(total_data_coded$ApplicantIncome))
hist(total_data_coded$CoapplicantIncome)
hist(log(total_data_coded$CoapplicantIncome))
