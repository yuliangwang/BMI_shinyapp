library(shiny)
shinyUI(pageWithSidebar(
    headerPanel("Original and New Body Mass Index Calculator"),
    sidebarPanel(
        p('The BMI is defined as the body mass divided by the square of the body height, and is universally expressed in units of kg/m2.'),
        p("In the original formula, the exponent for height is 2, though our world is 3D. You might think that the exponent should simply be 3, but that doesn't match the data at all - people don't scale in a perfectly linear fashion as they grow."),
        p("Prof.Trehfethen from University of Oxford proposes that a better approximation to the actual sizes and shapes of healthy bodies might be given by an exponent of 2.5."),
        p("When you provide your weight (in kilograms) and your height (in centimeters), this shiny app will calculate BMI based on both the original formula and the new formula proposed by Prof.Trehfethen. Then it will tell you whether you are underweight, normal, overweight or obese."),
        textInput(inputId="weight",label="Your weight in kg"),
        textInput(inputId="height",label="Your height in cm"),
        #Don't calculate unless user hit Go! button
        actionButton("goButton", "Go!")
    ),
    mainPanel(
        #An image of BMI chart
        img(src="bmichartcalculator.jpg", height = 300, width = 500),
        p("Above image from squarespace.com"),
        #Display results
        p('You entered weight in kg:'),
        verbatimTextOutput('oweight'),
        p('You entered height in cm:'),
        verbatimTextOutput('oheight'),
        p('Your Body Mass Index based on original formula:'),
        verbatimTextOutput('OriginalBMI'),
        p('Your Body Mass Index based on new formula:'),
        verbatimTextOutput('NewBMI'),
        p('Your BMI classification based on original formula:'),
        verbatimTextOutput('ansOriginal'),
        p('Your BMI classification based on new formula:'),
        verbatimTextOutput('ansNew')
    )
))
