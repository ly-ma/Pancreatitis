y = c(259,227,183,150,16)
z = c(135,80,268,90,0)
library(ggplot2)
install.packages("tidyverse")
library(tidyverse)
df = data.frame(value = z,group = paste0("cell_type_",0:4))
df2 <- df %>% 
  mutate(csum = rev(cumsum(rev(value))), 
         pos = value/2 + lead(csum, 1),
         pos = if_else(is.na(pos), value/2, pos))

ggplot(df, aes(x = "", y = value, fill = fct_inorder(group))) +
  geom_col(width = 1, color = 1) +
  geom_text(aes(label = value),
            position = position_stack(vjust = 0.5)) +
  coord_polar(theta = "y") +
  guides(fill = guide_legend(title = "Group")) +
  scale_y_continuous(breaks = df2$pos, labels = df$group) +
  theme(axis.ticks = element_blank(),
        axis.title = element_blank(),
        axis.text = element_text(size = 15), 
        legend.position = "none", # Removes the legend
        panel.background = element_rect(fill = "white"))


library("biomaRt")
BiocManager::install("biomaRt")
library('dior')
