shinyUI(
    dashboardPage(
        skin="blue",
        dashboardHeader(title= "North Atlantic Fishing- 2006:2017",
                        titleWidth=250),
        #Sidebar
        dashboardSidebar(
            width=250,
            
            #Sidebar Menu
            sidebarMenu(
                menuItem("Introduction", tabName="INTRO", icon=icon("book")),
                menuItem("Map", tabName="MAP", icon=icon("bar-chart-o")),
                menuItem("Overview", tabName="OVERVIEW",icon=icon("line-chart")),
                menuItem("Global Catch Comparison", tabName="PLOT",icon=icon("line-chart")),
                menuItem("Nominal Catch Data", tabName="DATA", icon=icon("chart-area"))
            )#close sidebarMenu
        ),#close dashboardSidebar
        dashboardBody(
            tabItems(
                #introduction tab
                tabItem(tabName="INTRO",
                        fluidRow(
                            column(width=7,
                                   box(height=800,
                                       title = h2(strong("Introduction")),
                                       width = NULL, solidHeader = FALSE, background =
                                           "blue",
                                       tags$h4(
                                           "Why do we care about fish? Over the past few decades the biomass of the world's oceans has been declining. Many hypothesize that this is due to the fishing industry capturing fish faster than their populations can regrow. This data exploration hopes to identify trends in fishing practices and rates in the North Atlantic. The Food and Agriculture Organization (FAO) and ICES have produced this 11 year report whereby the fish are assessed on capture weight. "
                                           
                                       ),
                                       br(),
                                       HTML(
                                           '<center><img src = "https://upload.wikimedia.org/wikipedia/commons/2/2a/Trawling_Drawing.jpg" width ="75%"></center>'
                                       )
                                       
                                   )),
                            column(width=5,
                                   box(height=800,
                                       title= h2(strong("The Story of NewFoundland Cod")),
                                       width=NULL, solidHeader=FALSE, background="blue",
                                       tags$h4("In the late twentieth century, the Cod industry of the Northwestern Atlantic ocean was booming. However, as fishing practices became more advanced and trawling became more common, fish stocks were being fished much faster than they could be replenished. In 1993, by the time the Canadian government set a moritorium on fishing; the biomass of the local codfish had declined to 1% of their full biomass. As a result, the fishing industry collapsed in Newfoundland and led to the loss of 35,000 jobs and the worst economic event in Canada's history."),
                                       br(),
                                       HTML('<iframe width="560" height="315" src="https://www.youtube.com/embed/WRMp6IrS4YQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>')
                                       
                                       
                                       ))
                            
                        )
                ), #close tabItem: INTRO
                tabItem(tabName="MAP",
                        fluidRow(
                            tabPanel('World Map 2017', htmlOutput('EuropeMap')))
                ), #close tabItem: MAP
                tabItem(tabName = "OVERVIEW",
                        fluidRow(
                            column(width=4,
                            #pie chart showing endangered statuses in catch data
                            
                            plotOutput("END_PIE")

                            ),
                            column(width=8,
                                   #pie chart showing top 20 countries' share of fish capture
                                   
                                   plotOutput("COUNTRY_OVERVIEW_PLOT")
                                   
                            ),
                            column(width=12,
                                   #bar chart showing Species caught in North Atlantic
                                   
                                   plotOutput("SPECIES_OVERVIEW_PLOT")
                                   )
                                )
                ), #close tabItem: OVERVIEW
                tabItem(tabName = "PLOT",
                        fluidRow(
                            
                            
                            #column(width=5, selectizeInput('country_choice',label="Select country",choices=Gathered_Fish_Data$Country)

                             column(width=6,box(
                                    selectInput(
                                        inputId="COUNTRY_CHOICE", label="Country", choices=Gathered_Fish_Data$Country)
                            
                              ),
                             plotOutput("PLOT_COUNTRY")),
                             
                             
                             column(
                                 width = 6,box(
                                 selectInput(
                                     inputId = "SPECIES_CHOICE",
                                     label = "Species",
                                     choices = Top_20_Fish_by_Weight
                                 )
                                 #        selectInput(inputId='xvar', label='TBD2',
                                 #                    choices=c('Country', 'year', 'catch'))
                             ),
                             plotOutput("PLOT_SPECIES"))
                             
                             
                             
                        )#close fluidRow
                ), #close tabItem: PLOT
                tabItem(tabName="DATA",
                        fluidRow(
                            box(DT::dataTableOutput("table"), width=12, title="ICES Fish Dataset")
                        )
                ), #close tabItem: DATAFRAME
                tabItem(tabName="LAST", 
                        fluidRow()
                ) #close tabItem: LAST
                
            )#close tabItems
        )#close dashboardBody
    )#close dashboardPage
)#close Shiny UI
