library(shiny)


bmi_class_original<-function(weight,height){
    ###This function calculates the Body Mass Index (BMI) based on the original formula and classify
    ###the resulting BMI into underwegith, normal, overweight and obese.
    weight<-as.numeric(weight)
    height<-as.numeric(height)
    bmi<-weight/(height/100)^2
    if(bmi <18.5){ weightAns<-"You are underweight" }
    else if (bmi >=18.5 & bmi<=24.99){weightAns<-"You are of normal weight"}
    else if (bmi >24.99 & bmi<=29.99){weightAns<-"You are overweight"}
    else if (bmi >=30){weightAns<-"You are obese"}
    bmi_class<-data.frame(bmi=bmi,class=weightAns)        
}

bmi_class_new<-function(weight,height){
    ###This function calculates the Body Mass Index (BMI) based on the nwe formula and classify
    ###the resulting BMI into underwegith, normal, overweight and obese.
        weight<-as.numeric(weight)
        height<-as.numeric(height)
        bmi<-1.3*weight/(height/100)^2.5
        if(bmi <18.5){ weightAns<-"You are underweight" }
        else if (bmi >=18.5 & bmi<=24.99){weightAns<-"You are of normal weight"}
        else if (bmi >24.99 & bmi<=29.99){weightAns<-"You are overweight"}
        else if (bmi >=30){weightAns<-"You are obese"}
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
