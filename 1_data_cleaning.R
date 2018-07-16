library(dplyr)
library(tidyr)

# Read the data
train_data <- read.csv("Input_data/train_u6lujuX_CVtuZ9i.csv")
test_data <- read.csv("Input_data/test_Y3wMUE5_7gLdaTN.csv")

# str(train_data)

#Get target variable
train_target <- train_data$Loan_Status

#Remove target variable from training data
train_data$Loan_Status <- NULL

total_data <- rbind(train_data,test_data)

rm(train_data,test_data)

data.frame(sapply(total_data, function(y) sum(length(which(is.na(y) | y=='')))))

# Credit History Variable
table(total_data$Credit_History,useNA = "ifany")
total_data$Credit_History <-ifelse(is.na(total_data$Credit_History),"Unknown",
                                   ifelse(total_data$Credit_History == 1,"Yes", "No"))
table(total_data$Credit_History,useNA = "ifany")

#Loan Amount Variable
summary(total_data$LoanAmount)
total_data$LoanAmount[is.na(total_data$LoanAmount)] = median(total_data$LoanAmount,
                                                           na.rm=TRUE)

#Loan Amount term Variable
table(total_data$Loan_Amount_Term,useNA = "ifany")
total_data$Loan_Amount_Term[is.na(total_data$Loan_Amount_Term)] = median(total_data$Loan_Amount_Term,
                                                           na.rm=TRUE)
  
# Gender,Married,Self_Employed Variable
levels(total_data$Gender)[1]<- "Unknown_Gender"
levels(total_data$Married)[1] <- "Unknown_Married"  
levels(total_data$Self_Employed)[1] <- "Not_Known"
levels(total_data$Self_Employed)[2] <- "UnEmployed"
levels(total_data$Self_Employed)[3] <- "Employed"

# Dependents Variable
table(total_data$Dependents)
levels(total_data$Dependents)
levels(total_data$Dependents)[1] <- "0" 
levels(total_data$Dependents)[4] <- "3" 

sapply(total_data, function(y) sum(length(which(is.na(y) | y==""))))

# str(total_data)

# One hot encoding
total_data_coded <- 
  total_data%>%
    mutate(i = 1) %>% 
    spread(Gender, i, fill = 0)%>%
    mutate(i = 1) %>%
    spread(Married, i, fill = 0)%>%
    mutate(i = 1) %>%
    spread(Self_Employed, i, fill = 0)%>%
    mutate(i = 1) %>%
    spread(Education, i, fill = 0)%>%
    mutate(i = 1) %>%
    spread(Property_Area, i, fill = 0)
# Label Encoding for Dependents
total_data_coded$Dependents <- as.numeric(total_data_coded$Dependents)

saveRDS(total_data_coded, "total_data_coded.rds")
saveRDS(train_target, "train_target.rds")
