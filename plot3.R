
# change your directory here!
dir = "exdata_data_NEI_data"

setwd(dir)

# read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# subset the data of Baltimore City
NEI_Bal = subset(NEI, fips == "24510")

# get total emissions by year by type
NEI_total <- with(NEI_Bal,aggregate(Emissions,by=list(year,type),sum))
names(NEI_total) <- c("year","type","value")


library(ggplot2)

png("plot3.png",width=600,height=480)

qplot(year,value,data=NEI_total,
      color=type,
      geom=c("point","line"),
      xlab="Year",ylab="total emissions from PM2.5 (tons)",
      main="Q3: Total Emission by year and type (Baltimore)")

dev.off()