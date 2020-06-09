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
d19 <- subset(d19, TotalCredit > 0 | Deceased == "True")

d18 <- read.csv(paste(dd, "SC_2018_5.7.2020.csv", sep = "/"), header = TRUE,   
                stringsAsFactors = FALSE, na.strings = "")
d18 <- subset(d18, TotalCredit > 0 | Deceased == "True")


d17 <- read.csv(paste(dd, "SC_2017_6.6.2020.csv", sep = "/"), header = TRUE,   
                stringsAsFactors = FALSE, na.strings = "")
d17 <- subset(d17, TotalCredit > 0 | Deceased == "True")


d16 <- read.csv(paste(dd, "SC_2016_6.6.2020.csv", sep = "/"), header = TRUE,   
                stringsAsFactors = FALSE, na.strings = "")
d16 <- subset(d16, TotalCredit > 0 | Deceased == "True")


d15 <- read.csv(paste(dd, "SC_2015_6.6.2020.csv", sep = "/"), header = TRUE,   
                stringsAsFactors = FALSE, na.strings = "")
d15 <- subset(d15, TotalCredit > 0 | Deceased == "True")


d14 <- read.csv(paste(dd, "SC_2014_6.6.2020.csv", sep = "/"), header = TRUE,   
                stringsAsFactors = FALSE, na.strings = "")
d14 <- subset(d14, TotalCredit > 0 | Deceased == "True")

d13a <- read.csv(paste(dd, "SC_2013A_6.6.2020.csv", sep = "/"), header = TRUE,   
                stringsAsFactors = FALSE, na.strings = "")
d13a <- subset(d13a, TotalCredit > 0 | Deceased == "True")

d13b <- read.csv(paste(dd, "SC_2013B_6.6.2020.csv", sep = "/"), header = TRUE,   
                 stringsAsFactors = FALSE, na.strings = "")
d13b <- subset(d13b, TotalCredit > 0 | Deceased == "True")


d12a <- read.csv(paste(dd, "SC_2012A_6.6.2020.csv", sep = "/"), header = TRUE,   
                stringsAsFactors = FALSE, na.strings = "")
d12a <- subset(d12a, TotalCredit > 0 | Deceased == "True")

d12b <- read.csv(paste(dd, "SC_2012B_6.6.2020.csv", sep = "/"), header = TRUE,   
                 stringsAsFactors = FALSE, na.strings = "")
d12b <- subset(d12b, TotalCredit > 0 | Deceased == "True")


#Loading vertical repayment data
v20 <- read.csv(paste(dd, "VR_2020_5.20.2020.csv", sep = "/"), header = TRUE,   
                 stringsAsFactors = FALSE, na.strings = "")
v19 <- read.csv(paste(dd, "VR_2019_5.7.2020.csv", sep = "/"), header = TRUE,   
                stringsAsFactors = FALSE, na.strings = "")
v18 <- read.csv(paste(dd, "VR_2018_5.7.2020.csv", sep = "/"), header = TRUE,   
                stringsAsFactors = FALSE, na.strings = "")
v17 <- read.csv(paste(dd, "VR_2017_6.6.2020.csv", sep = "/"), header = TRUE,   
                stringsAsFactors = FALSE, na.strings = "")
v16 <- read.csv(paste(dd, "VR_2016_6.6.2020.csv", sep = "/"), header = TRUE,   
                stringsAsFactors = FALSE, na.strings = "")
v15 <- read.csv(paste(dd, "VR_2015_6.6.2020.csv", sep = "/"), header = TRUE,   
                stringsAsFactors = FALSE, na.strings = "")
v14 <- read.csv(paste(dd, "VR_2014_6.6.2020.csv", sep = "/"), header = TRUE,   
                stringsAsFactors = FALSE, na.strings = "")
v13b <- read.csv(paste(dd, "VR_2013B_6.6.2020.csv", sep = "/"), header = TRUE,   
                stringsAsFactors = FALSE, na.strings = "")
v13a <- read.csv(paste(dd, "VR_2013A_6.6.2020.csv", sep = "/"), header = TRUE,   
                stringsAsFactors = FALSE, na.strings = "")
v12b <- read.csv(paste(dd, "VR_2012B_6.6.2020.csv", sep = "/"), header = TRUE,   
                 stringsAsFactors = FALSE, na.strings = "")
v12a <- read.csv(paste(dd, "VR_2012A_6.6.2020.csv", sep = "/"), header = TRUE,   
                 stringsAsFactors = FALSE, na.strings = "")

#Remove unnecessary variables
dim(d20)
dim(d19)
dim(d18)
dim(d17)
dim(d16)
dim(d15)
dim(d14)
dim(d13a)
dim(d13a)
dim(d12a)
dim(d12b)

#use vertical repayment to generate each farmers' payments made by repayment deadline
#Will easier the defaulting determination
#Let's peform also monthly performance

#First, let's change dates
v201$date <- as.Date(v201$RepaymentDate)
v191$date <- as.Date(v191$RepaymentDate)
v181$date <- as.Date(v181$RepaymentDate)
v171$date <- as.Date(v171$RepaymentDate)
v161$date <- as.Date(v161$RepaymentDate)
v151$date <- as.Date(v151$RepaymentDate)
v141$date <- as.Date(v141$RepaymentDate)
v13b1$date <- as.Date(v13b1$RepaymentDate)
v13a1$date <- as.Date(v13a1$RepaymentDate)
v12b1$date <- as.Date(v12b1$RepaymentDate)
v12a1$date <- as.Date(v12a1$RepaymentDate)

#To avoid slow processing, let's save and remove sc data and vertical repayment first
save(d20, file = paste(wd,"d20.Rdata", sep ="/"))
save(d19, file = paste(wd,"d19.Rdata", sep ="/"))
save(d18, file = paste(wd,"d18.Rdata", sep ="/"))
save(d17, file = paste(wd,"d17.Rdata", sep ="/"))
save(d16, file = paste(wd,"d16.Rdata", sep ="/"))
save(d15, file = paste(wd,"d15.Rdata", sep ="/"))
save(d14, file = paste(wd,"d14.Rdata", sep ="/"))
save(d13b, file = paste(wd,"d13b.Rdata", sep ="/"))
save(d13a, file = paste(wd,"d13a.Rdata", sep ="/"))
save(d12b, file = paste(wd,"d12b.Rdata", sep ="/"))
save(d12a, file = paste(wd,"d12a.Rdata", sep ="/"))
save(v191, file = paste(wd,"v191.Rdata", sep ="/"))
save(v181, file = paste(wd,"v181.Rdata", sep ="/"))
save(v171, file = paste(wd,"v171.Rdata", sep ="/"))
save(v161, file = paste(wd,"v161.Rdata", sep ="/"))
save(v151, file = paste(wd,"v151.Rdata", sep ="/"))
save(v141, file = paste(wd,"v141.Rdata", sep ="/"))
save(v13b1, file = paste(wd,"v13b1.Rdata", sep ="/"))
save(v13a1, file = paste(wd,"v13a1.Rdata", sep ="/"))
save(v12b1, file = paste(wd,"v12b1.Rdata", sep ="/"))
save(v12a1, file = paste(wd,"v12a1.Rdata", sep ="/"))



#Now, let's remove them
rm(d20, d19, d18, d17, d16,d15,d14, d13a, 
   d13b, d12a, d12b,v191, v181, v171, v161, v151, v141, v13b1,
   v13a, v13b, v13a1, v12a, v12a1, v12b, v12b1, v20, v19, v18, v17, v16, v15, v14)

summary(v20$date)
v202 <- v201 %>%
        group_by(GlobalClientID) %>%
        summarise(pd.by.aug = sum(Amount[date < "2019-09-01"]),
                  pd.by.sep = sum(Amount[date < "2019-10-01"]),
                  pd.by.oct = sum(Amount[date < "2019-11-01"]),
                  pd.by.nov = sum(Amount[date < "2019-12-01"]),
                  pd.by.dec = sum(Amount[date < "2020-01-01"]),
                  pd.by.jan = sum(Amount[date < "2020-02-01"]),
                  pd.by.feb = sum(Amount[date < "2020-03-01"]),
                  pd.by.mar = sum(Amount[date < "2020-04-01"]),
                  pd.by.apr = sum(Amount[date < "2020-05-01"]),
                  pd.by.may = sum(Amount[date < "2020-06-01"]),
                  pd.by.jun = sum(Amount[date < "2020-07-01"]),
                  pd.by.jul = sum(Amount[date < "2020-08-01"]))

#save
save(v202, file = paste(wd,"v202.Rdata", sep ="/"))
load(file = paste(wd,"v202.Rdata", sep ="/"))
rm(v201)

