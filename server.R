library(shiny)


bmi_class_original<-function(weight,height){
    ###This function calculates the Body Mass Index (BMI) based on the original formula and classify
    ###the resulting BMI into underwegith, normal, overweight and obese.
    ###In addition, it will calculate weight gain/loss necessary to achieve target BMI:
    ### 18.5 for those underweight, and 24.99 for whose overweight or obese.
    weight<-as.numeric(weight)
    height<-as.numeric(height)
    bmi<-weight/(height/100)^2
    if(bmi <18.5){ 
        target_weight<- 18.5*(height/100)^2
        weightAns<-paste("You are underweight. You may try to gain ",format(target_weight-weight,digits=2)," kg.",sep="") }
    else if (bmi >=18.5 & bmi<=24.99){
        weightAns<-"You are of normal weight. Stay in shape."}
    else if (bmi >24.99 & bmi<=29.99){
        target_weight<- 24.99*(height/100)^2
        weightAns<-paste("You are overweight. You may try to lose ",format(weight - target_weight,digits=2)," kg.",sep="")}
    else if (bmi >=30){
        target_weight<- 24.99*(height/100)^2
        weightAns<-paste("You are obese. You may try to lose ",format(weight - target_weight,digits=2)," kg.",sep="")}
    bmi_class<-data.frame(bmi=bmi,class=weightAns)        
}

bmi_class_new<-function(weight,height){
    ###This function calculates the Body Mass Index (BMI) based on the nwe formula and classify
    ###the resulting BMI into underwegith, normal, overweight and obese.
    ###In addition, it will calculate weight gain/loss necessary to achieve target BMI:
    ### 18.5 for those underweight, and 24.99 for whose overweight or obese.
        weight<-as.numeric(weight)
        height<-as.numeric(height)
        bmi<-1.3*weight/(height/100)^2.5
        if(bmi <18.5){ 
            target_weight<- 18.5*(height/100)^2.5
            weightAns<-paste("You are underweight. You may try to gain ",format(target_weight-weight,digits=2)," kg.",sep="") }
        else if (bmi >=18.5 & bmi<=24.99){
            weightAns<-"You are of normal weight. Stay in shape."}
        else if (bmi >24.99 & bmi<=29.99){
            target_weight<- 24.99*(height/100)^2.5/1.3
            weightAns<-paste("You are overweight. You may try to lose ",format(weight - target_weight,digits=2)," kg.",sep="")}
        else if (bmi >=30){
            target_weight<- 24.99*(height/100)^2.5/1.3
            weightAns<-paste("You are obese. You may try to lose ",format(weight - target_weight,digits=2)," kg.",sep="")}
        bmi_class<-data.frame(bmi=bmi,class=weightAns)         
}

shinyServer(
    function(input,output) {
        #Display user's input
        output$oweight<-renderPrint({as.numeric(input$weight)})
        output$oheight<-renderPrint({as.numeric(input$height)})
        #Calculate BMI and classification based on original and new formula
        bmi_original<-reactive({
            if(input$goButton){bmi_class_original(input$weight,input$height)}
        })
        bmi_new<-reactive({
            if(input$goButton){bmi_class_new(input$weight,input$height)}
        })
        #Display BMI results
        output$OriginalBMI<-renderPrint({bmi_original()$bmi})
        output$NewBMI<-renderPrint(bmi_new()$bmi)
        output$ansOriginal<-renderPrint(as.character(bmi_original()$class))
        output$ansNew<-renderPrint(as.character(bmi_new()$class))
    }
)
