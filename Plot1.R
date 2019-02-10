## This first line will likely take a few seconds.
# Read Data from Assignment Week 4
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)

# Summarise Emissions by Year
Yearly_Emissions_Summary <- NEI %>%  
  group_by(year) %>%
  summarize(Sum_Emissions = sum(Emissions, na.rm = TRUE))
Yearly_Emissions_Summary 


## create the plot of Yearly Emissions
png(filename = "plot1.png")
plot(Yearly_Emissions_Summary$year, Yearly_Emissions_Summary$Sum_Emissions, 
     type = "l", 
     main = "Total Annual Emissions of PM2.5 in the US per Year",
     ylab = "Total Emissions of PM2.5 (tons)",
     xlab = "Year")
dev.off()

# Difference in Emissions From 1999 to 2008
Emissions2008 <- Yearly_Emissions_Summary[Yearly_Emissions_Summary$year == 2008, 2]
Emissions1999 <- Yearly_Emissions_Summary[Yearly_Emissions_Summary$year == 1999, 2]

Diff_Emissions2008_1999 <- Emissions2008 - Emissions1999
