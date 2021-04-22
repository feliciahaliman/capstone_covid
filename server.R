function(input, output) {
    
    output$leafPlot <- renderLeaflet({
        map1 <- leaflet(data = clean_covid)
        map1 <- addTiles(map1)
        
        popup <- paste(clean_covid$clean_covid,  "<br>", 
                       "Country:", clean_covid$Country,  "<br>", 
                       "Cases:", clean_covid$Cases...cumulative.total,  "<br>", 
                       "Vaccine:", clean_covid$new_vaccinations_smoothed_per_million, "<br>"
        )
        
        map1 <- addMarkers(map1,
                           lng = clean_covid$Longitude,
                           lat = clean_covid$Latitude,
                           popup = popup,
                           clusterOptions = markerClusterOptions()
        )
        map1
        
    })

    output$vaccinePlot <- renderPlotly({
        impact <- clean_covid %>% group_by(Day) %>% summarise(total_cumulative_cases = sum(Cases...cumulative.total),
                                                                      total_vaccine = mean(new_vaccinations_smoothed_per_million)) %>% 
            pivot_longer(cols = c(total_cumulative_cases, total_vaccine))
        
            obj2 <- impact %>% ggplot(aes(x = ymd(Day), y = value)) +
            geom_line(aes(group = name)) +
            facet_wrap(~name, scales = "free", nrow = 2)
        
        ggplotly(obj2)
        
    })
    
    output$effectPlot <- renderPlotly({
            effect <- clean_covid %>%
                filter(WHO.Region == input$region) %>% 
                filter(!(Transmission.Classification %in% 
                             c("No cases", "Pending"))) %>%
                count(Transmission.Classification) %>%
                ggplot() +
                aes(x = Transmission.Classification, y = n) +
                labs(x = "Europe Country", y = "Count", options(scipen=99)) +
                geom_col(fill = "#0c4c8a") +
                theme_minimal()
        ggplotly(effect)
        
    })
    
    output$europePlot <- renderPlotly({
        europe <- clean_covid %>%
            filter(WHO.Region %in% "Europe") %>%
            filter(Cases...cumulative.total >= input$europe) %>%
            ggplot() +
            aes(x = reorder(Country, Cases...cumulative.total), group = WHO.Region, weight = Cases...cumulative.total) +
            geom_bar(fill = "#0c4c8a") +
            labs(x = "Country Europe", y = "Total Cases", options(scipen=99)) +
            coord_flip() +
            theme_minimal()
        ggplotly(europe)
        
    })
    
    output$mytable = DT::renderDataTable({
        clean
    })
        
    
}