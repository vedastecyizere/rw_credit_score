#Project Name: Credit Scoring Model
#Owner: Vedaste Cyizere
#Date Created: May 31st, 2020

#Loading directories
dd <- "D:/GitHub/rw_credit_score/data"
wd <- "D:/GitHub/pshops_database/rdata"
od <- "D:/GitHub/pshops_database/output"

#Libraries
libs <- c("lubridate", "plyr", "zoo", "reshape2", "ggplot2", "dplyr","doBy","reshape")
lapply(libs, require, character.only = T)


#Load data

#Season clients data
#2020 -----------
d20 <- read.csv(paste(dd, "SC_2020_5.7.2020.csv", sep = "/"), header = TRUE,   
               stringsAsFactors = FALSE, na.strings = "")
d20 <- subset(d20, TotalCredit > 0)


d19 <- read.csv(paste(dd, "SC_2019_6.5.2020.csv", sep = "/"), header = TRUE,   
                stringsAsFactors = FALSE, na.strings = "")
d19 <- subset(d19, TotalCredit > 0)

d18 <- read.csv(paste(dd, "SC_2018_5.7.2020.csv", sep = "/"), header = TRUE,   
                stringsAsFactors = FALSE, na.strings = "")
d18 <- subset(d18, TotalCredit > 0)


d17 <- read.csv(paste(dd, "SC_2017_6.6.2020.csv", sep = "/"), header = TRUE,   
                stringsAsFactors = FALSE, na.strings = "")
d17 <- subset(d17, TotalCredit > 0)


d16 <- read.csv(paste(dd, "SC_2016_6.6.2020.csv", sep = "/"), header = TRUE,   
                stringsAsFactors = FALSE, na.strings = "")
d16 <- subset(d16, TotalCredit > 0)


d15 <- read.csv(paste(dd, "SC_2015_6.6.2020.csv", sep = "/"), header = TRUE,   
                stringsAsFactors = FALSE, na.strings = "")
d15 <- subset(d16, TotalCredit > 0)


d14 <- read.csv(paste(dd, "SC_2014_6.6.2020.csv", sep = "/"), header = TRUE,   
                stringsAsFactors = FALSE, na.strings = "")
d14 <- subset(d14, TotalCredit > 0)

d13a <- read.csv(paste(dd, "SC_2013A_6.6.2020.csv", sep = "/"), header = TRUE,   
                stringsAsFactors = FALSE, na.strings = "")
d13a <- subset(d13a, TotalCredit > 0)

d13b <- read.csv(paste(dd, "SC_2013B_6.6.2020.csv", sep = "/"), header = TRUE,   
                 stringsAsFactors = FALSE, na.strings = "")
d13b <- subset(d13b, TotalCredit > 0)


d12a <- read.csv(paste(dd, "SC_2012A_6.6.2020.csv", sep = "/"), header = TRUE,   
                stringsAsFactors = FALSE, na.strings = "")
d12a <- subset(d12a, TotalCredit > 0)

d12b <- read.csv(paste(dd, "SC_2012B_6.6.2020.csv", sep = "/"), header = TRUE,   
                 stringsAsFactors = FALSE, na.strings = "")
d12b <- subset(d12b, TotalCredit > 0)


#Loading vertical repayment data
v20 <- read.csv(paste(dd, "VR_2020_5.20.2020.csv", sep = "/"), header = TRUE,   
                 stringsAsFactors = FALSE, na.strings = "")
v19 <- read.csv(paste(dd, "VR_2019_5.7.2020.csv", sep = "/"), header = TRUE,   
                stringsAsFactors = FALSE, na.strings = "")
v18 <- read.csv(paste(dd, "VR_2018_5.7.2020.csv", sep = "/"), header = TRUE,   
                stringsAsFactors = FALSE, na.strings = "")






#connecting to the data warehouse

source("settings.R")

library(odbc)
library(dplyr)

con <- DBI::dbConnect(odbc::odbc(),
                      Driver   = "SQL Server",
                      Server   = "mtama.oneacrefund.org,6543",
                      Database = "Rosterdatawarehouse",
                      UID      = "Vedaste.Cyizere",
                      PWD      = "O^ke@-p4R%Q!1-d4$",
                      Port     = 1433)


con <- dbConnect(odbc(),
                 Driver = "SQL Server",
                 Server = db_server,
                 Database = db_name,
                 UID    = db_user,
                 PWD    = db_pass)

query <- "select DistrictName, SiteName, GlobalClientID, RepaymentLocal, CreditLocal, OperationalYear, 
          ActiveSite, 
           from v_ClientSales where CountryName='Rwanda' and SeasonName='2019' and DistrictName='Gisagara'"

data <- dbGetQuery(conn = con, statement= query)
