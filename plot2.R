
# change your directory here!
dir = "exdata_data_NEI_data"

setwd(dir)

# read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# subset the data of Baltimore City
NEI_Bal = subset(NEI, fips == "24510")

# get total emissions by year
NEI_total <- tapply(NEI_Bal$Emissions,NEI_Bal$year,sum)


png("plot2.png",width=480,height=480)

plot(NEI_total, type="b", 
     xaxt="n", yaxt="n", #remove x,y axis
     xlab="Year",ylab="total emissions from PM2.5 (k tons)",
     ylim = c(1000,4000),
     main="Q2: Total Emission by year (Baltimore)",
     lwd=2,
     pch=16,
     col=3)
axis(1,at=1:length(names(NEI_total)),labels=names(NEI_total))
axis(2,at=seq(1000,4000,by=1000),labels=seq(1,4,by =1))

dev.off()