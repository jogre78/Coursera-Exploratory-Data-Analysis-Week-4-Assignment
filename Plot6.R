## This first line will likely take a few seconds.
## Read Data from Assignment Week 4
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)

## get all records involving vehicle from SCC data
SCC_Veh <- SCC[grep("[Vv]eh",SCC$Short.Name),]
## Subset all records involving vehicle in Baltimore in NEI data
NEI_Veh_Bal_LA <- subset(NEI,NEI$SCC %in% SCC_Veh$SCC & (NEI$fips == "24510" | NEI$fips == "06037") )


## Summarise Emissions by Year For Vehicle in Baltimore & LA
Yearly_Emissions_Veh_Bal_LA <- NEI_Veh_Bal_LA %>% group_by(year,fips) %>% summarize(Sum_Emissions = sum(Emissions, na.rm = TRUE))
Yearly_Emissions_Veh_Bal_LA


## create the plot of Yearly Emissions for Vehicle in Baltimore & LA
png(filename = "plot6.png")
qplot(year, Sum_Emissions, data = Yearly_Emissions_Veh_Bal_LA, 
      color = fips, geom = "line") +
  ggtitle("Emissions of PM2.5 in Baltimore (24510) and Los Angeles (06037)") + 
  ylab("Total Emissions from motor vehicles (tons)") + 
  xlab("Year") 
dev.off()



## Difference of Vehicle Emissions between 1999 and 2008 in Baltimore
VehEmissions1999_Baltimore <- Yearly_Emissions_Veh_Bal_LA[(Yearly_Emissions_Veh_Bal_LA$year == 1999 & Yearly_Emissions_Veh_Bal_LA$fips=="24510"), 3]
VehEmissions2008_Baltimore <- Yearly_Emissions_Veh_Bal_LA[(Yearly_Emissions_Veh_Bal_LA$year == 2008 & Yearly_Emissions_Veh_Bal_LA$fips=="24510"), 3]

Diff_VehEmissions2008_1999_Baltimore <- VehEmissions2008_Baltimore - VehEmissions1999_Baltimore


## Difference of Vehicle Emissions between 1999 and 2008 in Los Angeles
VehEmissions1999_LA <- Yearly_Emissions_Veh_Bal_LA[Yearly_Emissions_Veh_Bal_LA$year == 1999 & Yearly_Emissions_Veh_Bal_LA$fips=="06037", 3]
VehEmissions2008_LA <- Yearly_Emissions_Veh_Bal_LA[Yearly_Emissions_Veh_Bal_LA$year == 2008 & Yearly_Emissions_Veh_Bal_LA$fips=="06038", 3]

Diff_VehEmissions2008_1999_LA <- VehEmissions2008_LA - VehEmissions1999_LA

## Difference between LA & Baltimore
abs(Diff_VehEmissions2008_1999_LA)>abs(Diff_VehEmissions2008_1999_Baltimore)