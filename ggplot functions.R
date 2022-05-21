gg_geom_point <- function(
  # basic
  .data, x, y=beta, ymin=lb, ymax=ub, p_dodge = T,
  shape = NULL, colour = NULL, linetype = NULL,   
  
  # Faceting
  facet_type = F, vert = "", hori = "", scales = "fixed", nrow = NULL, ncol = NULL, 
  
  # Aestetic
  theme = 1, qr_edit = F, rect_col = "gray", yint = 0,
  shape_vec = NULL, linetype_vec = NULL, colour_vec = NULL, xlab_vec = NULL,
  panel.spacing.x = 0.075, panel.spacing.y = 0.075,
  
  # titles
  title = NULL, subtitle = NULL, caption = NULL, 
  ylab = NULL, xlab = waiver(),
  col_title = waiver(), shape_title = waiver(), linetype_title = waiver(),
  
  # Fix font
  text_size_minor = 9, text_size_major = 10, text_size_title = 11,
  
  # legend
  legend.position = "bottom", legend.title.align = 0.5, legend.direction = "vertical", 
  legend.box = "vertical", legend.margin_inch = 0.00625, legend.spacing = 0.00625,
  
  # misc
  coord_flip = F,  limits = c(), breaks = waiver(),x_angle = 0, ystrip_angle = 270
  ) {
  
  # if breaks were specified, then limits need to be specified too. 
  
  if(is.vector(breaks) == T){
    lower_limit <- min(breaks)
    upper_limit <- max(breaks)
    limits <- c(lower_limit, upper_limit)
  }
  
  fig <- ggplot() + 
    
    
    
    # Add details if Quantile regression is used
    {
      if (qr_edit == T){
        geom_vline(xintercept = 5.5) 
      }
    } +
      
      {
        if (qr_edit == T){
          geom_rect(data = .data,
                    aes(ymin = -Inf, ymax = Inf, xmin = 5.5, xmax = Inf), 
                    fill = rect_col, alpha = 0.1)
        }
      } +
    
    # map results ----
    {    
      if(p_dodge == T){
        geom_pointrange(data = .data, 
                        # shape = shape_manual, 
                        aes(x = {{x}}, y = {{y}}, ymin = {{ymin}}, ymax = {{ymax}},
                            shape = {{shape}}, color = {{colour}}, linetype = {{linetype}}),
                        position = position_dodge(width = 1))
      }
    } +
    
    {
      if(p_dodge == F){
        geom_pointrange(data = .data,
                        aes(x = {{x}}, y = {{y}}, ymin = {{ymin}}, ymax = {{ymax}},
                            shape = {{shape}}, color = {{colour}}, linetype = {{linetype}}))
      }
    } +
    # geom_pointrange(data = data,
    #                       aes(x = {{x}}, y = {{y}}, ymin = {{ymin}}, ymax = {{ymax}},
    #                           shape = {{shape}}, color = {{colour}}, linetype = {{linetype}})) +
    
    
    
    # organize facets----
    {
      if(facet_type == "grid"){
        facet_grid(paste0({{vert}}, '~', {{hori}}), scales = scales)
      } 
    } +
      {
        if(facet_type == "wrap") {
          facet_wrap(paste0({{vert}}, "~", {{hori}}), scales = scales, nrow= nrow, ncol = ncol)
        } 
    } +
    
    # aestetic ----
    {
      if(is.null(yint) == F){
        geom_hline(yintercept = yint, lty =5, size=0.5) #set y-intercept = 0 (the null value)
      }
    } +
    
    ## theme 1 is black and white
    {
      if (theme == 1){
        theme_bw()
      } 
    } +
    
    ## theme 2 more minimal
    ### add lines to the bottom and right edge of each facet
    {
      if (theme == 2){
        annotate("segment", x=-Inf, xend=Inf, y=-Inf, yend=-Inf, size=1)
      }
    } +
    {
      if (theme == 2){
        annotate("segment", x=-Inf, xend=-Inf, y=-Inf, yend=Inf, size=1) 
      }
    } +
    
    {
      if (theme == 2){
        theme_minimal() + # gets of the boxes around facet titles.   
          theme(plot.background = element_blank(),
                panel.grid.major = element_blank(),
                panel.grid.minor = element_blank(),
                panel.border = element_blank() ) +
          theme(strip.text = element_text(face = "bold")) 
        
      }
    } +
    
    {
      if(is.null(xlab_vec)==F){
        scale_x_discrete(labels = xlab_vec) #set x axis labels manually
      }
    } + 
    
    {
      if(is.null(colour_vec)==F){
        scale_colour_manual(values = colour_vec) #set colour scheme manually
      }
    } +
    
    {
      if(is.null(linetype_vec)==F){
        scale_linetype_manual(values = linetype_vec) #set linetype scheme manually
      }
    } +
    
    {
      if(is.null(shape_vec)==F){
        scale_shape_manual(values = shape_vec) #set shape scheme manually
      }
    } +
    
    ## add option to increase facet margins
    {
      if(facet_type == "grid"  | facet_type == "wrap"){
        theme(panel.spacing.x = unit(panel.spacing.x, "inch")) 
      } 
    } +
    
    {
      if(facet_type == "grid"  | facet_type == "wrap"){
        theme(panel.spacing.y = unit(panel.spacing.y, "inch")) 
      } 
    } +
    
    
    # fix font ----
    theme(text = element_text(family = "sans", colour = "black", size = text_size_minor)) +
    theme(axis.text.x = element_text(size=text_size_minor, colour = "black", angle = x_angle)) + 
    theme(axis.text.y = element_text(size=text_size_minor, colour = "black")) + 
    theme(axis.ticks = element_line(size = 0.5, colour = "black")) + 
    
    theme(axis.title.x = element_text(size=text_size_major, colour = "black")) + 
    theme(axis.title.y = element_text(size=text_size_major, colour = "black")) +
    # theme(axis.title.y = element_text(margin = text_size_major(0,0,0,0, unit="in"))) +
    # theme(axis.title.x = element_text(margin = margin(0,0,0,0, unit="in"))) +
    
    theme(strip.text.x = element_text(size=text_size_major, colour = "black")) +
    theme(strip.text.y = element_text(size=text_size_major, colour = "black", angle = ystrip_angle)) +
    theme(legend.text = element_text(size=text_size_minor, colour = "black")) +
    
    theme(title = element_text(size = text_size_title, colour = "black")) +
    
    
    
    # legend ----
    theme(legend.position = legend.position, legend.title.align = legend.title.align,
          legend.background = element_rect(size=0.5, linetype="solid"),
          legend.direction = legend.direction, legend.box = legend.box
          ,
          legend.box.margin = margin(legend.margin_inch, legend.margin_inch,
                                 legend.margin_inch, legend.margin_inch, unit = "inch"),
          legend.spacing = unit(legend.spacing, units = "inch")
          ) +
    
    #labels ----
    labs(title = title, subtitle = subtitle, caption = caption) +
    labs(col = col_title) +
    labs(shape = shape_title) +
    labs(linetype = linetype_title) +
    
    {
      if(is.null(shape_title)==T){
        guides(shape = F)
      }
    } +
    
    # guides(colour = col_title) +
    # guides(shape = shape_title) +
    # guides(linetype = linetype_title) +
    {if(is.null(ylab)){
      ylab(bquote("β"))
    } else{
      ylab(print(ylab))
    }} +
    xlab(xlab) +
    
    
    #minor fixes ----
    # theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust=0.5)) +
    scale_y_continuous(labels = signs_format(), #ensure y axis labels use minus sign, not hyphen
                       breaks = breaks) + 
    # if "breaks" need to changed from default, they can be specified here. 
    
    # if breaks were changed, the limits also need to be changed. Otherwise this can be left blank.
    coord_cartesian(ylim = limits) +
    {
      if(coord_flip == T){ 
        coord_flip(ylim = limits) # flip coordinate system
      }
    } 
    
  
  return(fig)
}






