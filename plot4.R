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





##### GRAPH 4: Selection of Graphs: (1) Global Active Power, (2) Voltage by day, (3) Engergy sub metering and (4) Global Reactive power
# confirm active device
dev.cur()
par()

# set-up four graphic plot
par(mfcol = c(2, 2), mar = c(4.1, 4.1, 2.1, 2.1)) # mar = c(5.1, 4.1, 4.1, 2.1))

## PLOT 1: Global Active Power by Date (lineplot)
with(P2_household_power_consumption, plot(date_time, Global_active_power,
                                          type = "l",
                                          xlab = "",
                                          ylab = "Global Active Power (kilowatts)"))

## PLOT 2: Sub-metering by Date (lineplot)
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
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, cex = 0.5)

## PLOT 3: Voltage by Date (lineplot)
with(P2_household_power_consumption, plot(date_time, Voltage,
                                          type = "l",
                                          xlab = "datetime"))


## PLOT 4: Global_reactive_power by Date (lineplot)
with(P2_household_power_consumption, plot(date_time, Global_reactive_power,
                                          type = "l",
                                          xlab = "datetime"))

# copy to png
dev.copy(png, file = "plot4.png") 
par(mfcol = c(1, 1))
dev.off()  





# Clean-Up Environment
rm(list = ls(pattern = "P2_"))