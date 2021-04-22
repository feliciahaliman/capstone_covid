header <- dashboardHeader(
    title = HTML("COVID-19 Dashboard"), 
    disable = FALSE, 
    titleWidth  = 230,
    dropdownMenu(type = "notifications",
                 messageItem(
                     from = "Support",
                     message = " ",
                     icon = icon("fas fa-headset"),
                 )
    )
)

sidebar <- dashboardSidebar(
    sidebarMenu(
        menuItem(
            text = "Home",
            tabName = "Home",
            icon = icon("fas fa-home")
        ),
        menuItem(
            text = "Dashboard",
            tabName = "Dashboard",
            icon = icon("dashboard")
        ),
        menuItem(
            text = "Data Table",
            tabName = "DataTable",
            icon = icon("th")
        )
    )
)

body <- dashboardBody(
    tabItems(
        tabItem(
            tabName = "Home",
            fluidRow(
                column(
                    width = 12,
                    mainPanel(
                        h3("Based on data from WHO (check: https://covid19.who.int). This dashboard will show cumulative data table related current condition in WHO Area related COVID-19.", 
                             style = "font-style: italic; color: black; font-size: 18px")
                    )
                ),
                basicPage(
                    h2("Data COVID-19"),
                    DT::dataTableOutput("mytable")
                )
            )
        ),
        tabItem(
            tabName = "Dashboard",
            fluidRow(
                mainPanel(
                    h1("World Wide COVID-19 Map",
                       style = "font-style: bold; color: black; font-size: 20px")
                    ),
                column(
                    width = 12,
                    leafletOutput("leafPlot")
                )
            )
        ),
        tabItem(
            tabName = "DataTable",
            fluidRow(
                mainPanel(
                    h1("Impact of Vaccine",
                       style = "font-style: bold; color: black; font-size: 20px")
                ),
                column(
                    width = 12,
                    plotlyOutput("vaccinePlot"),
                ),
                mainPanel(
                    h3("Transmission",
                       style = "font-style: bold; color: black; font-size: 20px")
                ),
                fluidPage(
                    selectInput("region", label = h3("WHO Region"), 
                                choices = unique(clean_covid$WHO.Region), 
                                selected = 1),
                ),
                column(
                    width = 12,
                    plotlyOutput("effectPlot")
                ),
                mainPanel(
                    h3("Cumulative Cases Total in Europe",
                       style = "font-style: bold; color: black; font-size: 20px")
                ), 
                column(4,
                       sliderInput("europe", label = h3("Slider"), min = 0,
                                   max = europe_max, value = 50)
                ),
                column(
                    width = 12,
                    plotlyOutput("europePlot")
                )
            )
        )
    )
)

dashboardPage(
    header = header,
    body = body,
    sidebar = sidebar
)