load(file = paste(wd,"v191.Rdata", sep ="/"))
v192 <- v191 %>%
        group_by(GlobalClientID) %>%
        summarise(pd.by.aug = sum(Amount[date < "2018-09-01"]),
                  pd.by.sep = sum(Amount[date < "2018-10-01"]),
                  pd.by.oct = sum(Amount[date < "2018-11-01"]),
                  pd.by.nov = sum(Amount[date < "2018-12-01"]),
                  pd.by.dec = sum(Amount[date < "2019-01-01"]),
                  pd.by.jan = sum(Amount[date < "2019-02-01"]),
                  pd.by.feb = sum(Amount[date < "2019-03-01"]),
                  pd.by.mar = sum(Amount[date < "2019-04-01"]),
                  pd.by.apr = sum(Amount[date < "2019-05-01"]),
                  pd.by.may = sum(Amount[date < "2019-06-01"]),
                  pd.by.jun = sum(Amount[date < "2019-07-01"]),
                  pd.by.jul = sum(Amount[date < "2019-08-01"]))
save(v192, file = paste(wd,"v192.Rdata", sep ="/"))
load(file = paste(wd,"v192.Rdata", sep ="/"))


rm(v191)

load(file = paste(wd,"v181.Rdata", sep ="/"))
v182 <- v181 %>%
        group_by(GlobalClientID) %>%
        summarise(pd.by.aug = sum(Amount[date < "2017-09-01"]),
                  pd.by.sep = sum(Amount[date < "2017-10-01"]),
                  pd.by.oct = sum(Amount[date < "2017-11-01"]),
                  pd.by.nov = sum(Amount[date < "2017-12-01"]),
                  pd.by.dec = sum(Amount[date < "2018-01-01"]),
                  pd.by.jan = sum(Amount[date < "2018-02-01"]),
                  pd.by.feb = sum(Amount[date < "2018-03-01"]),
                  pd.by.mar = sum(Amount[date < "2018-04-01"]),
                  pd.by.apr = sum(Amount[date < "2018-05-01"]),
                  pd.by.may = sum(Amount[date < "2018-06-01"]),
                  pd.by.jun = sum(Amount[date < "2018-07-01"]),
                  pd.by.jul = sum(Amount[date < "2018-08-01"]))
save(v182, file = paste(wd,"v182.Rdata", sep ="/"))
load(file = paste(wd,"v182.Rdata", sep ="/"))

rm(v181)

load(file = paste(wd,"v171.Rdata", sep ="/"))


v172 <- v171 %>%
        group_by(GlobalClientID) %>%
        summarise(pd.by.aug = sum(Amount[date < "2016-09-01"]),
                  pd.by.sep = sum(Amount[date < "2016-10-01"]),
                  pd.by.oct = sum(Amount[date < "2016-11-01"]),
                  pd.by.nov = sum(Amount[date < "2016-12-01"]),
                  pd.by.dec = sum(Amount[date < "2017-01-01"]),
                  pd.by.jan = sum(Amount[date < "2017-02-01"]),
                  pd.by.feb = sum(Amount[date < "2017-03-01"]),
                  pd.by.mar = sum(Amount[date < "2017-04-01"]),
                  pd.by.apr = sum(Amount[date < "2017-05-01"]),
                  pd.by.may = sum(Amount[date < "2017-06-01"]),
                  pd.by.jun = sum(Amount[date < "2017-07-01"]),
                  pd.by.jul = sum(Amount[date < "2017-08-01"]))
save(v172, file = paste(wd,"v172.Rdata", sep ="/"))
load(file = paste(wd,"v172.Rdata", sep ="/"))

rm(v171)


load(file = paste(wd,"v161.Rdata", sep ="/"))

v162 <- v161 %>%
        group_by(GlobalClientID) %>%
        summarise(pd.by.aug = sum(Amount[date < "2015-09-01"]),
                  pd.by.sep = sum(Amount[date < "2015-10-01"]),
                  pd.by.oct = sum(Amount[date < "2015-11-01"]),
                  pd.by.nov = sum(Amount[date < "2015-12-01"]),
                  pd.by.dec = sum(Amount[date < "2016-01-01"]),
                  pd.by.jan = sum(Amount[date < "2016-02-01"]),
                  pd.by.feb = sum(Amount[date < "2016-03-01"]),
                  pd.by.mar = sum(Amount[date < "2016-04-01"]),
                  pd.by.apr = sum(Amount[date < "2016-05-01"]),
                  pd.by.may = sum(Amount[date < "2016-06-01"]),
                  pd.by.jun = sum(Amount[date < "2016-07-01"]),
                  pd.by.jul = sum(Amount[date < "2016-08-01"]))
save(v162, file = paste(wd,"v162.Rdata", sep ="/"))
load(file = paste(wd,"v162.Rdata", sep ="/"))
rm(v161)

load(file = paste(wd,"v151.Rdata", sep ="/"))

v152 <- v151 %>%
        group_by(GlobalClientID) %>%
        summarise(pd.by.aug = sum(Amount[date < "2014-09-01"]),
                  pd.by.sep = sum(Amount[date < "2014-10-01"]),
                  pd.by.oct = sum(Amount[date < "2014-11-01"]),
                  pd.by.nov = sum(Amount[date < "2014-12-01"]),
                  pd.by.dec = sum(Amount[date < "2015-01-01"]),
                  pd.by.jan = sum(Amount[date < "2015-02-01"]),
                  pd.by.feb = sum(Amount[date < "2015-03-01"]),
                  pd.by.mar = sum(Amount[date < "2015-04-01"]),
                  pd.by.apr = sum(Amount[date < "2015-05-01"]),
                  pd.by.may = sum(Amount[date < "2015-06-01"]),
                  pd.by.jun = sum(Amount[date < "2015-07-01"]),
                  pd.by.jul = sum(Amount[date < "2015-08-01"]))
save(v152, file = paste(wd,"v152.Rdata", sep ="/"))
load(file = paste(wd,"v152.Rdata", sep ="/"))

rm(v151)

load(file = paste(wd,"v141.Rdata", sep ="/"))

v142 <- v141 %>%
        group_by(GlobalClientID) %>%
        summarise(pd.by.aug = sum(Amount[date < "2013-09-01"]),
                  pd.by.sep = sum(Amount[date < "2013-10-01"]),
                  pd.by.oct = sum(Amount[date < "2013-11-01"]),
                  pd.by.nov = sum(Amount[date < "2013-12-01"]),
                  pd.by.dec = sum(Amount[date < "2014-01-01"]),
                  pd.by.jan = sum(Amount[date < "2014-02-01"]),
                  pd.by.feb = sum(Amount[date < "2014-03-01"]),
                  pd.by.mar = sum(Amount[date < "2014-04-01"]),
                  pd.by.apr = sum(Amount[date < "2014-05-01"]),
                  pd.by.may = sum(Amount[date < "2014-06-01"]),
                  pd.by.jun = sum(Amount[date < "2014-07-01"]),
                  pd.by.jul = sum(Amount[date < "2014-08-01"]))

save(v142, file = paste(wd,"v142.Rdata", sep ="/"))
load(file = paste(wd,"v142.Rdata", sep ="/"))

rm(v141)

load(file = paste(wd,"v13b1.Rdata", sep ="/"))
load(file = paste(wd,"v13a1.Rdata", sep ="/"))

#Vedaste to sort out - Due to particularity on 2012 and 2013, let's pause them a bit

##################################################################
dim(v202)
dim(v192)
dim(v182)
dim(v172)
dim(v162)
dim(v152)
dim(v142)

#Add these numbers to season clients data
#We need to run back season clients
load(file = paste(wd,"d20.Rdata", sep ="/"))
load(file = paste(wd,"d19.Rdata", sep ="/"))
load(file = paste(wd,"d18.Rdata", sep ="/"))
load(file = paste(wd,"d17.Rdata", sep ="/"))
load(file = paste(wd,"d16.Rdata", sep ="/"))
load(file = paste(wd,"d15.Rdata", sep ="/"))
load(file = paste(wd,"d14.Rdata", sep ="/"))
load(file = paste(wd,"d13a.Rdata", sep ="/"))
load(file = paste(wd,"d13b.Rdata", sep ="/"))
load(file = paste(wd,"d13a.Rdata", sep ="/"))
load(file = paste(wd,"d12b.Rdata", sep ="/"))
load(file = paste(wd,"d12a.Rdata", sep ="/"))

#Now, we need to add A_cycle credit and Total credit to vertical repayment
v202$TotalCredit <- d20$TotalCredit[match(v202$GlobalClientID, d20$GlobalClientID)]
v192$TotalCredit <- d19$TotalCredit[match(v192$GlobalClientID, d19$GlobalClientID)]
v182$TotalCredit <- d18$TotalCredit[match(v182$GlobalClientID, d18$GlobalClientID)]
v172$TotalCredit <- d17$TotalCredit[match(v172$GlobalClientID, d17$GlobalClientID)]
v162$TotalCredit <- d16$TotalCredit[match(v162$GlobalClientID, d16$GlobalClientID)]
v152$TotalCredit <- d15$TotalCredit[match(v152$GlobalClientID, d15$GlobalClientID)]
v142$TotalCredit <- d14$TotalCredit[match(v142$GlobalClientID, d14$GlobalClientID)]

