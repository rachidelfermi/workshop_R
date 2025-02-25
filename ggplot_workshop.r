---
title: "GGPlot Seminar"
author: "Your Name"
date: "`r Sys.Date()`"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE, message = FALSE, warning = FALSE)
```

## Instructions

```{r code_file_instructions, echo=FALSE, eval=FALSE}
## INSTRUCTIONS:
## 1. TO RUN A COMMAND, PLACE CURSOR INSIDE COMMAND
##    OR HIGHLIGHT COMMAND(S) AND HIT CTRL-ENTER (COMMAND-ENTER FOR MACS)
## 2. TO RUN ALL CODE FROM BEGINNING OF FILE TO CURRENT LINE,
##    HIT CTRL-ALT-B (RSTUDIO ONLY)
## 3. COMMANDS THAT BEGIN WITH # ARE COMMENTS AND WILL NOT BE EXECUTED
## 4. NOTE: A FEW COMMANDS MAY PURPOSEFULLY RESULT IN ERRORS FOR TEACHING PURPOSES
## 5. USE CTRL-F TO FIND
```

## Load Required Libraries

```{r load_libraries}
library(ggplot2)
library(MASS)
```

## Scatter Plot Example

```{r ggplot_scatter, fig.cap="geom_point() inherits x and y aesthetics"}
ggplot(txhousing, aes(x=volume, y=sales)) +
  geom_point()
```

```{r ggplot_no_geom, fig.cap="Without a geom or stat, just axes"}
ggplot(data = txhousing, aes(x=volume, y=sales))
```

```{r override, fig.cap="Both geoms inherit aesthetics from ggplot, but geom_rug() also adds color aesthetic"}
ggplot(txhousing, aes(x=volume, y=sales)) +
  geom_point() +
  geom_rug(aes(color=listings))
```

## Mapping Aesthetic Example

```{r mapping_color, fig.cap="Color of points varies with number of listings"}
ggplot(txhousing, aes(x=volume, y=sales)) +
  geom_point(aes(color=listings))
```

```{r setting_color, fig.cap="Color of points set to constant green"}
ggplot(txhousing, aes(x=volume, y=sales)) +
  geom_point(color="green")
```

```{r color_inside_aes, fig.cap="Aesthetic set to constant within aes() leads to unexpected results"}
ggplot(txhousing, aes(x=volume, y=sales)) +
  geom_point(aes(color="green"))
```

## Histogram and Density Plots

```{r hist, fig.cap="Histograms visualize distribution of variable mapped to x"}
ggplot(txhousing, aes(x=median)) + 
  geom_histogram()
```

```{r density, fig.cap="Density plots visualize smoothed distribution of variable mapped to x"}
ggplot(txhousing, aes(x=median)) + 
  geom_density()
```

```{r density_color, fig.cap="Densities of median price by month"}
ggplot(txhousing, aes(x=median, color=factor(month))) + 
  geom_density()
```

## Boxplot Example

```{r boxplot, fig.cap="Boxplots are useful to compare distribution of y variable across levels of x variable"}
ggplot(txhousing, aes(x=factor(year), y=median)) + 
  geom_boxplot()
```

## Barplot Example

```{r barplot, fig.cap="geom_bar displays frequencies of levels of x variable"}
ggplot(diamonds, aes(x=cut)) + 
  geom_bar()
```

```{r barplot_fill, fig.cap="Frequencies of cut by clarity"}
ggplot(diamonds, aes(x=cut, fill=clarity)) + 
  geom_bar()
```

## Line Graph Example

```{r line_graph, fig.cap="Line graph of sales over time, separate lines by city"}
ggplot(txhousing, aes(x=date, y=sales, group=city)) + 
  geom_line()
```

```{r line_graph_color, fig.cap="Line graph of sales over time, colored and grouped by city"}
ggplot(txhousing, aes(x=date, y=sales, color=city)) + 
  geom_line()
