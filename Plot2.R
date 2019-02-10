## This first line will likely take a few seconds.
# Read Data from Assignment Week 4
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)

# Summarise Emissions by Year in Baltimore
Yearly_Emissions_Summary_Baltimore <- NEI %>% 
  subset(fips == "24510") %>%
  group_by(year) %>%
  summarize(Sum_Emissions = sum(Emissions, na.rm = TRUE))
Yearly_Emissions_Summary_Baltimore


## create the plot of Yearly Emissions
png(filename = "plot1.png")
plot(Yearly_Emissions_Summary_Baltimore$year, Yearly_Emissions_Summary_Baltimore$Sum_Emissions, 
     type = "l", 
     main = "Total Annual Emissions of PM2.5 in Baltimore per Year",
     ylab = "Total Emissions of PM2.5 (tons)",
     xlab = "Year")
dev.off()

# Difference in Emissions From 1999 to 2008 in Baltimore
Emissions2008_Baltimore <- Yearly_Emissions_Summary_Baltimore[Yearly_Emissions_Summary_Baltimore$year == 2008, 2]
Emissions1999_Baltimore <- Yearly_Emissions_Summary_Baltimore[Yearly_Emissions_Summary_Baltimore$year == 1999, 2]

Diff_Emissions2008_1999_Baltimore <- Emissions2008_Baltimore - Emissions1999_Baltimore
