library(tidyverse)

# read in semi-colon delimited file
R_household_power_consumption <- readr::read_delim("household_power_consumption.txt", delim = ";", col_names = TRUE,
                                                   na = c("?"))

P1_household_power_consumption <- R_household_power_consumption %>%
  # converte date and time objects to date time
  mutate(date = lubridate::dmy(Date),
         time = lubridate::hms(Time),
         date_time = lubridate::ymd_hms(date+time))

P2_household_power_consumption <- P1_household_power_consumption %>%
  # filter to just dates of interest "2007-02-01" and "2007-02-02"
  filter(between(date, lubridate::as_date("2007-02-01"), lubridate::as_date("2007-02-02"))) %>%
  mutate(week_day = lubridate::wday(date, label = TRUE))




# Clean-Up Environment
rm(list = ls(pattern = "R_"))
rm(list = ls(pattern = "P1_"))





##### GRAPH 1: Global Active Power Histogram (Frequency)
# confirm active device
dev.cur()

# plot histogram
hist(P2_household_power_consumption$Global_active_power, 
     col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency")     

# copy to png
dev.copy(png, file = "plot1.png")  # note 480x480 is the default, so does not need to be specified by width = 480, height = 480
dev.off()

## Alt
# png(file = "plot1alt.png") ## Open PDF device, give file name
# 
# hist(P2_household_power_consumption$Global_active_power, 
#      col = "red", main = "Global Active Power", 
#      xlab = "Global Active Power (kilowatts)",
#      ylab = "Frequency")    
# 
# dev.off()





# Clean-Up Environment
rm(list = ls(pattern = "P2_"))