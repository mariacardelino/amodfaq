library(shiny)

# UI SECTION #############################
ui <- fluidPage(
  titlePanel("AMOD/S Device Troubleshooting"),

  tags$h4("Choose from the list of FAQs. We can also provide support via the MAIA AMOD Slack Channel."),
  tags$h5(HTML('Contact <a href="mailto:christian.lorange@colostate.edu?subject=Support%20for%20AMOD%20Device">christian.lorange@colostate.edu</a> for an invitation to the channel.')),
  
  # # Search bar
  # textInput("search", "Search FAQs", ""),
  
  hr(),
  
  fluidRow(
    column(3,
           tags$ul(
             tags$li(actionLink("link_led_colors", "What do the LED light colors mean?")),
             tags$li(actionLink("link_device_not_turning_on", "My device will not turn on.")),
             tags$li(actionLink("link_led_light_flashes", "When I turn my AMOD on and try to pair it, the LED light flashes.")),
             tags$li(actionLink("link_led_stays_red", "The LED light stays red when I push 'Start Sampling' and is unable to find the sun.")),
             tags$li(actionLink("link_wifi_issue", "The AMOD will not connect to my Wi-Fi.")),
             tags$li(actionLink("link_ceams_scan", "The AMOD does not show up when I push 'Scan' in the CEAMS mobile application.")),
             tags$li(actionLink("link_wifi_router_draining", "The Wi-Fi router keeps draining/dying.")),
             tags$li(actionLink("link_glossary", "Glossary of Terms"))
           )
    ),
    
    column(9,
           uiOutput("main_content")
    )
  )
)