#Let's also add A-cyclecredit
v202$X2020A_CycleCredit <- d20$X2020A_CycleCredit[match(v202$GlobalClientID, d20$GlobalClientID)]
v192$X2019A_CycleCredit <- d19$X2019A_CycleCredit[match(v192$GlobalClientID, d19$GlobalClientID)]
v182$X2018A_CycleCredit <- d18$X2018A_CycleCredit[match(v182$GlobalClientID, d18$GlobalClientID)]
v172$X2017A_CycleCredit <- d17$X2017A_CycleCredit[match(v172$GlobalClientID, d17$GlobalClientID)]
v162$X2016A_CycleCredit <- d16$X2016A_CycleCredit[match(v162$GlobalClientID, d16$GlobalClientID)]
v152$X2015A_CycleCredit <- d15$X2015A_CycleCredit[match(v152$GlobalClientID, d15$GlobalClientID)]
v142$X2014A_CycleCredit <- d14$X2014A_CycleCredit[match(v142$GlobalClientID, d14$GlobalClientID)]

#check
length(unique(v202$GlobalClientID[is.na(v202$TotalCredit)]))
length(unique(v192$GlobalClientID[is.na(v192$TotalCredit)]))

#vedaste to fix: Next time, use account number for everything. 
#Ex: For 2020, we are not taking Giheke into account for Season client because GlobalClientID changed


#Now, let's calculate monthly percentage repaid
v202$rpd.aug <- round(100*v202$pd.by.aug/v202$X2020A_CycleCredit, 1)
v202$rpd.sep <- round(100*v202$pd.by.sep/v202$X2020A_CycleCredit, 1)
v202$rpd.oct <- round(100*v202$pd.by.oct/v202$X2020A_CycleCredit, 1)
v202$rpd.nov <- round(100*v202$pd.by.nov/v202$X2020A_CycleCredit, 1)
v202$rpd.dec <- round(100*v202$pd.by.dec/v202$X2020A_CycleCredit, 1)
v202$rpd.jan <- round(100*v202$pd.by.jan/v202$TotalCredit, 1)
v202$rpd.feb <- round(100*v202$pd.by.feb/v202$TotalCredit, 1)
v202$rpd.mar <- round(100*v202$pd.by.mar/v202$TotalCredit, 1)
v202$rpd.apr <- round(100*v202$pd.by.apr/v202$TotalCredit, 1)
v202$rpd.may <- round(100*v202$pd.by.may/v202$TotalCredit, 1)
v202$rpd.jun <- round(100*v202$pd.by.jun/v202$TotalCredit, 1)
v202$rpd.jul <- round(100*v202$pd.by.jul/v202$TotalCredit, 1)

#check
View(v202)

#do the same for other years
v192$rpd.aug <- round(100*v192$pd.by.aug/v192$X2019A_CycleCredit, 1)
v192$rpd.sep <- round(100*v192$pd.by.sep/v192$X2019A_CycleCredit, 1)
v192$rpd.oct <- round(100*v192$pd.by.oct/v192$X2019A_CycleCredit, 1)
v192$rpd.nov <- round(100*v192$pd.by.nov/v192$X2019A_CycleCredit, 1)
v192$rpd.dec <- round(100*v192$pd.by.dec/v192$X2019A_CycleCredit, 1)
v192$rpd.jan <- round(100*v192$pd.by.jan/v192$TotalCredit, 1)
v192$rpd.feb <- round(100*v192$pd.by.feb/v192$TotalCredit, 1)
v192$rpd.mar <- round(100*v192$pd.by.mar/v192$TotalCredit, 1)
v192$rpd.apr <- round(100*v192$pd.by.apr/v192$TotalCredit, 1)
v192$rpd.may <- round(100*v192$pd.by.may/v192$TotalCredit, 1)
v192$rpd.jun <- round(100*v192$pd.by.jun/v192$TotalCredit, 1)
v192$rpd.jul <- round(100*v192$pd.by.jul/v192$TotalCredit, 1)

#For 2018
v182$rpd.aug <- round(100*v182$pd.by.aug/v182$X2018A_CycleCredit, 1)
v182$rpd.sep <- round(100*v182$pd.by.sep/v182$X2018A_CycleCredit, 1)
v182$rpd.oct <- round(100*v182$pd.by.oct/v182$X2018A_CycleCredit, 1)
v182$rpd.nov <- round(100*v182$pd.by.nov/v182$X2018A_CycleCredit, 1)
v182$rpd.dec <- round(100*v182$pd.by.dec/v182$X2018A_CycleCredit, 1)
v182$rpd.jan <- round(100*v182$pd.by.jan/v182$TotalCredit, 1)
v182$rpd.feb <- round(100*v182$pd.by.feb/v182$TotalCredit, 1)
v182$rpd.mar <- round(100*v182$pd.by.mar/v182$TotalCredit, 1)
v182$rpd.apr <- round(100*v182$pd.by.apr/v182$TotalCredit, 1)
v182$rpd.may <- round(100*v182$pd.by.may/v182$TotalCredit, 1)
v182$rpd.jun <- round(100*v182$pd.by.jun/v182$TotalCredit, 1)
v182$rpd.jul <- round(100*v182$pd.by.jul/v182$TotalCredit, 1)

#2017
v172$rpd.aug <- round(100*v172$pd.by.aug/v172$X2017A_CycleCredit, 1)
v172$rpd.sep <- round(100*v172$pd.by.sep/v172$X2017A_CycleCredit, 1)
v172$rpd.oct <- round(100*v172$pd.by.oct/v172$X2017A_CycleCredit, 1)
v172$rpd.nov <- round(100*v172$pd.by.nov/v172$X2017A_CycleCredit, 1)
v172$rpd.dec <- round(100*v172$pd.by.dec/v172$X2017A_CycleCredit, 1)
v172$rpd.jan <- round(100*v172$pd.by.jan/v172$TotalCredit, 1)
v172$rpd.feb <- round(100*v172$pd.by.feb/v172$TotalCredit, 1)
v172$rpd.mar <- round(100*v172$pd.by.mar/v172$TotalCredit, 1)
v172$rpd.apr <- round(100*v172$pd.by.apr/v172$TotalCredit, 1)
v172$rpd.may <- round(100*v172$pd.by.may/v172$TotalCredit, 1)
v172$rpd.jun <- round(100*v172$pd.by.jun/v172$TotalCredit, 1)
v172$rpd.jul <- round(100*v172$pd.by.jul/v172$TotalCredit, 1)

#for 2016
v162$rpd.aug <- round(100*v162$pd.by.aug/v162$X2016A_CycleCredit, 1)
v162$rpd.sep <- round(100*v162$pd.by.sep/v162$X2016A_CycleCredit, 1)
v162$rpd.oct <- round(100*v162$pd.by.oct/v162$X2016A_CycleCredit, 1)
v162$rpd.nov <- round(100*v162$pd.by.nov/v162$X2016A_CycleCredit, 1)
v162$rpd.dec <- round(100*v162$pd.by.dec/v162$X2016A_CycleCredit, 1)
v162$rpd.jan <- round(100*v162$pd.by.jan/v162$TotalCredit, 1)
v162$rpd.feb <- round(100*v162$pd.by.feb/v162$TotalCredit, 1)
v162$rpd.mar <- round(100*v162$pd.by.mar/v162$TotalCredit, 1)
v162$rpd.apr <- round(100*v162$pd.by.apr/v162$TotalCredit, 1)
v162$rpd.may <- round(100*v162$pd.by.may/v162$TotalCredit, 1)
v162$rpd.jun <- round(100*v162$pd.by.jun/v162$TotalCredit, 1)
v162$rpd.jul <- round(100*v162$pd.by.jul/v162$TotalCredit, 1)

#2015
v152$rpd.aug <- round(100*v152$pd.by.aug/v152$X2015A_CycleCredit, 1)
v152$rpd.sep <- round(100*v152$pd.by.sep/v152$X2015A_CycleCredit, 1)
v152$rpd.oct <- round(100*v152$pd.by.oct/v152$X2015A_CycleCredit, 1)
v152$rpd.nov <- round(100*v152$pd.by.nov/v152$X2015A_CycleCredit, 1)
v152$rpd.dec <- round(100*v152$pd.by.dec/v152$X2015A_CycleCredit, 1)
v152$rpd.jan <- round(100*v152$pd.by.jan/v152$TotalCredit, 1)
v152$rpd.feb <- round(100*v152$pd.by.feb/v152$TotalCredit, 1)
v152$rpd.mar <- round(100*v152$pd.by.mar/v152$TotalCredit, 1)
v152$rpd.apr <- round(100*v152$pd.by.apr/v152$TotalCredit, 1)
v152$rpd.may <- round(100*v152$pd.by.may/v152$TotalCredit, 1)
v152$rpd.jun <- round(100*v152$pd.by.jun/v152$TotalCredit, 1)
v152$rpd.jul <- round(100*v152$pd.by.jul/v152$TotalCredit, 1)

