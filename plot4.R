
# change your directory here!
dir = "exdata_data_NEI_data"

setwd(dir)

# read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# select coal related sources
SCC_coalrelated <- SCC[grepl("coal",tolower(SCC$EI.Sector))&grepl("combustion",tolower(SCC$SCC.Level.One)),]

SCC_coalrelated <- SCC_coalrelated[,c("SCC", "EI.Sector")]


# merge "NEI" and "scc.coal" by  "SCC"
NEI_coalrelated <- merge(NEI,SCC_coalrelated,by="SCC")

# remove those are not coal related
NEI_coalrelated = NEI_coalrelated[!is.na(NEI_coalrelated$EI.Sector),]

# get total emissions by year
NEI_total <- tapply(NEI_coalrelated$Emissions,NEI_coalrelated$year,sum)

png("plot4.png",width=480,height=480)

plot(NEI_total, type="b", 
     xaxt="n", yaxt="n", #remove x,y axis
     xlab="Year",ylab="total emissions from PM2.5 (k tons)",
     ylim = c(300000,600000),
     main="Q4: Total Emission by year (coal combustion-related)",
     lwd=2,
     pch=16,
     col=3)
axis(1,at=1:length(names(NEI_total)),labels=names(NEI_total))
axis(2,at=seq(300000,600000,by=100000),labels=seq(300,600,by =100))

dev.off()