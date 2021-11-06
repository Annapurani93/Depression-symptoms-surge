library(tidyverse)
library(openxlsx)
library(readxl)
library(reshape2)
library(ggtext)
read_excel("depression.xlsx")->data
data.frame(data)->data
colnames(data)<-c("Group","2020","2021")
data%>%
  select("Group","2021","2020")->data
melt(data,id.vars = "Group",measure.vars = c("2021","2020"),value.name = "value")->Data1
Data1

ggplot(Data1,aes(x=value,y=Group,fill=variable,label=paste0(value,"%")))+
  geom_col(position = position_dodge(width=0.8),width=0.5,colour="white")+
  geom_text(colour="white",position=position_dodge(width=0.8),size=6,vjust=0.4,hjust=-0.5)+
  scale_fill_manual(values=c("#ee3c4c","#ac9f73"),labels=c("January-March 2021","July 2019-March 2020"))+
  theme(plot.background = element_rect(fill="black"),
        panel.background = element_rect(fill="black"),
        legend.title = element_blank(),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank(),
        legend.position = "top",
        legend.background = element_rect(fill="black"),
        legend.text = element_text(colour="#ebd394",size=12, face = "bold"),
        axis.text.x = element_blank(),
        axis.text.y = element_text(colour="#ebd394",size=16,margin=margin(r=-25),face = "bold"),
        plot.title.position = "plot",
        plot.caption.position = "plot",
        plot.margin = unit(c(.5, 1, .5, 1), "cm"),
        plot.title = element_text(colour="#f7edd4",size=21,face="bold",margin=margin(b=12)),
        plot.subtitle = element_text(colour="#f7edd4",size=16,face="bold",margin=margin(b=21)),
        plot.caption=element_text(colour="#f7edd4",size=12,hjust=0,margin=margin(t=12))
        )+
        labs(title = "DEPRESSION SYMPTOMS SURGE POST-COVID19",
    subtitle=str_wrap("Rates of depression symptoms across all groups of people climbed in early 2021 (January to March) when compared to the period before the pandemic (July 2019 to March 2020)",120),
    caption = "Data: @DiversityinData | Design: @annapurani93"
        )->plot1

plot1
ggsave("depressionplot.png",plot1,width=16,height=16,dpi=600)  
ggsave("depressionplot.pdf",plot1,width=16,height=16,dpi=600,device=cairo_pdf)        
