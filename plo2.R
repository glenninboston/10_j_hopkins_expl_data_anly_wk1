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





##### GRAPH 2: Global Active Power by Date lineplot
# confirm active device
dev.cur()

# plot line-graph
with(P2_household_power_consumption, plot(date_time, Global_active_power,
                                          type = "l",
                                          xlab = "",
                                          ylab = "Global Active Power (kilowatts)"))

# copy to png
dev.copy(png, file = "plot2.png") 
dev.off()  





# Clean-Up Environment
rm(list = ls(pattern = "P2_"))