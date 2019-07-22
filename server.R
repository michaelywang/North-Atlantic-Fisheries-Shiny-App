shinyServer(function(input, output) {
    
        output$EuropeMap <-renderGvis({gvisGeoChart(MapDF, locationvar = 'Country', colorvar='Total_Catch_By_Country', options=list(title="Fishing Catch Volume", width=1200, height=800,colorAxis="{colors:['green','black']}", background="grey", region='world', showZoomOut=TRUE))
        
        })
    
    output$SPECIES_OVERVIEW_PLOT <- renderPlot(#Total Fish by Species
        ggplot(
            Gathered_Fish_Data %>% group_by(Species) %>% summarise(`Live Weight (tonnes)` = sum(totalWeight)) %>% top_n(20, `Live Weight (tonnes)`),
            aes(x = Species, y = `Live Weight (tonnes)`)
        ) + geom_col(aes(fill = `Live Weight (tonnes)`)))
    
    output$COUNTRY_OVERVIEW_PLOT <- renderPlot(
        #Total Fish by Country
        ggplot(
            Gathered_Fish_Data %>% group_by(Country) %>% summarise(`Live Weight (tonnes)` = sum(totalWeight)) %>% top_n(20, `Live Weight (tonnes)`) %>% arrange(desc(`Live Weight (tonnes)`)),
            aes(x = Country, y = `Live Weight (tonnes)`)
        ) + geom_col(aes(fill = `Live Weight (tonnes)`))
    )
    
    
    output$END_PIE <- renderPlot(
            Endangered_Status_Pie_Chart
    )
    
    output$PLOT_COUNTRY <- renderPlot(

        
        Gathered_Fish_Data %>% filter(Country==input$COUNTRY_CHOICE) %>% 
            ggplot(., aes(x = year, y = catch)) + geom_col(aes(fill=input$COUNTRY_CHOICE))+
            #geom_point(alpha = 0.3) +
            #geom_smooth(method = 'lm') +
            ggtitle('Country catch volume over time') +
            xlab('Year') +
            ylab('Catch (tonnes of live weight)') +
            theme(
                plot.title = element_text(
                    face = 'bold',
                    size = 14,
                    hjust = 0.5
                ),
                legend.position = 'none'
            
        
        )
    )
    
    
    output$PLOT_SPECIES <- renderPlot(Gathered_Fish_Data %>% filter(Species==input$SPECIES_CHOICE) %>% 
        ggplot(., aes(x = year, y = catch)) + geom_col(aes(fill=input$SPECIES_CHOICE), fill='grey')+
        #geom_point(alpha = 0.3) +
        #geom_smooth(method = 'lm') +
        ggtitle('Species catch rate over time') +
        xlab('Year') +
        ylab('Catch (tonnes of live weight)') +
        theme(
            plot.title = element_text(
                face = 'bold',
                size = 14,
                hjust = 0.5,
            ),
            legend.position = 'none'))
    
    output$county_table = DT::renderDataTable({
        datatable(to_mapdata(filter_months(current_data(), input$month), choice =
                                 2), rownames = FALSE)
    })
    
    output$table <- DT::renderDataTable({
        datatable(fish27, rownames = FALSE) %>% 
            formatStyle(input$selected, background = 'skyblue', fontWeight = 'bold')
    })
})