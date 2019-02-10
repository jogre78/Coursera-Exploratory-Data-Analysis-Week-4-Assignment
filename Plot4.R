## This first line will likely take a few seconds.
## Read Data from Assignment Week 4
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)

## get all records involving coal from SCC data
SCC_Coal <- SCC[grep("[Cc]oal",SCC$EI.Sector),]
## Subset all records involving coal in NEI data
NEI_Coal <- subset(NEI,NEI$SCC %in% SCC_Coal$SCC)

## Summarise Emissions by Year For Coal
Yearly_Emissions_Coal <- NEI_Coal %>% group_by(year) %>% summarize(Sum_Emissions = sum(Emissions, na.rm = TRUE))
Yearly_Emissions_Coal


## create the plot of Yearly Emissions
png(filename = "plot4.png")
plot(Yearly_Emissions_Coal$year, Yearly_Emissions_Coal$Sum_Emissions, 
     type = "o",
     xlab = "Year",
     ylab = "Total Emissions (tons)",
     main = "Total Annual Coal Emissions of PM2.5 in US")
dev.off()

## Difference of Coal Emissions between 1999 and 2008
CoalEmissions1999 <- Yearly_Emissions_Coal[Yearly_Emissions_Coal$year == 1999, 2]
CoalEmissions2008 <- Yearly_Emissions_Coal[Yearly_Emissions_Coal$year == 2008, 2]

Diff_CoalEmissions2008_1999 <- CoalEmissions2008 - CoalEmissions1999