#2014
v142$rpd.aug <- round(100*v142$pd.by.aug/v142$X2014A_CycleCredit, 1)
v142$rpd.sep <- round(100*v142$pd.by.sep/v142$X2014A_CycleCredit, 1)
v142$rpd.oct <- round(100*v142$pd.by.oct/v142$X2014A_CycleCredit, 1)
v142$rpd.nov <- round(100*v142$pd.by.nov/v142$X2014A_CycleCredit, 1)
v142$rpd.dec <- round(100*v142$pd.by.dec/v142$X2014A_CycleCredit, 1)
v142$rpd.jan <- round(100*v142$pd.by.jan/v142$TotalCredit, 1)
v142$rpd.feb <- round(100*v142$pd.by.feb/v142$TotalCredit, 1)
v142$rpd.mar <- round(100*v142$pd.by.mar/v142$TotalCredit, 1)
v142$rpd.apr <- round(100*v142$pd.by.apr/v142$TotalCredit, 1)
v142$rpd.may <- round(100*v142$pd.by.may/v142$TotalCredit, 1)
v142$rpd.jun <- round(100*v142$pd.by.jun/v142$TotalCredit, 1)
v142$rpd.jul <- round(100*v142$pd.by.jul/v142$TotalCredit, 1)

#check
View(v142)

#Now, let's determine how many months a farmer was on health paths

#Referred to monthly health path below
#A+B clients: https://docs.google.com/spreadsheets/d/11ongPBJCkbzyr0e0wY3ETgKAN6UXIlkNdLaIdW-LEt8/edit#gid=1222221041
#B only clients: https://docs.google.com/spreadsheets/d/1W8vGW8cjZpS4nsR8QdOPRc-zy38XJsSLn-B0Oacby0c/edit#gid=1971860943

v202$hp.aug <- ifelse(v202$rpd.aug >= 13.7 & !is.infinite(v202$rpd.aug) & v202$X2020A_CycleCredit > 0, 1,0)
v202$hp.sep <- ifelse(v202$rpd.sep >= 31.2 & !is.infinite(v202$rpd.sep) & v202$X2020A_CycleCredit > 0, 1,0)

v202$hp.oct <- ifelse(v202$rpd.oct >= 38.7 & !is.infinite(v202$rpd.oct) & v202$X2020A_CycleCredit > 0, 1,0)

v202$hp.nov <- ifelse(v202$rpd.nov >= 52.3 & !is.infinite(v202$rpd.nov) & v202$X2020A_CycleCredit > 0, 1, 0)

v202$hp.dec <- ifelse(v202$rpd.dec >= 64 & !is.infinite(v202$rpd.dec) & v202$X2020A_CycleCredit > 0, 1, 0)

v202$hp.jan <- ifelse(v202$rpd.jan >= 42.1, 1,0)
v202$hp.jan <- ifelse(v202$X2020A_CycleCredit == 0 & v202$rpd.jan >= 19.6,1,v202$hp.jan)

v202$hp.feb <- ifelse(v202$rpd.feb >= 49.4, 1,0)
v202$hp.feb <- ifelse(v202$X2020A_CycleCredit == 0 & v202$rpd.feb >= 38.3,1,v202$hp.feb)

v202$hp.mar <- ifelse(v202$rpd.mar >= 58.8, 1,0)
v202$hp.mar <- ifelse(v202$X2020A_CycleCredit == 0 & v202$rpd.mar >= 50,1,v202$hp.mar)

v202$hp.apr <- ifelse(v202$rpd.apr >= 65.9, 1,0)
v202$hp.apr <- ifelse(v202$X2020A_CycleCredit == 0 & v202$rpd.apr >= 60,1,v202$hp.apr)

v202$hp.may <- ifelse(v202$rpd.may >= 77.8, 1,0)
v202$hp.may <- ifelse(v202$X2020A_CycleCredit == 0 & v202$rpd.may >= 74.1,1,v202$hp.may)

v202$hp.jun <- ifelse(v202$rpd.jun >= 90.2, 1,0)
v202$hp.jun <- ifelse(v202$X2020A_CycleCredit == 0 & v202$rpd.jun >= 89,1,v202$hp.jun)

v202$hp.jul <- ifelse(v202$rpd.jul >= 100, 1,0)
v202$hp.jul <- ifelse(v202$X2020A_CycleCredit == 0 & v202$rpd.jul >= 100,1,v202$hp.jul)

#For 2019
v192$hp.aug <- ifelse(v192$rpd.aug >= 13.7 & !is.infinite(v192$rpd.aug) & v192$X2019A_CycleCredit > 0, 1,0)
v192$hp.sep <- ifelse(v192$rpd.sep >= 31.2 & !is.infinite(v192$rpd.sep) & v192$X2019A_CycleCredit > 0, 1,0)

v192$hp.oct <- ifelse(v192$rpd.oct >= 38.7 & !is.infinite(v192$rpd.oct) & v192$X2019A_CycleCredit > 0, 1,0)

v192$hp.nov <- ifelse(v192$rpd.nov >= 52.3 & !is.infinite(v192$rpd.nov) & v192$X2019A_CycleCredit > 0, 1, 0)

v192$hp.dec <- ifelse(v192$rpd.dec >= 64 & !is.infinite(v192$rpd.dec) & v192$X2019A_CycleCredit > 0, 1, 0)

v192$hp.jan <- ifelse(v192$rpd.jan >= 42.1, 1,0)
v192$hp.jan <- ifelse(v192$X2019A_CycleCredit == 0 & v192$rpd.jan >= 19.6,1,v192$hp.jan)

v192$hp.feb <- ifelse(v192$rpd.feb >= 49.4, 1,0)
v192$hp.feb <- ifelse(v192$X2019A_CycleCredit == 0 & v192$rpd.feb >= 38.3,1,v192$hp.feb)

v192$hp.mar <- ifelse(v192$rpd.mar >= 58.8, 1,0)
v192$hp.mar <- ifelse(v192$X2019A_CycleCredit == 0 & v192$rpd.mar >= 50,1,v192$hp.mar)

v192$hp.apr <- ifelse(v192$rpd.apr >= 65.9, 1,0)
v192$hp.apr <- ifelse(v192$X2019A_CycleCredit == 0 & v192$rpd.apr >= 60,1,v192$hp.apr)

v192$hp.may <- ifelse(v192$rpd.may >= 77.8, 1,0)
v192$hp.may <- ifelse(v192$X2019A_CycleCredit == 0 & v192$rpd.may >= 74.1,1,v192$hp.may)

v192$hp.jun <- ifelse(v192$rpd.jun >= 90.2, 1,0)
v192$hp.jun <- ifelse(v192$X2019A_CycleCredit == 0 & v192$rpd.jun >= 89,1,v192$hp.jun)

v192$hp.jul <- ifelse(v192$rpd.jul >= 100, 1,0)
v192$hp.jul <- ifelse(v192$X2019A_CycleCredit == 0 & v192$rpd.jul >= 100,1,v192$hp.jul)

#For 2018
v182$hp.aug <- ifelse(v182$rpd.aug >= 13.7 & !is.infinite(v182$rpd.aug) & v182$X2018A_CycleCredit > 0, 1,0)
v182$hp.sep <- ifelse(v182$rpd.sep >= 31.2 & !is.infinite(v182$rpd.sep) & v182$X2018A_CycleCredit > 0, 1,0)

v182$hp.oct <- ifelse(v182$rpd.oct >= 38.7 & !is.infinite(v182$rpd.oct) & v182$X2018A_CycleCredit > 0, 1,0)

v182$hp.nov <- ifelse(v182$rpd.nov >= 52.3 & !is.infinite(v182$rpd.nov) & v182$X2018A_CycleCredit > 0, 1, 0)

v182$hp.dec <- ifelse(v182$rpd.dec >= 64 & !is.infinite(v182$rpd.dec) & v182$X2018A_CycleCredit > 0, 1, 0)

v182$hp.jan <- ifelse(v182$rpd.jan >= 42.1, 1,0)
v182$hp.jan <- ifelse(v182$X2018A_CycleCredit == 0 & v182$rpd.jan >= 19.6,1,v182$hp.jan)

v182$hp.feb <- ifelse(v182$rpd.feb >= 49.4, 1,0)
v182$hp.feb <- ifelse(v182$X2018A_CycleCredit == 0 & v182$rpd.feb >= 38.3,1,v182$hp.feb)

v182$hp.mar <- ifelse(v182$rpd.mar >= 58.8, 1,0)
v182$hp.mar <- ifelse(v182$X2018A_CycleCredit == 0 & v182$rpd.mar >= 50,1,v182$hp.mar)

v182$hp.apr <- ifelse(v182$rpd.apr >= 65.9, 1,0)
v182$hp.apr <- ifelse(v182$X2018A_CycleCredit == 0 & v182$rpd.apr >= 60,1,v182$hp.apr)

v182$hp.may <- ifelse(v182$rpd.may >= 77.8, 1,0)
v182$hp.may <- ifelse(v182$X2018A_CycleCredit == 0 & v182$rpd.may >= 74.1,1,v182$hp.may)

v182$hp.jun <- ifelse(v182$rpd.jun >= 90.2, 1,0)
v182$hp.jun <- ifelse(v182$X2018A_CycleCredit == 0 & v182$rpd.jun >= 89,1,v182$hp.jun)

