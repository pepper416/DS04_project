
# change your directory here!
dir = "exdata_data_NEI_data"

setwd(dir)

# read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# subset the data of Baltimore City
NEI_Bal = subset(NEI, fips == "24510")


# subset motor vehicles sources data from "scc" data
# EI names containing "mobile" and "vehicle"
SCC_motor <- SCC[grepl("mobile.*vehicles", SCC$EI.Sector, ignore.case=TRUE), 'SCC']

SCC_motor_Bal <- subset(NEI_Bal, SCC %in% SCC_motor)

# get total emissions by year by type
NEI_total <- with(SCC_motor_Bal,aggregate(Emissions,by=list(year),sum))
names(NEI_total) <- c("year","sum")



library(ggplot2)

png("plot5.png",width=600,height=480)

qplot(year, sum, data=NEI_total, geom=c("point", "line", "text"), binwidth = 3, label=round((sum),2)) +
  ylab("total emissions from PM2.5 (tons)") +
  xlab("Year") +
  labs(title="Q5: Total Emission by year (Motor at Baltimore)")

dev.off()