# SERVER SECTION ##############################
server <- function(input, output, session) {
  
  # store topic
  selected_topic <- reactiveVal("home")
  
  observeEvent(input$link_led_colors, {
    selected_topic("led_colors")
  })
  
  observeEvent(input$link_device_not_turning_on, {
    selected_topic("device_not_turning_on")
  })
  
  observeEvent(input$link_led_light_flashes, {
    selected_topic("led_light_flashes")
  })
  
  observeEvent(input$link_led_stays_red, {
    selected_topic("led_stays_red")
  })
  
  observeEvent(input$link_wifi_issue, {
    selected_topic("wifi_issue")
  })
  
  observeEvent(input$link_ceams_scan, {
    selected_topic("ceams_scan")
  })
  
  observeEvent(input$link_wifi_router_draining, {
    selected_topic("wifi_router_draining")
  })
  
  observeEvent(input$link_glossary, {
    selected_topic("glossary")
  })
  
  output$main_content <- renderUI({
    topic <- selected_topic()
    
    if (topic == "home") {
      fluidPage(
        h3("Welcome to AMOD/S Device Troubleshooting"),
        p("Please select a troubleshooting topic from the list on the left or use the search bar to find specific FAQs.")
      )
      
    } else if (topic == "led_colors") {
      fluidPage(
        h3("What do the LED light colors mean?"),
        p("The AMOD LED lights change colors during different processes. Here’s what each color represents:"),
        tags$ul(
          tags$li("Blue: Charging mode 1"),
          tags$li("Pink: Charging mode 2"),
          tags$li("Red: Error indication")
        ),
        p("If you get a flashing red light, please contact the Emory team immediately as this indicates an error. We will attempt to help you diagnose the problem.")
      )
      
    } else if (topic == "device_not_turning_on") {
      fluidPage(
        h3("My device will not turn on."),
        p("First, check if it's just the LED light that is out. Does the LED light come on when it is charging (plugged in)?"),
        p("If not, try pressing down on the button for at least 3 seconds and determine if the device responds. If it does, then only the LED light is out, and you can still pair the device."),
        p("If nothing happens, try leaving the device charging overnight. Again, check if the LED light is on while it is charging."),
        p("If the LED light is not coming on after charging overnight, please contact the Emory team.")
      )
      
    } else if (topic == "led_light_flashes") {
      fluidPage(
        h3("When I turn my AMOD on and try to pair it, the LED light flashes."),
        p("Your device likely had a complete battery drain. Please charge the AMOD and then proceed to connect to the device. The LED light will stop flashing once it has reestablished GPS clock time.")
      )
      
    } else if (topic == "led_stays_red") {
      fluidPage(
        h3("The LED light stays red when I push 'Start Sampling' and is unable to find the sun."),
        p("This is likely because the AMOD GPS has not synced. Therefore, it does not know its location and cannot calculate the angle for the sun."),
        p("Occasionally, it will have to wait until the second scan (20 minutes after the start time) to locate itself and find the sun.")
      )
      
    } else if (topic == "wifi_issue") {
      fluidPage(
        h3("The AMOD will not connect to my Wi-Fi."),
        p("If you are outside, go indoors and try to connect while inside. Then go back outside and check if your Wi-Fi signal is strong enough to connect to your phone."),
        p("If not, you may need to move the AMOD closer to the Wi-Fi router or powercycle both the CEAMS app and the AMOD. To powercycle, close the app and restart both the app and the AMOD."),
        p("If this does not fix the issue, you may have to let the AMOD run with Wi-Fi turned off. In this case, you will not be able to see your data on the website in real-time."),
        p("After the sample period is done, you can take the device back inside to charge and connect to Wi-Fi. The device will push some of the missed data to the website."),
        p("If the AMOD will not connect to Wi-Fi, please contact the Emory team for support.")
      )
      
    } else if (topic == "ceams_scan") {
      fluidPage(
        h3("The AMOD does not show up when I push 'Scan' in the CEAMS mobile application."),
        p("First, check that you have Bluetooth enabled on your phone (ensure your phone can connect to any Bluetooth device)."),
        p("Second, make sure that the AMOD is turned on and that the LED light is pink."),
        p("If the device still does not appear, try restarting your phone or using another mobile device with the CEAMS application.")
      )
      
    } else if (topic == "wifi_router_draining") {
      fluidPage(
        h3("The Wi-Fi router keeps draining/dying."),
        p("If the router is placed on a rooftop, overheating may be the cause of this issue."),
        p("Try removing the battery of the router to prevent Wi-Fi disconnection.")
      )
      
    } else if (topic == "glossary") {
      fluidPage(
        h3("Glossary of Terms"),
        tags$ul(
          tags$li(strong("AMOD:"), " Aerosol Mass and Optical Depth device"),
          tags$li(strong("PM2.5:"), " Small particulate matter"),
          tags$li(strong("CEAMS:"), " Citizen-enabled aerosol measurements for satellites, a citizen-science network that measures air quality"),
          tags$li(strong("Filter:"), " Collects mass while still allowing air to pass through"),
          tags$li(strong("Optical:"), " Uses light (specifically, the visible part of the light spectrum)"),
          tags$li(strong("Bluetooth:"), " Short-range wireless interconnection. Often connects mobile phones, computers, and other electronic devices"),
          tags$li(strong("Blank filter:"), " Pre-weighed, unused filter. Used as a comparison to ensure measurements are valid")
        )
      )
      
    } else {
      # Fallback content
      fluidPage(
        h3("Content Not Found"),
        p("The requested troubleshooting topic was not found.")
      )
    }
  })
  
# Query function -- maybe helps with search functionality????
  # observe({
  #   query <- trimws(tolower(input$search))
  #   if (query != "") {
  #     topics <- list(
  #       led_colors = "what do the led light colors mean",
  #       device_not_turning_on = "device will not turn on",
  #       led_light_flashes = "led light flashes",
  #       led_stays_red = "led stays red",
  #       wifi_issue = "wifi issue",
  #       ceams_scan = "ceams scan",
  #       wifi_router_draining = "wifi router draining",
  #       glossary = "glossary"
  #     )
  #     
  #     matched <- names(topics)[sapply(topics, function(x) grepl(query, x, fixed = TRUE))]
  #     
  #     if (length(matched) == 1) {
  #       selected_topic(matched)
  #     } else if (length(matched) > 1) {
  #       showModal(modalDialog(
  #         title = "Search Results",
  #         paste("Multiple topics matched your search:", paste(matched, collapse = ", ")),
  #         easyClose = TRUE,
  #         footer = NULL
  #       ))
  #     } else {
  #       showModal(modalDialog(
  #         title = "No Results",
  #         "No troubleshooting topics matched your search.",
  #         easyClose = TRUE,
  #         footer = NULL
  #       ))
  #     }
  #   } else {
  #     selected_topic("home")
  #   }
  # })
}

# Run the application 
shinyApp(ui = ui, server = server)
