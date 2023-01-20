# Visualizing droplet coalescence data for liquid-liquid phase separation
# Xavier Castellanos-Girouard, Rini Ravindran Patel
# August 5 2022


# Import libraries
library(dplyr)
library(tidyr)
library(ggplot2)




# Import values
aspect_ratio_raw <- read.csv(file = "aspect_ratio_values.csv", header = FALSE)
major_axis_raw <- read.csv(file = "axis_major_values.csv", header = FALSE)


# Make dataframe from values in pertinent range
aspect_ratio <- data.frame(values = as.numeric(aspect_ratio_raw[1,380:440]))

# Creating time points
timepoints <- seq(0,(nrow(aspect_ratio)-1)*0.03, by = 0.03)

# Adding time points to dataframe
aspect_ratio$time = timepoints
aspect_ratio$major_axis = as.numeric(major_axis_raw[1,380:440])


# Make the plot
plot <- ggplot(data = aspect_ratio,
         mapping = aes(x= time,
                       y= values))+
  geom_point() +
  theme_bw() +
  xlab("Time") +
  ylab("Aspect Ratio")

dev.new()
plot

#### Fitting curve ####


# Keep only the points in the decay curve
time_slice_start = 15
time_slice_end = 46

print(paste("Curve Start:", time_slice_start, " | ", "Curve End:", time_slice_end))

# Take the points slice:
analysis_slice_df = aspect_ratio[c(time_slice_start:time_slice_end),]


# plot the slice

# Make the plot
plot <- ggplot() +
  geom_point(data = analysis_slice_df,
             mapping = aes(x= time,
                           y= values)) +
  theme_bw() +
  xlab("Time") +
  ylab("Aspect Ratio")

dev.new()
plot

## Defining the decay curve

# Plot the linear decay slope
initial_aspect_ratio = aspect_ratio$values[time_slice_start] # initial AR
ini_t = aspect_ratio$time[time_slice_start] # Initial time start of decay
final_AR = aspect_ratio$value[time_slice_end] # Final AR

e_num = exp(1) # Eulers number

# Decay Function
eDecay <- function(t, IniAR,tau){final_AR+(IniAR-final_AR)*(e_num**(-(t-ini_t)/tau))}

# Plot decay functio
plot(eDecay(t = (analysis_slice_df$time), IniAR = initial_aspect_ratio, 1))



# Make model to find fit tu
fit_model1 <- 
  nls(values ~ eDecay(time, initial_aspect_ratio, tau), 
      data = analysis_slice_df, 
      start = list(tau = 0.08474)) #

print(fit_model1) # 0.2105



# Plot model and experimental data
ggplot() +
  geom_point(data = analysis_slice_df,
             mapping = aes(x= time,
                           y= values)) +
  geom_function(fun = eDecay,
                args = list(IniAR = initial_aspect_ratio,
                            tau = coef(fit_model1)),
                color = "red") +
  theme_bw() +
  xlab("Time") +
  ylab("Aspect Ratio")