v182$hp.jul <- ifelse(v182$rpd.jul >= 100, 1,0)
v182$hp.jul <- ifelse(v182$X2018A_CycleCredit == 0 & v182$rpd.jul >= 100,1,v182$hp.jul)

#For 2017
v172$hp.aug <- ifelse(v172$rpd.aug >= 13.7 & !is.infinite(v172$rpd.aug) & v172$X2017A_CycleCredit > 0, 1,0)
v172$hp.sep <- ifelse(v172$rpd.sep >= 31.2 & !is.infinite(v172$rpd.sep) & v172$X2017A_CycleCredit > 0, 1,0)

v172$hp.oct <- ifelse(v172$rpd.oct >= 38.7 & !is.infinite(v172$rpd.oct) & v172$X2017A_CycleCredit > 0, 1,0)

v172$hp.nov <- ifelse(v172$rpd.nov >= 52.3 & !is.infinite(v172$rpd.nov) & v172$X2017A_CycleCredit > 0, 1, 0)

v172$hp.dec <- ifelse(v172$rpd.dec >= 64 & !is.infinite(v172$rpd.dec) & v172$X2017A_CycleCredit > 0, 1, 0)

v172$hp.jan <- ifelse(v172$rpd.jan >= 42.1, 1,0)
v172$hp.jan <- ifelse(v172$X2017A_CycleCredit == 0 & v172$rpd.jan >= 19.6,1,v172$hp.jan)

v172$hp.feb <- ifelse(v172$rpd.feb >= 49.4, 1,0)
v172$hp.feb <- ifelse(v172$X2017A_CycleCredit == 0 & v172$rpd.feb >= 38.3,1,v172$hp.feb)

v172$hp.mar <- ifelse(v172$rpd.mar >= 58.8, 1,0)
v172$hp.mar <- ifelse(v172$X2017A_CycleCredit == 0 & v172$rpd.mar >= 50,1,v172$hp.mar)

v172$hp.apr <- ifelse(v172$rpd.apr >= 65.9, 1,0)
v172$hp.apr <- ifelse(v172$X2017A_CycleCredit == 0 & v172$rpd.apr >= 60,1,v172$hp.apr)

v172$hp.may <- ifelse(v172$rpd.may >= 77.8, 1,0)
v172$hp.may <- ifelse(v172$X2017A_CycleCredit == 0 & v172$rpd.may >= 74.1,1,v172$hp.may)

v172$hp.jun <- ifelse(v172$rpd.jun >= 90.2, 1,0)
v172$hp.jun <- ifelse(v172$X2017A_CycleCredit == 0 & v172$rpd.jun >= 89,1,v172$hp.jun)

v172$hp.jul <- ifelse(v172$rpd.jul >= 100, 1,0)
v172$hp.jul <- ifelse(v172$X2017A_CycleCredit == 0 & v172$rpd.jul >= 100,1,v172$hp.jul)

#For 2016
v162$hp.aug <- ifelse(v162$rpd.aug >= 13.7 & !is.infinite(v162$rpd.aug) & v162$X2016A_CycleCredit > 0, 1,0)
v162$hp.sep <- ifelse(v162$rpd.sep >= 31.2 & !is.infinite(v162$rpd.sep) & v162$X2016A_CycleCredit > 0, 1,0)

v162$hp.oct <- ifelse(v162$rpd.oct >= 38.7 & !is.infinite(v162$rpd.oct) & v162$X2016A_CycleCredit > 0, 1,0)

v162$hp.nov <- ifelse(v162$rpd.nov >= 52.3 & !is.infinite(v162$rpd.nov) & v162$X2016A_CycleCredit > 0, 1, 0)

v162$hp.dec <- ifelse(v162$rpd.dec >= 64 & !is.infinite(v162$rpd.dec) & v162$X2016A_CycleCredit > 0, 1, 0)

v162$hp.jan <- ifelse(v162$rpd.jan >= 42.1, 1,0)
v162$hp.jan <- ifelse(v162$X2016A_CycleCredit == 0 & v162$rpd.jan >= 19.6,1,v162$hp.jan)

v162$hp.feb <- ifelse(v162$rpd.feb >= 49.4, 1,0)
v162$hp.feb <- ifelse(v162$X2016A_CycleCredit == 0 & v162$rpd.feb >= 38.3,1,v162$hp.feb)

v162$hp.mar <- ifelse(v162$rpd.mar >= 58.8, 1,0)
v162$hp.mar <- ifelse(v162$X2016A_CycleCredit == 0 & v162$rpd.mar >= 50,1,v162$hp.mar)

v162$hp.apr <- ifelse(v162$rpd.apr >= 65.9, 1,0)
v162$hp.apr <- ifelse(v162$X2016A_CycleCredit == 0 & v162$rpd.apr >= 60,1,v162$hp.apr)

v162$hp.may <- ifelse(v162$rpd.may >= 77.8, 1,0)
v162$hp.may <- ifelse(v162$X2016A_CycleCredit == 0 & v162$rpd.may >= 74.1,1,v162$hp.may)

v162$hp.jun <- ifelse(v162$rpd.jun >= 90.2, 1,0)
v162$hp.jun <- ifelse(v162$X2016A_CycleCredit == 0 & v162$rpd.jun >= 89,1,v162$hp.jun)

v162$hp.jul <- ifelse(v162$rpd.jul >= 100, 1,0)
v162$hp.jul <- ifelse(v162$X2016A_CycleCredit == 0 & v162$rpd.jul >= 100,1,v162$hp.jul)

#2015
v152$hp.aug <- ifelse(v152$rpd.aug >= 13.7 & !is.infinite(v152$rpd.aug) & v152$X2015A_CycleCredit > 0, 1,0)
v152$hp.sep <- ifelse(v152$rpd.sep >= 31.2 & !is.infinite(v152$rpd.sep) & v152$X2015A_CycleCredit > 0, 1,0)

v152$hp.oct <- ifelse(v152$rpd.oct >= 38.7 & !is.infinite(v152$rpd.oct) & v152$X2015A_CycleCredit > 0, 1,0)

v152$hp.nov <- ifelse(v152$rpd.nov >= 52.3 & !is.infinite(v152$rpd.nov) & v152$X2015A_CycleCredit > 0, 1, 0)

v152$hp.dec <- ifelse(v152$rpd.dec >= 64 & !is.infinite(v152$rpd.dec) & v152$X2015A_CycleCredit > 0, 1, 0)

v152$hp.jan <- ifelse(v152$rpd.jan >= 42.1, 1,0)
v152$hp.jan <- ifelse(v152$X2015A_CycleCredit == 0 & v152$rpd.jan >= 19.6,1,v152$hp.jan)

v152$hp.feb <- ifelse(v152$rpd.feb >= 49.4, 1,0)
v152$hp.feb <- ifelse(v152$X2015A_CycleCredit == 0 & v152$rpd.feb >= 38.3,1,v152$hp.feb)

v152$hp.mar <- ifelse(v152$rpd.mar >= 58.8, 1,0)
v152$hp.mar <- ifelse(v152$X2015A_CycleCredit == 0 & v152$rpd.mar >= 50,1,v152$hp.mar)

v152$hp.apr <- ifelse(v152$rpd.apr >= 65.9, 1,0)
v152$hp.apr <- ifelse(v152$X2015A_CycleCredit == 0 & v152$rpd.apr >= 60,1,v152$hp.apr)

v152$hp.may <- ifelse(v152$rpd.may >= 77.8, 1,0)
v152$hp.may <- ifelse(v152$X2015A_CycleCredit == 0 & v152$rpd.may >= 74.1,1,v152$hp.may)

v152$hp.jun <- ifelse(v152$rpd.jun >= 90.2, 1,0)
v152$hp.jun <- ifelse(v152$X2015A_CycleCredit == 0 & v152$rpd.jun >= 89,1,v152$hp.jun)

v152$hp.jul <- ifelse(v152$rpd.jul >= 100, 1,0)
v152$hp.jul <- ifelse(v152$X2015A_CycleCredit == 0 & v152$rpd.jul >= 100,1,v152$hp.jul)

#For 2014
v142$hp.aug <- ifelse(v142$rpd.aug >= 13.7 & !is.infinite(v142$rpd.aug) & v142$X2014A_CycleCredit > 0, 1,0)
v142$hp.sep <- ifelse(v142$rpd.sep >= 31.2 & !is.infinite(v142$rpd.sep) & v142$X2014A_CycleCredit > 0, 1,0)

v142$hp.oct <- ifelse(v142$rpd.oct >= 38.7 & !is.infinite(v142$rpd.oct) & v142$X2014A_CycleCredit > 0, 1,0)

v142$hp.nov <- ifelse(v142$rpd.nov >= 52.3 & !is.infinite(v142$rpd.nov) & v142$X2014A_CycleCredit > 0, 1, 0)

v142$hp.dec <- ifelse(v142$rpd.dec >= 64 & !is.infinite(v142$rpd.dec) & v142$X2014A_CycleCredit > 0, 1, 0)

