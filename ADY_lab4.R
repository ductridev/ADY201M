library(knitr)
library(class)
library(tidyverse)
library(GGally)
install.packages("irr")
library(irr)
install.packages("plotly")
library(plotly)
install.packages("corrplot")
library(corrplot)
df = read.csv(choose.files())

month_order <- c("Tháng một", "Tháng hai", "Tháng ba", "Tháng tư", "Tháng năm", "Tháng sáu",
                 "Tháng bảy", "Tháng tám", "Tháng chín", "Tháng mười", "Tháng mười một", "Tháng mười hai")

# order Thang
df$Tháng <- factor(df$Tháng, levels = month_order)

# plot overview trend 
plot <- plot_ly(data = df, x = ~Tháng, type = "scatter", mode = "lines+markers",
                frame = ~Giai.đoạn, color = ~Giai.đoạn) %>%
  add_trace(y = ~Lượng.mưa, name = "Rainfall", yaxis = "y1", type = "bar") %>%
  add_trace(y = ~Nhiệt.độ.trung.bình, name = "Temperature", yaxis = "y2", line = list(color = "red")) %>%
  layout(
    title = "Rainfall and Temperature Trends by Period",
    xaxis = list(title = "Month"),
    yaxis = list(
      title = "Rainfall (mm)",
      side = "left",
      showgrid = FALSE
    ),
    yaxis2 = list(
      title = "Temperature (°C)",
      side = "right",
      overlaying = "y",
      showgrid = FALSE
    ),
    legend = list(x = 0, y = 1)
  )
plot


plot <- plot_ly(data = df, x = ~Tháng, type = "scatter", mode = "lines+markers",
                frame = ~Giai.đoạn, color = ~Giai.đoạn) %>%
  add_trace(y = ~Nhiệt.độ.cao.nhất, name = "Temperature max", yaxis = "y2", line = list(color = "red")) %>%
  add_trace(y = ~Nhiệt.độ.trung.bình, name = "Temperature arg", yaxis = "y2", line = list(color = "blue")) %>%
  add_trace(y = ~Nhiệt.độ.thấp.nhất, name = "Temperature min", yaxis = "y2", line = list(color = "red")) %>%
  
  layout(
    title = "Trend of temperature variation",
    xaxis = list(title = "Month"),
    yaxis2 = list(
      title = "Temperature (°C)",
      side = "right",
      overlaying = "y",
      showgrid = FALSE
    ),
    legend = list(x = 0, y = 1)
  )
plot

# Split data frame
df_1 <- df %>% filter(Giai.đoạn == "1901-1930")
df_2 <- df %>% filter(Giai.đoạn == "1931-1960")
df_3 <- df %>% filter(Giai.đoạn == "1961-1990")
df_4 <- df %>% filter(Giai.đoạn == "1991-2020")




# Calculate the gradient of rainfall 
df_2$Gradient <- df_2$Lượng.mưa - df_1$Lượng.mưa
df_3$Gradient <- df_3$Lượng.mưa - df_2$Lượng.mưa
df_4$Gradient <- df_4$Lượng.mưa - df_3$Lượng.mưa

# plot to compare the gradient of rainfall
plot <- plot_ly() %>%
  add_trace(data = df_2, x = ~Tháng, y = ~Gradient, name = "1931-1960", type = "scatter", mode = "lines") %>%
  add_trace(data = df_3, x = ~Tháng, y = ~Gradient, name = "1961-1990", type = "scatter", mode = "lines") %>%
  add_trace(data = df_4, x = ~Tháng, y = ~Gradient, name = "1991-2020", type = "scatter", mode = "lines") %>%
  layout(
    title = "Gradient of Rainfall ",
    xaxis = list(title = "Month"),
    yaxis = list(title = "Gradient of Rainfall"),
    showlegend = TRUE
  )

# Display the plot
plot


# Calculate the gradient of rainfall 
df_2$Gradient <- df_2$Nhiệt.độ.trung.bình - df_1$Nhiệt.độ.trung.bình
df_3$Gradient <- df_3$Nhiệt.độ.trung.bình - df_2$Nhiệt.độ.trung.bình
df_4$Gradient <- df_4$Nhiệt.độ.trung.bình - df_3$Nhiệt.độ.trung.bình

# plot to compare the gradient of Temperature
plot <- plot_ly() %>%
  add_trace(data = df_2, x = ~Tháng, y = ~Gradient, name = "1931-1960", type = "scatter", mode = "lines") %>%
  add_trace(data = df_3, x = ~Tháng, y = ~Gradient, name = "1961-1990", type = "scatter", mode = "lines") %>%
  add_trace(data = df_4, x = ~Tháng, y = ~Gradient, name = "1991-2020", type = "scatter", mode = "lines") %>%
  layout(
    title = "Gradient of Temperature",
    xaxis = list(title = "Month"),
    yaxis = list(title = "Gradient of Temperature"),
    showlegend = TRUE
  )

# Display the plot
plot






