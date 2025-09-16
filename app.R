library(shiny)

logging_message <- function(message) {
  cat(paste0(rep("-", 20), "LOG: ", message))
  return(NULL)
}

generate_story <- function(noun, verb, adjective, adverb) {
  logging_message("Generating story...")
  glue::glue(
    "
    Once upon a time, there was a {adjective} {noun} who loved to
    {verb} {adverb}. It was the funniest thing ever!
  "
  )
}

ui <- fluidPage(
  titlePanel("Mad Libs Game"),
  sidebarLayout(
    sidebarPanel(
      textInput("noun1", "Enter a noun:", ""),
      textInput("verb", "Enter a verb:", ""),
      textInput("adjective", "Enter an adjective:", ""),
      textInput("adverb", "Enter an adverb:", ""),
      actionButton("submit", "Create Story")
    ),
    mainPanel(
      h3("Your Mad Libs Story:"),
      textOutput("story")
    )
  )
)

server <- function(input, output) {
  story <- eventReactive(input$submit, {
    generate_story(input$noun1, input$verb, input$adjective, input$adverb)
  })
  logging_message("Rendering story...")
  output$story <- renderText({
    story()
  })
}

shinyApp(ui = ui, server = server)