v142$hp.jan <- ifelse(v142$rpd.jan >= 42.1, 1,0)
v142$hp.jan <- ifelse(v142$X2014A_CycleCredit == 0 & v142$rpd.jan >= 19.6,1,v142$hp.jan)

v142$hp.feb <- ifelse(v142$rpd.feb >= 49.4, 1,0)
v142$hp.feb <- ifelse(v142$X2014A_CycleCredit == 0 & v142$rpd.feb >= 38.3,1,v142$hp.feb)

v142$hp.mar <- ifelse(v142$rpd.mar >= 58.8, 1,0)
v142$hp.mar <- ifelse(v142$X2014A_CycleCredit == 0 & v142$rpd.mar >= 50,1,v142$hp.mar)

v142$hp.apr <- ifelse(v142$rpd.apr >= 65.9, 1,0)
v142$hp.apr <- ifelse(v142$X2014A_CycleCredit == 0 & v142$rpd.apr >= 60,1,v142$hp.apr)

v142$hp.may <- ifelse(v142$rpd.may >= 77.8, 1,0)
v142$hp.may <- ifelse(v142$X2014A_CycleCredit == 0 & v142$rpd.may >= 74.1,1,v142$hp.may)

v142$hp.jun <- ifelse(v142$rpd.jun >= 90.2, 1,0)
v142$hp.jun <- ifelse(v142$X2014A_CycleCredit == 0 & v142$rpd.jun >= 89,1,v142$hp.jun)

v142$hp.jul <- ifelse(v142$rpd.jul >= 100, 1,0)
v142$hp.jul <- ifelse(v142$X2014A_CycleCredit == 0 & v142$rpd.jul >= 100,1,v142$hp.jul)

#-------------------------------------------------------------------------
#Now, let's determine %  on the health path
#First, let's calculate total marks for health path
v202$tot.hp <- v202$hp.aug + v202$hp.sep + v202$hp.oct + v202$hp.nov + v202$hp.dec + v202$hp.jan +
               v202$hp.feb + v202$hp.mar + v202$hp.apr + v202$hp.may + v202$hp.jun + v202$hp.jul

v192$tot.hp <- v192$hp.aug + v192$hp.sep + v192$hp.oct + v192$hp.nov + v192$hp.dec + v192$hp.jan +
              v192$hp.feb + v192$hp.mar + v192$hp.apr + v192$hp.may + v192$hp.jun + v192$hp.jul

v182$tot.hp <- v182$hp.aug + v182$hp.sep + v182$hp.oct + v182$hp.nov + v182$hp.dec + v182$hp.jan +
  v182$hp.feb + v182$hp.mar + v182$hp.apr + v182$hp.may + v182$hp.jun + v182$hp.jul

v172$tot.hp <- v172$hp.aug + v172$hp.sep + v172$hp.oct + v172$hp.nov + v172$hp.dec + v172$hp.jan +
  v172$hp.feb + v172$hp.mar + v172$hp.apr + v172$hp.may + v172$hp.jun + v172$hp.jul

v162$tot.hp <- v162$hp.aug + v162$hp.sep + v162$hp.oct + v162$hp.nov + v162$hp.dec + v162$hp.jan +
  v162$hp.feb + v162$hp.mar + v162$hp.apr + v162$hp.may + v162$hp.jun + v162$hp.jul

v152$tot.hp <- v152$hp.aug + v152$hp.sep + v152$hp.oct + v152$hp.nov + v152$hp.dec + v152$hp.jan +
  v152$hp.feb + v152$hp.mar + v152$hp.apr + v152$hp.may + v152$hp.jun + v152$hp.jul

v142$tot.hp <- v142$hp.aug + v142$hp.sep + v142$hp.oct + v142$hp.nov + v142$hp.dec + v142$hp.jan +
  v142$hp.feb + v142$hp.mar + v142$hp.apr + v142$hp.may + v142$hp.jun + v142$hp.jul

#check if this works
View(v142)

#Now, let's calculate percentage

v202$perc.on.hpf <- ifelse(v202$X2020A_CycleCredit > 0, round(100*v202$tot.hp/12, 0), 
                           round(100*v202$tot.hp/7,0))
v202$perc.on.hpf <- ifelse(v202$X2020A_CycleCredit > 0, round(100*v202$tot.hp/12, 0), 
                           round(100*v202$tot.hp/7,0))
v202$perc.on.hpf <- ifelse(v202$X2020A_CycleCredit > 0, round(100*v202$tot.hp/12, 0), 
                           round(100*v202$tot.hp/7,0))
v202$perc.on.hpf <- ifelse(v202$X2020A_CycleCredit > 0, round(100*v202$tot.hp/12, 0), 
                           round(100*v202$tot.hp/7,0))
v202$perc.on.hpf <- ifelse(v202$X2020A_CycleCredit > 0, round(100*v202$tot.hp/12, 0), 
                           round(100*v202$tot.hp/7,0))
v202$perc.on.hpf <- ifelse(v202$X2020A_CycleCredit > 0, round(100*v202$tot.hp/12, 0), 
                           round(100*v202$tot.hp/7,0))
v202$perc.on.hpf <- ifelse(v202$X2020A_CycleCredit > 0, round(100*v202$tot.hp/12, 0), 
                           round(100*v202$tot.hp/7,0))
#For 2019
v192$perc.on.hpf <- ifelse(v192$X2019A_CycleCredit > 0, round(100*v192$tot.hp/12, 0), 
                           round(100*v192$tot.hp/7,0))
v192$perc.on.hpf <- ifelse(v192$X2019A_CycleCredit > 0, round(100*v192$tot.hp/12, 0), 
                           round(100*v192$tot.hp/7,0))
v192$perc.on.hpf <- ifelse(v192$X2019A_CycleCredit > 0, round(100*v192$tot.hp/12, 0), 
                           round(100*v192$tot.hp/7,0))
v192$perc.on.hpf <- ifelse(v192$X2019A_CycleCredit > 0, round(100*v192$tot.hp/12, 0), 
                           round(100*v192$tot.hp/7,0))
v192$perc.on.hpf <- ifelse(v192$X2019A_CycleCredit > 0, round(100*v192$tot.hp/12, 0), 
                           round(100*v192$tot.hp/7,0))
v192$perc.on.hpf <- ifelse(v192$X2019A_CycleCredit > 0, round(100*v192$tot.hp/12, 0), 
                           round(100*v192$tot.hp/7,0))
v192$perc.on.hpf <- ifelse(v192$X2019A_CycleCredit > 0, round(100*v192$tot.hp/12, 0), 
                           round(100*v192$tot.hp/7,0))

#For 2018
v182$perc.on.hpf <- ifelse(v182$X2018A_CycleCredit > 0, round(100*v182$tot.hp/12, 0), 
                           round(100*v182$tot.hp/7,0))
v182$perc.on.hpf <- ifelse(v182$X2018A_CycleCredit > 0, round(100*v182$tot.hp/12, 0), 
                           round(100*v182$tot.hp/7,0))
v182$perc.on.hpf <- ifelse(v182$X2018A_CycleCredit > 0, round(100*v182$tot.hp/12, 0), 
                           round(100*v182$tot.hp/7,0))
v182$perc.on.hpf <- ifelse(v182$X2018A_CycleCredit > 0, round(100*v182$tot.hp/12, 0), 
                           round(100*v182$tot.hp/7,0))
v182$perc.on.hpf <- ifelse(v182$X2018A_CycleCredit > 0, round(100*v182$tot.hp/12, 0), 
                           round(100*v182$tot.hp/7,0))
v182$perc.on.hpf <- ifelse(v182$X2018A_CycleCredit > 0, round(100*v182$tot.hp/12, 0), 
                           round(100*v182$tot.hp/7,0))
v182$perc.on.hpf <- ifelse(v182$X2018A_CycleCredit > 0, round(100*v182$tot.hp/12, 0), 
                           round(100*v182$tot.hp/7,0))
#2017
v172$perc.on.hpf <- ifelse(v172$X2017A_CycleCredit > 0, round(100*v172$tot.hp/12, 0), 
                           round(100*v172$tot.hp/7,0))
v172$perc.on.hpf <- ifelse(v172$X2017A_CycleCredit > 0, round(100*v172$tot.hp/12, 0), 
                           round(100*v172$tot.hp/7,0))
v172$perc.on.hpf <- ifelse(v172$X2017A_CycleCredit > 0, round(100*v172$tot.hp/12, 0), 
                           round(100*v172$tot.hp/7,0))
v172$perc.on.hpf <- ifelse(v172$X2017A_CycleCredit > 0, round(100*v172$tot.hp/12, 0), 
                           round(100*v172$tot.hp/7,0))
v172$perc.on.hpf <- ifelse(v172$X2017A_CycleCredit > 0, round(100*v172$tot.hp/12, 0), 
                           round(100*v172$tot.hp/7,0))
v172$perc.on.hpf <- ifelse(v172$X2017A_CycleCredit > 0, round(100*v172$tot.hp/12, 0), 
                           round(100*v172$tot.hp/7,0))
v172$perc.on.hpf <- ifelse(v172$X2017A_CycleCredit > 0, round(100*v172$tot.hp/12, 0), 
                           round(100*v172$tot.hp/7,0))

