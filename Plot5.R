## This first line will likely take a few seconds.
## Read Data from Assignment Week 4
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)

## get all records involving vehicle from SCC data
SCC_Veh <- SCC[grep("[Vv]eh",SCC$Short.Name),]
## Subset all records involving vehicle in Baltimore in NEI data
NEI_Veh_Baltimore <- subset(NEI,NEI$SCC %in% SCC_Veh$SCC & NEI$fips == "24510")

## Summarise Emissions by Year For Vehicle in Baltimore
Yearly_Emissions_Veh_Baltimore <- NEI_Veh_Baltimore %>% group_by(year) %>% summarize(Sum_Emissions = sum(Emissions, na.rm = TRUE))
Yearly_Emissions_Veh_Baltimore


## create the plot of Yearly Emissions
png(filename = "plot5.png")
plot(Yearly_Emissions_Veh_Baltimore$year, Yearly_Emissions_Veh_Baltimore$Sum_Emissions,
     type = "o",
     xlab = "year",
     ylab = "Total Emissions (tons)",
     main = "Total Annual Emissions of PM2.5 for Vehicles in Baltimore")
dev.off()

## Difference of Vehicle Emissions between 1999 and 2008 in Baltimore
VehEmissions1999_Baltimore <- Yearly_Emissions_Veh_Baltimore[Yearly_Emissions_Veh_Baltimore$year == 1999, 2]
VehEmissions2008_Baltimore <- Yearly_Emissions_Veh_Baltimore[Yearly_Emissions_Veh_Baltimore$year == 2008, 2]

Diff_VehEmissions2008_1999_Baltimore <- VehEmissions2008_Baltimore - VehEmissions1999_Baltimore
