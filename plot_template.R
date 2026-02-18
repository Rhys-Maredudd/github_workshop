# Pretty plot template
library(tidyverse)
library(ggdist)
library(colorspace)
library(ggtext)



# plot itself


## just update name of data item, and replace SPAQ_GSS with required variable

ggplot(data = df_updated,
       aes(x= fct_rev(study_group_info), y = SPAQ_GSS)) +
  ggdist::stat_halfeye(
    aes(
      color = study_group_info,
      fill = after_scale(lighten(color, .5))),
    adjust = .5, 
    width = .75, 
    .width = 0, 
    justification = -.4, 
    point_colour = NA
  ) + 
  geom_boxplot(
    aes(color = stage(study_group_info, after_scale = darken(color, .1, space = "HLS")),
        fill = after_scale(desaturate(lighten(color, .8), .4))),
    width = .42, 
    outlier.shape = NA
  ) +
  geom_point(
    aes(color = stage(study_group_info, after_scale = darken(color, .1, space = "HLS"))),
    fill = "white",
    shape = 21,
    stroke = .4,
    size = 2,
    position = position_jitter(seed = 1, width = .12)) +
  geom_point(
    aes(fill = study_group_info),
    color = "transparent",
    shape = 21,
    stroke = .4,
    size = 2,
    alpha = .3,
    position = position_jitter(seed = 1, width = .12)
  ) + 
  # stat_summary(  #uncomment to provide median value
  #   geom = "text",
  #   fun = "median",
  #   aes(label = round(after_stat(y), 2),
  #       color = stage(study_group_info, after_scale = darken(color, .1, space = "HLS"))),
  #   family = "Roboto Mono",
  #   fontface = "bold",
  #   size = 6.5,
  #   vjust = v_height
  # ) +
  # stat_summary(  # uncomment to provide n
  #   geom = "text",
  #   fun.data = add_sample,
  #   aes(label = paste("n =", after_stat(label)),
  #       color = stage(study_group_info, after_scale = darken(color, .1, space = "HLS"))),
  #   family = "Roboto Condensed",
  #   size = 4,
  #   hjust = -0.2,
  #   vjust = -2.5
  # ) +
  coord_flip(
    #xlim = c(1.2, NA), clip = "off"
  ) +
  scale_y_continuous(
    limits = c(0, 30),
    # breaks = seq(1.6, 3.8, by = .2),
    # expand = c(.001, .001)
  ) +
  scale_color_manual(values = pal, guide = "none") +
  scale_fill_manual(values = pal, guide = "none") +
  labs(
    x = NULL,
    y = "SPAQ Score",
    title = stringr::str_wrap("Seasonal Pattern Assessment Questionniare", width = 40 ),
    caption = "Higher scores represent greater seasonal disruption"
  ) +
  theme_minimal(base_family = "Zilla Slab", base_size = 15) +
  theme(
    panel.grid.minor = element_blank(),
    panel.grid.major.y = element_blank(),
    axis.ticks = element_blank(),
    axis.text.x = element_text(
      #   family = "Roboto Mono"
    ),
    axis.text.y = element_text(
      color = rev(darken(pal, .1, space = "HLS")), 
      size = 14
    ),
    axis.title.x = element_text(
      margin = margin(t = 10), size = 14
    ),
    plot.title = element_markdown(
      face = "bold", size = 18
    ),
    plot.subtitle = element_text(
      color = "grey40", hjust = 0,
      margin = margin(0, 0, 20, 0)
    ),
    plot.title.position = "plot",
    plot.caption = element_markdown(
      color = "grey40", lineheight = 1.2,
      margin = margin(20, 0, 0, 0)
    ),
    plot.margin = margin(t = 20, r = 20, b= 15, l = 20)
  )