#2016
v162$perc.on.hpf <- ifelse(v162$X2016A_CycleCredit > 0, round(100*v162$tot.hp/12, 0), 
                           round(100*v162$tot.hp/7,0))
v162$perc.on.hpf <- ifelse(v162$X2016A_CycleCredit > 0, round(100*v162$tot.hp/12, 0), 
                           round(100*v162$tot.hp/7,0))
v162$perc.on.hpf <- ifelse(v162$X2016A_CycleCredit > 0, round(100*v162$tot.hp/12, 0), 
                           round(100*v162$tot.hp/7,0))
v162$perc.on.hpf <- ifelse(v162$X2016A_CycleCredit > 0, round(100*v162$tot.hp/12, 0), 
                           round(100*v162$tot.hp/7,0))
v162$perc.on.hpf <- ifelse(v162$X2016A_CycleCredit > 0, round(100*v162$tot.hp/12, 0), 
                           round(100*v162$tot.hp/7,0))
v162$perc.on.hpf <- ifelse(v162$X2016A_CycleCredit > 0, round(100*v162$tot.hp/12, 0), 
                           round(100*v162$tot.hp/7,0))
v162$perc.on.hpf <- ifelse(v162$X2016A_CycleCredit > 0, round(100*v162$tot.hp/12, 0), 
                           round(100*v162$tot.hp/7,0))
#2015
v152$perc.on.hpf <- ifelse(v152$X2015A_CycleCredit > 0, round(100*v152$tot.hp/12, 0), 
                           round(100*v152$tot.hp/7,0))
v152$perc.on.hpf <- ifelse(v152$X2015A_CycleCredit > 0, round(100*v152$tot.hp/12, 0), 
                           round(100*v152$tot.hp/7,0))
v152$perc.on.hpf <- ifelse(v152$X2015A_CycleCredit > 0, round(100*v152$tot.hp/12, 0), 
                           round(100*v152$tot.hp/7,0))
v152$perc.on.hpf <- ifelse(v152$X2015A_CycleCredit > 0, round(100*v152$tot.hp/12, 0), 
                           round(100*v152$tot.hp/7,0))
v152$perc.on.hpf <- ifelse(v152$X2015A_CycleCredit > 0, round(100*v152$tot.hp/12, 0), 
                           round(100*v152$tot.hp/7,0))
v152$perc.on.hpf <- ifelse(v152$X2015A_CycleCredit > 0, round(100*v152$tot.hp/12, 0), 
                           round(100*v152$tot.hp/7,0))
v152$perc.on.hpf <- ifelse(v152$X2015A_CycleCredit > 0, round(100*v152$tot.hp/12, 0), 
                           round(100*v152$tot.hp/7,0))

#2014
v142$perc.on.hpf <- ifelse(v142$X2014A_CycleCredit > 0, round(100*v142$tot.hp/12, 0), 
                           round(100*v142$tot.hp/7,0))
v142$perc.on.hpf <- ifelse(v142$X2014A_CycleCredit > 0, round(100*v142$tot.hp/12, 0), 
                           round(100*v142$tot.hp/7,0))
v142$perc.on.hpf <- ifelse(v142$X2014A_CycleCredit > 0, round(100*v142$tot.hp/12, 0), 
                           round(100*v142$tot.hp/7,0))
v142$perc.on.hpf <- ifelse(v142$X2014A_CycleCredit > 0, round(100*v142$tot.hp/12, 0), 
                           round(100*v142$tot.hp/7,0))
v142$perc.on.hpf <- ifelse(v142$X2014A_CycleCredit > 0, round(100*v142$tot.hp/12, 0), 
                           round(100*v142$tot.hp/7,0))
v142$perc.on.hpf <- ifelse(v142$X2014A_CycleCredit > 0, round(100*v142$tot.hp/12, 0), 
                           round(100*v142$tot.hp/7,0))
v142$perc.on.hpf <- ifelse(v142$X2014A_CycleCredit > 0, round(100*v142$tot.hp/12, 0), 
                           round(100*v142$tot.hp/7,0))
#check
View(v142)
#-----------------------------------------------------------------------------
dim(v202)
names(v202)


#Now, let's transfer key variables to the season clients
d20$rpd.jul <- v202$rpd.jul[match(d20$GlobalClientID, v202$GlobalClientID)]
d20$perc.on.hpf <- v202$perc.on.hpf[match(d20$GlobalClientID, v202$GlobalClientID)]


#check
head(d20$rpd.jul)
length(unique(d20$GlobalClientID[is.na(d20$rpd.jul)]))
length(unique(d20$GlobalClientID[is.na(d20$perc.on.hpf)]))
length(unique(v202$GlobalClientID[is.na(v202$rpd.jul)]))

#Do the same for other years
d19$rpd.jul <- v192$rpd.jul[match(d19$GlobalClientID, v192$GlobalClientID)] #Vedaste: To check back
d19$perc.on.hpf <- v192$perc.on.hpf[match(d19$GlobalClientID, v192$GlobalClientID)]

d18$rpd.jul <- v182$rpd.jul[match(d18$GlobalClientID, v182$GlobalClientID)]
d18$perc.on.hpf <- v182$perc.on.hpf[match(d18$GlobalClientID, v182$GlobalClientID)]

d17$rpd.jul <- v172$rpd.jul[match(d17$GlobalClientID, v172$GlobalClientID)]
d17$perc.on.hpf <- v172$perc.on.hpf[match(d17$GlobalClientID, v172$GlobalClientID)]

d16$rpd.jul <- v162$rpd.jul[match(d16$GlobalClientID, v162$GlobalClientID)]
d16$perc.on.hpf <- v162$perc.on.hpf[match(d16$GlobalClientID, v162$GlobalClientID)]

d15$rpd.jul <- v152$rpd.jul[match(d15$GlobalClientID, v152$GlobalClientID)]
d15$perc.on.hpf <- v152$perc.on.hpf[match(d15$GlobalClientID, v152$GlobalClientID)]

d14$rpd.jul <- v142$rpd.jul[match(d14$GlobalClientID, v142$GlobalClientID)]
d14$perc.on.hpf <- v142$perc.on.hpf[match(d14$GlobalClientID, v142$GlobalClientID)]


#Now, we have everything we need on the season clients
#For 2013 and 2012, let's consider X-repaid as rpd.jul
#Then, turn perc.on.hpf to 50% as we are sorting out the formulation of the season client
#Vedaste to change this back. 

d13a$rpd.jul <- d13a$X..Repaid
d13b$rpd.jul <- d13b$X..Repaid
d12a$rpd.jul <- d12a$X..Repaid
d12b$rpd.jul <- d12b$X..Repaid

#Adding X repaid
d13a$perc.on.hpf <- 50
d13b$perc.on.hpf <- 50
d12a$perc.on.hpf <- 50
d12b$perc.on.hpf <- 50

#Average credit calculation
summary(d20$TotalCredit)

d20$credit.size <- ifelse(d20$TotalCredit >= mean(d20$TotalCredit) - 3000 & 
                            d20$TotalCredit < mean(d20$TotalCredit) + 3000, "Medium", 0)
d20$credit.size <- ifelse(d20$TotalCredit < mean(d20$TotalCredit) - 3000, "Low", d20$credit.size)
d20$credit.size <- ifelse(d20$TotalCredit > mean(d20$TotalCredit) + 3000, "High", d20$credit.size)

table(d20$credit.size, useNA = "ifany")

#For 2019
d19$credit.size <- ifelse(d19$TotalCredit >= mean(d19$TotalCredit) - 3000 & 
                            d19$TotalCredit < mean(d19$TotalCredit) + 3000, "Medium", 0)
d19$credit.size <- ifelse(d19$TotalCredit < mean(d19$TotalCredit) - 3000, "Low", d19$credit.size)
d19$credit.size <- ifelse(d19$TotalCredit > mean(d19$TotalCredit) + 3000, "High", d19$credit.size)

table(d19$credit.size, useNA = "ifany")


#For 2018
d18$credit.size <- ifelse(d18$TotalCredit >= mean(d18$TotalCredit) - 3000 & 
                            d18$TotalCredit < mean(d18$TotalCredit) + 3000, "Medium", 0)
d18$credit.size <- ifelse(d18$TotalCredit < mean(d18$TotalCredit) - 3000, "Low", d18$credit.size)
d18$credit.size <- ifelse(d18$TotalCredit > mean(d18$TotalCredit) + 3000, "High", d18$credit.size)

table(d18$credit.size, useNA = "ifany")

#For 2017
d17$credit.size <- ifelse(d17$TotalCredit >= mean(d17$TotalCredit) - 3000 & 
                            d17$TotalCredit < mean(d17$TotalCredit) + 3000, "Medium", 0)
d17$credit.size <- ifelse(d17$TotalCredit < mean(d17$TotalCredit) - 3000, "Low", d17$credit.size)
d17$credit.size <- ifelse(d17$TotalCredit > mean(d17$TotalCredit) + 3000, "High", d17$credit.size)

