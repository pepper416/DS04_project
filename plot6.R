
# change your directory here!
dir = "exdata_data_NEI_data"

setwd(dir)

# read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")





# subset motor vehicles sources data from "scc" data
# EI names containing "mobile" and "vehicle"
SCC_motor <- SCC[grepl("mobile.*vehicles", SCC$EI.Sector, ignore.case=TRUE), 'SCC']

# subset the data of Baltimore City
NEI_Bal= subset(NEI, fips == "24510")
SCC_motor_Bal <- subset(NEI_Bal, SCC %in% SCC_motor)
SCC_motor_Bal$city = "Baltimore City"
  
# subset the data of LA City
NEI_LA = subset(NEI, fips == "06037")
SCC_motor_LA <- subset(NEI_LA, SCC %in% SCC_motor)
SCC_motor_LA$city = "Los Angeles County"

# get total emissions by year by type
NEI_total <- with(rbind(SCC_motor_Bal, SCC_motor_LA) ,aggregate(Emissions,by=list(year, city),sum))
names(NEI_total) <- c("year", "city", "sum")



library(ggplot2)

png("plot6.png",width=600,height=480)

qplot(year,sum,data=NEI_total,
      color=city,
      geom=c("point","line"),
      xlab="Year",ylab="total emissions from PM2.5 (tons)",
      main="Q6: Total Emission compare LA and Baltimore")

dev.off()