```

## Scatter Plots

```{r scatter_1, fig.cap="Scatter plot of volume vs sales"}
ggplot(txhousing, aes(x=volume, y=sales)) + 
  geom_point()
```

```{r scatter_2, fig.cap="Scatter plot of volume vs sales, colored by number of listings, transparent by median price, and sized by inventory"}
ggplot(txhousing, aes(x=volume, y=sales, color=listings, alpha=median, size=inventory)) + 
  geom_point()
```


## Line Graph Examples

```{r line_graph_1, fig.cap="Line graph of sales over time, separate lines by city"}
ggplot(txhousing, aes(x=date, y=sales, group=city)) + 
  geom_line()
```

```{r line_graph_2, fig.cap="Line graph of sales over time, no grouping results in garbled graph"}
ggplot(txhousing, aes(x=date, y=sales)) + 
  geom_line()
```

```{r line_graph_3, fig.cap="Line graph of sales over time, colored and grouped by city"}
ggplot(txhousing, aes(x=date, y=sales, color=city)) + 
  geom_line()
```

## Statistical Summaries

```{r stat_summary_1, fig.cap="Mean and standard errors of sales by year"}
ggplot(txhousing, aes(x=year, y=sales)) + 
  stat_summary()
```

## Example Scales

```{r example_scales, echo=FALSE}
color_scale <- data.frame(color=c("red", "blue"), treat=c("ozone", "control"))
knitr::kable(color_scale)
```

## Customizing Scales

```{r scale_default, fig.cap="Default color scale"}
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + 
  geom_point()
```

```{r scale_manual, fig.cap="Using scale_color_manual to respecify colors"}
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + 
  geom_point() +
  scale_color_manual(values=c("red", "yellow", "green", "blue", "violet"))
```

```{r scale_ticks, fig.cap="Changing y-axis tick marks"}
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + 
  geom_point() +
  scale_y_continuous(breaks=c(0,2500,5000,7500,10000,12500,15000,17500))
```

```{r scale_labels, fig.cap="Relabeling y-axis tick marks"}
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + 
  geom_point() +
  scale_y_continuous(breaks=c(0,2500,5000,7500,10000,12500,15000,17500),
                     labels=c(0,2.5,5,7.5,10,12.5,15,17.5))
```

```{r scale_axis_title, fig.cap="New y-axis title"}
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + 
  geom_point() +
  scale_y_continuous(breaks=c(0,2500,5000,7500,10000,12500,15000,17500),
                     labels=c(0,2.5,5,7.5,10,12.5,15,17.5),
                     name="Price (thousands of dollars)")
```

```{r x_axis_limits, fig.cap="Restricting axis limits will zoom in"}
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + 
  geom_point() +
  xlim(c(1,3))
```

## Custom Labels

```{r custom_labels, fig.cap="Respecifying all titles with labs"}
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + 
  geom_point() +
  labs(x="CARAT", y="PRICE", color="CUT", title="CARAT vs PRICE by CUT")
```

## Guides and Legends

```{r remove_legend, fig.cap="Color legend removed"}
ggplot(txhousing, aes(x=volume, y=sales, color=median)) + 
  geom_point() +
  guides(color="none")
```

## Faceting

```{r facet_wrap, fig.cap="Carat vs Price, paneled by cut with facet_wrap()"}
ggplot(diamonds, aes(x=carat, y=price)) + 
  geom_point() + 
  facet_wrap(~cut)
```

```{r facet_grid, fig.cap="Carat vs Price, paneled by clarity and cut with facet_grid()"}
ggplot(diamonds, aes(x=carat, y=price)) + 
  geom_point() + 
  facet_grid(clarity~cut)
```


## Line Graph Examples

```{r line_graph_1, fig.cap="Line graph of sales over time, separate lines by city"}
ggplot(txhousing, aes(x=date, y=sales, group=city)) + 
  geom_line()
