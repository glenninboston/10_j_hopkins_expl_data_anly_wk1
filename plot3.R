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





##### GRAPH 3: Submetering by Date lineplot
# confirm active device
dev.cur()

with(P2_household_power_consumption, {
  # plot line chart for sub_metering_1
  plot(date_time, Sub_metering_1, type = "l", col = "black", 
       xlab = "", ylab = "Engery sub metering")
  # add sub_metering_2
  lines(date_time, Sub_metering_2, type = "l", col = "red")
  # add sub_metering_3
  lines(date_time, Sub_metering_3, type = "l", col = "blue")
})


# add legend
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1)

# copy to png
dev.copy(png, file = "plot3.png") 
dev.off()  





# Clean-Up Environment
rm(list = ls(pattern = "P2_"))