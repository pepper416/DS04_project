
# change your directory here!
dir = "exdata_data_NEI_data"

setwd(dir)

# read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



# get total emissions by year

NEI_total <- tapply(NEI$Emissions,NEI$year,sum)
# 
png("plot1.png",width=480,height=480)

plot(NEI_total, type="b", 
     xaxt="n", yaxt="n", #remove x,y axis
     xlab="Year",ylab="total emissions from PM2.5 (million tons)",
     main="Q1: Total Emission by year",
     lwd=2,
     pch=16,
     col=3)
axis(1,at=1:length(names(NEI_total)),labels=names(NEI_total))
axis(2,at=seq(3000000,8000000,by=1000000),labels=seq(3,8,by =1))

dev.off()