```

```{r line_graph_2, fig.cap="Line graph of sales over time, no grouping results in garbled graph"}
ggplot(txhousing, aes(x=date, y=sales)) + 
  geom_line()
```

```{r line_graph_3, fig.cap="Line graph of sales over time, colored and grouped by city"}
ggplot(txhousing, aes(x=date, y=sales, color=city)) + 
  geom_line()
```

## Statistical Summaries

```{r stat_summary_1, fig.cap="Mean and standard errors of sales by year"}
ggplot(txhousing, aes(x=year, y=sales)) + 
  stat_summary()
```

## Example Scales

```{r example_scales, echo=FALSE}
color_scale <- data.frame(color=c("red", "blue"), treat=c("ozone", "control"))
knitr::kable(color_scale)
```

## Customizing Scales

```{r scale_default, fig.cap="Default color scale"}
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + 
  geom_point()
```

```{r scale_manual, fig.cap="Using scale_color_manual to respecify colors"}
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + 
  geom_point() +
  scale_color_manual(values=c("red", "yellow", "green", "blue", "violet"))
```

## Themes and Customizations

```{r theme_axis_line, fig.cap="Using theme argument axis.line to modify x-axis and y-axis lines"}
ggplot(txhousing, aes(x=volume, y=sales, color=listings)) + 
  geom_point() +
  theme(axis.line=element_line(color="black", size=2))
```

```{r theme_panel_background, fig.cap="Using theme element axis.line.x to modify x-axis line"}
ggplot(txhousing, aes(x=volume, y=sales, color=listings)) + 
  geom_point() +
  theme(axis.line=element_line(color="black", size=2),
        panel.background=element_rect(fill="white", color="gray"))
```

```{r theme_title, fig.cap="Using theme argument title to adjust fonts of all titles"}
ggplot(txhousing, aes(x=volume, y=sales, color=listings)) + 
  geom_point() +
  theme(axis.line=element_line(color="black", size=2),
        panel.background=element_rect(fill="white", color="gray"),
        title=element_text(family="serif", face="bold"))
```

```{r theme_legend_position, fig.cap="Using theme argument legend.position to position legend"}
ggplot(txhousing, aes(x=volume, y=sales, color=listings)) + 
  geom_point() +
  theme(axis.line=element_line(color="black", size=2),
        panel.background=element_rect(fill="white", color="gray"),
        title=element_text(family="serif", face="bold"),
        legend.position="bottom")
```

```{r theme_classic, fig.cap="theme_classic()"}
ggplot(txhousing, aes(x=volume, y=sales, color=listings)) + 
  geom_point() +
  theme_classic()
```

```{r theme_dark, fig.cap="theme_dark()"}
ggplot(txhousing, aes(x=volume, y=sales, color=listings)) + 
  geom_point() +
  theme_dark()
```

## Saving Plots

```{r save_plot, eval=FALSE}
# Save last displayed plot as pdf
ggsave("plot.pdf")

# If you're working with lots of graphs, you can store them in R objects
p <- ggplot(Sitka, aes(x=Time, y=size)) +
  geom_point()
# Use the plot argument of ggsave() to specify which plot to save
ggsave("myplot.png", plot=p)
```


## Line Graph Examples

```{r line_graph_1, fig.cap="Line graph of sales over time, separate lines by city"}
ggplot(txhousing, aes(x=date, y=sales, group=city)) + 
  geom_line()
```

```{r line_graph_2, fig.cap="Line graph of sales over time, no grouping results in garbled graph"}
ggplot(txhousing, aes(x=date, y=sales)) + 
  geom_line()
```

```{r line_graph_3, fig.cap="Line graph of sales over time, colored and grouped by city"}
ggplot(txhousing, aes(x=date, y=sales, color=city)) + 
  geom_line()
```

## Statistical Summaries

```{r stat_summary_1, fig.cap="Mean and standard errors of sales by year"}
ggplot(txhousing, aes(x=year, y=sales)) + 
  stat_summary()
