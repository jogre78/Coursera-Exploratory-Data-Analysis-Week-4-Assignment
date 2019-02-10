## This first line will likely take a few seconds.
# Read Data from Assignment Week 4
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)

# Summarise Emissions by Year and by Type in Baltimore
Yearly_Emissions_byType_Summary_Baltimore <- NEI %>% 
  subset(fips == "24510") %>%
  group_by(year,type) %>%
  summarize(Sum_Emissions = sum(Emissions, na.rm = TRUE))
Yearly_Emissions_byType_Summary_Baltimore


## create the plot of Yearly Emissions
png(filename = "plot3.png")
qplot(Year,Sum_Emissions,data=Yearly_Emissions_byType_Summary_Baltimore,
      color=Type,geom="Line") +
ggtitle("Total Annual Emissions of PM2.5 in Baltimore per Year and Polluant Type") +
     ylab ("Total Emissions of PM2.5 (tons)") +
     xlab ("Year")
dev.off()