table(d17$credit.size, useNA = "ifany")

#2016
d16$credit.size <- ifelse(d16$TotalCredit >= mean(d16$TotalCredit) - 3000 & 
                            d16$TotalCredit < mean(d16$TotalCredit) + 3000, "Medium", 0)
d16$credit.size <- ifelse(d16$TotalCredit < mean(d16$TotalCredit) - 3000, "Low", d16$credit.size)
d16$credit.size <- ifelse(d16$TotalCredit > mean(d16$TotalCredit) + 3000, "High", d16$credit.size)

table(d16$credit.size, useNA = "ifany")

#2015 ----
d15$credit.size <- ifelse(d15$TotalCredit >= mean(d15$TotalCredit) - 3000 & 
                            d15$TotalCredit < mean(d15$TotalCredit) + 3000, "Medium", 0)
d15$credit.size <- ifelse(d15$TotalCredit < mean(d15$TotalCredit) - 3000, "Low", d15$credit.size)
d15$credit.size <- ifelse(d15$TotalCredit > mean(d15$TotalCredit) + 3000, "High", d15$credit.size)

table(d15$credit.size, useNA = "ifany")

#2014 -----
d14$credit.size <- ifelse(d14$TotalCredit >= mean(d14$TotalCredit) - 3000 & 
                            d14$TotalCredit < mean(d14$TotalCredit) + 3000, "Medium", 0)
d14$credit.size <- ifelse(d14$TotalCredit < mean(d14$TotalCredit) - 3000, "Low", d14$credit.size)
d14$credit.size <- ifelse(d14$TotalCredit > mean(d14$TotalCredit) + 3000, "High", d14$credit.size)

table(d14$credit.size, useNA = "ifany")

#2013a  ----------
d13a$credit.size <- ifelse(d13a$TotalCredit >= mean(d13a$TotalCredit) - 3000 & 
                             d13a$TotalCredit < mean(d13a$TotalCredit) + 3000, "Medium", 0)
d13a$credit.size <- ifelse(d13a$TotalCredit < mean(d13a$TotalCredit) - 3000, "Low", d13a$credit.size)
d13a$credit.size <- ifelse(d13a$TotalCredit > mean(d13a$TotalCredit) + 3000, "High", d13a$credit.size)

table(d13a$credit.size, useNA = "ifany")

#2013b
d13b$credit.size <- ifelse(d13b$TotalCredit >= mean(d13b$TotalCredit) - 3000 & 
                             d13b$TotalCredit < mean(d13b$TotalCredit) + 3000, "Medium", 0)
d13b$credit.size <- ifelse(d13b$TotalCredit < mean(d13b$TotalCredit) - 3000, "Low", d13b$credit.size)
d13b$credit.size <- ifelse(d13b$TotalCredit > mean(d13b$TotalCredit) + 3000, "High", d13b$credit.size)

table(d13b$credit.size, useNA = "ifany")

#2012b -----------------
d12b$credit.size <- ifelse(d12b$TotalCredit >= mean(d12b$TotalCredit) - 3000 & 
                             d12b$TotalCredit < mean(d12b$TotalCredit) + 3000, "Medium", 0)
d12b$credit.size <- ifelse(d12b$TotalCredit < mean(d12b$TotalCredit) - 3000, "Low", d12b$credit.size)
d12b$credit.size <- ifelse(d12b$TotalCredit > mean(d12b$TotalCredit) + 3000, "High", d12b$credit.size)

table(d12b$credit.size, useNA = "ifany")

#2012a
d12a$credit.size <- ifelse(d12a$TotalCredit >= mean(d12a$TotalCredit) - 3000 & 
                             d12a$TotalCredit < mean(d12a$TotalCredit) + 3000, "Medium", 0)
d12a$credit.size <- ifelse(d12a$TotalCredit < mean(d12a$TotalCredit) - 3000, "Low", d12a$credit.size)
d12a$credit.size <- ifelse(d12a$TotalCredit > mean(d12a$TotalCredit) + 3000, "High", d12a$credit.size)

table(d12a$credit.size, useNA = "ifany")
length(d12a$GlobalClientID[d12a$TotalCredit > mean(d12a$TotalCredit) + 3000])
#alright
########################################################################

#For 2013 and 2012, we are going to add A to B
d13a$match.b <- match(d13a$AccountNumber, d13b$AccountNumber, nomatch = 0)
d12a$match.b <- match(d12a$AccountNumber, d12b$AccountNumber, nomatch = 0)
#check
length(unique(d13a$AccountNumber[d13a$match.b == 0]))
length(unique(d12a$AccountNumber[d12a$match.b == 0]))

#Extract only these farmers
d13a1 <- subset(d13a, match.b == 0)
d12a1 <- subset(d12a, match.b == 0)

names(d13a1)

#Specifying which seasons participated
c <- c("SeasonName", "RegionName", "DistrictName", "SectorName", "FieldOfficer",
       "FieldManager", "GroupName", "FirstName", "LastName", "OAFID", "NationalID",
       "AccountNumber","ClientPhone","GlobalClientID", "NewMember", "TotalEnrolledSeasons", 
       "Facilitator", "TotalCredit", "rpd.jul", "perc.on.hpf", "credit.size")

#Let's do the same for vertical repayment
c1 <- c("GlobalClientID", "AccountNumber", "Amount", "Type", "RepaymentDate")

d201 <- d20[c]
d191 <- d19[c]
d181 <- d18[c]
d171 <- d17[c]
d161 <- d16[c]
d151 <- d15[c]
d141 <- d14[c]
d13a2 <- d13a1[c]
d13b1 <- d13b[c]
d12a2 <- d12a1[c]
d12b1 <- d12b[c]

#check
dim(d201)
dim(d191)
dim(d181)
dim(d171)
dim(d161)
dim(d151)
dim(d141)
dim(d13a2)
dim(d13b1)
dim(d12a2)
dim(d12b1)

#First, let's merge 2013 and 2012
d13b2 <- rbind(d13b1, d13a2)
d12b2 <- rbind(d12b1, d12a2)

#To check if it works
dim(d13b2)
dim(d12b2)
dim(d201)
#######################################################################
#Now, let's rbind all season clients
all_data <- rbind(d201, d191, d181, d171, d161, d151, d141, d13b2, d12b2)

#save this as Rdata
save(all_data, file = paste(wd,"all_data_for_the_model.Rdata", sep ="/"))
write.table(all_data, file = paste(od, "all_data_for_the_model.csv", sep = "/"),
            row.names = FALSE, col.names = TRUE, sep = ",")
#loading data
load(file = paste(wd,"all_data_for_the_model.Rdata", sep ="/"))
################################################################################
#summarizing our data on farmerlevel
dim(all_data)
head(all_data)

#Let's turn everything into scores
table(all_data$Facilitator, useNA = "ifany")
all_data$gl.score <- ifelse(all_data$Facilitator == "True", 0.25, 0)
#check 
table(all_data$gl.score, useNA = "ifany")

#Score for Performance against the health path 
all_data$hpf.score <- ifelse(all_data$perc.on.hpf > 75, 0.5, 
                             ifelse(all_data$perc.on.hpf >= 50 & all_data$perc.on.hpf <= 75, 0.25, 0))
#check
table(all_data$hpf.score, useNA = "ifany")
table(all_data$perc.on.hpf, useNA = "ifany")
length(all_data$GlobalClientID[all_data$perc.on.hpf < 50 & !is.na(all_data$perc.on.hpf)])

#Generating scores for credit size
table(all_data$credit.size, useNA = "ifany")

all_data$credit.size.score <- ifelse(all_data$credit.size == "High", 0.25, 
                               ifelse(all_data$credit.size == "Medium", 0.125, 0))
#check
table(all_data$credit.size.score, useNA = "ifany")

#For defaulters
all_data$defaulting.score <- ifelse(all_data$rpd.jul < 100, -1, 0)

#check
table(all_data$defaulting.score, useNA = "ifany")

#Now, let's put this information on clients level
#To fix district issues later
all_data1 <- all_data %>%
             group_by(LastName, FirstName, GlobalClientID) %>%
             summarise(n.season.score = max(TotalEnrolledSeasons, na.rm = T),
                       gl.score = sum(gl.score, na.rm = T),
                       healthy.path.score = sum(hpf.score, na.rm = T),
                       credit.size.score = sum(credit.size.score, na.rm = T),
                       defaulting.score = sum(defaulting.score, na.rm = T),
                       maximum.credit = round(max(TotalCredit)*1.1, digits = -2))


head(all_data1)
View(all_data1)

#creating  total score column
all_data1$total.score <- all_data1$n.season.score + 
                         all_data1$gl.score + 
                         all_data1$healthy.path.score + 
                         all_data1$credit.size.score + 
                         all_data1$defaulting.score
#Let's export the final output
save(all_data1, file = paste(wd,"credit_scoring_model_6.9.2020.Rdata", sep ="/"))
write.table(all_data1, file = paste(od, "credit_scoring_model_6.9.2020.csv", sep = "/"),
            row.names = FALSE, col.names = TRUE, sep = ",")