```

## Example Scales

```{r example_scales, echo=FALSE}
color_scale <- data.frame(color=c("red", "blue"), treat=c("ozone", "control"))
knitr::kable(color_scale)
```

## Customizing Scales

```{r scale_default, fig.cap="Default color scale"}
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + 
  geom_point()
```

```{r scale_manual, fig.cap="Using scale_color_manual to respecify colors"}
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + 
  geom_point() +
  scale_color_manual(values=c("red", "yellow", "green", "blue", "violet"))
```

## Themes and Customizations

```{r theme_axis_line, fig.cap="Using theme argument axis.line to modify x-axis and y-axis lines"}
ggplot(txhousing, aes(x=volume, y=sales, color=listings)) + 
  geom_point() +
  theme(axis.line=element_line(color="black", size=2))
```

```{r theme_panel_background, fig.cap="Using theme element axis.line.x to modify x-axis line"}
ggplot(txhousing, aes(x=volume, y=sales, color=listings)) + 
  geom_point() +
  theme(axis.line=element_line(color="black", size=2),
        panel.background=element_rect(fill="white", color="gray"))
```

```{r theme_title, fig.cap="Using theme argument title to adjust fonts of all titles"}
ggplot(txhousing, aes(x=volume, y=sales, color=listings)) + 
  geom_point() +
  theme(axis.line=element_line(color="black", size=2),
        panel.background=element_rect(fill="white", color="gray"),
        title=element_text(family="serif", face="bold"))
```

```{r theme_legend_position, fig.cap="Using theme argument legend.position to position legend"}
ggplot(txhousing, aes(x=volume, y=sales, color=listings)) + 
  geom_point() +
  theme(axis.line=element_line(color="black", size=2),
        panel.background=element_rect(fill="white", color="gray"),
        title=element_text(family="serif", face="bold"),
        legend.position="bottom")
```

```{r theme_classic, fig.cap="theme_classic()"}
ggplot(txhousing, aes(x=volume, y=sales, color=listings)) + 
  geom_point() +
  theme_classic()
```

```{r theme_dark, fig.cap="theme_dark()"}
ggplot(txhousing, aes(x=volume, y=sales, color=listings)) + 
  geom_point() +
  theme_dark()
```

## Additional Data Processing

```{r exercise_4_data, echo=TRUE}
Rabbit <- read.csv("https://stats.oarc.ucla.edu/wp-content/uploads/2024/05/Rabbit.csv")
```

```{r remove_birthwt, echo=FALSE}
rm(birthwt)
```

## Color and Factor Mappings

```{r color_numeric, fig.cap="Color gradient is appropriate for a continuous variable"}
ggplot(birthwt, aes(x=age, y=bwt, color=race)) +
  geom_point()
```

```{r color_factor, fig.cap="Evenly spaced hues emphasize contrasts between groups of a factor"}
ggplot(birthwt, aes(x=age, y=bwt, color=factor(race))) +
  geom_point()
```

```{r shape_factor, fig.cap="Evenly spaced hues emphasize contrasts between groups of a factor"}
ggplot(birthwt, aes(x=age, y=bwt, shape=factor(race))) +
  geom_point()
```

```{r weight_by_smoke, fig.cap="Birth weight distribution by mother's smoking status"}
ggplot(birthwt, aes(y=bwt, fill=smokef)) +
  geom_boxplot()
```

## Regression and Confidence Bands

```{r regression_birthweight, fig.cap="Best fit line with confidence bands"}
m <- lm(bwt ~ age, data=birthwt)
preddata <- predict(m, interval="confidence")
birthwt <- cbind(birthwt, preddata)
ggplot(birthwt, aes(x=age, y=fit)) + 
  geom_line() +
  geom_ribbon(aes(ymin=lwr, ymax=upr), alpha=.5)
```



