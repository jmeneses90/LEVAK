#-------------------------------------------------------------------------------
#Version 3: Helvetesild testing av AIscreenR
##Changes: I have manually coded all the references in EndNote. The column "human_code" was added.
#-------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#Install libraries and packages
library(writexl)
library(dplyr)
library(synthesisr)
library(AIscreenR)
library(tibble)
library(revtools)
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#Importing the RIS file
references<-read_refs("C:/Users/JOFM/OneDrive - Folkehelseinstituttet/Research projects/FHI/Smittevern/VVP/Helvetesild_testing/Referanser/Helvetesild_testing_original.txt")
View(references)
colnames(references)
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#Rename U2 - human_code
references$U2 #human_code
references<-references%>% 
  rename(human_code = U2)
print(references$human_code) # verify
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#Prompt
prompt<-"Role: You are an expert in systematic reviews within the fields of vaccinology and epidemiology.  
Task: Evaluate whether a given study meets the following inclusion criteria: 
Population: Adults aged 50 years and older, including those previously vaccinated. Participants may have comorbidities or other diagnoses, such as cardiovascular disease or Alzheimer's disease. 
Intervention: Recombinant Zoster Vaccine (RZV), such as Shingrix and HZ/su. 
Control/Comparison: Placebo, no vaccine, or Zoster Vaccine Live (ZVL / Zostavax). 
Study Design: Randomized Controlled Trials (RCTs) and non-randomized studies, including observational studies (retrospective and prospective cohort studies, registry-based studies, and case-control studies). Exclude case studies and case series. 
Evaluation Rule: Does the study meet all the inclusion criteria? Only include the study if every criterion is satisfied."
#------------------------------------------------------------------------------

#-----------------------------------------------------------------------------
#Approximate price

approximate_price_gpt(
  data = references[1:100, ],
  prompt = "Role: You are an expert in systematic reviews within the fields of vaccinology and epidemiology.  
Task: Evaluate whether a given study meets the following inclusion criteria: 
Population: Adults aged 50 years and older, including those previously vaccinated. Participants may have comorbidities or other diagnoses, such as cardiovascular disease or Alzheimer's disease. 
Intervention: Recombinant Zoster Vaccine (RZV), such as Shingrix and HZ/su. 
Control/Comparison: Placebo, no vaccine, or Zoster Vaccine Live (ZVL / Zostavax). 
Study Design: Randomized Controlled Trials (RCTs) and non-randomized studies, including observational studies (retrospective and prospective cohort studies, registry-based studies, and case-control studies). Exclude case studies and case series. 
Evaluation Rule: Does the study meet all the inclusion criteria? Only include the study if every criterion is satisfied. ",
  model = "gpt-4o-mini",
  reps = 1
)
#-----------------------------------------------------------------------------

#------------------------------------------------------------------------------
references_adjusted <- references %>% 
  select(ID, title, abstract, human_code)
  
head(references_adjusted)
view(references_adjusted)
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#Check missing metadata: titles and abstracts
sum(is.na(references_adjusted$title)) # verify missing titles
sum(is.na(references_adjusted$abstract)) # verify missing abstracts
## 1616 without abstracts
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#Set API-key
set_api_key()
get_api_key()
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#Screening
helvetesild_screening_3 <- tabscreen_gpt(
  data = references_adjusted,
  prompt = prompt,
  studyid = ID,
  title = title,
  abstract = abstract,
  model = "gpt-4o-mini",
  reps = 1,
  decision_description = TRUE
)
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#See the results
print(helvetesild_screening_3)
view(helvetesild_screening_3$answer_data)
colnames(helvetesild_screening_3$answer_data)

#How many records are 1.1
view(helvetesild_screening_3$answer_data$decision_gpt) # glimpse of variable

helvetesild_screening_3$answer_data %>%  # to see what values exist in the variable
  count(decision_gpt)
table(helvetesild_screening_3$answer_data$decision_gpt) # table with the counts in the variable

gpt_decisions_row <- helvetesild_screening_3$answer_data %>%
  count(decision_gpt, name = "frequency")

#standardize to 1 and 0 in decision_gpt
helvetesild_screening_3$answer_data$decision_gpt[helvetesild_screening_3$answer_data$decision_gpt != "0"] <- "1"

#verify that the variable decision_gpt is only 1 and 0
helvetesild_screening_3$answer_data %>%  
  count(decision_gpt)
table(helvetesild_screening_3$answer_data$decision_gpt) 

view(helvetesild_screening_3$answer_data) #inspect the whole dataset
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#Analyzing the results / screen_analyzer()
helvetesild_3_analysis<-screen_analyzer(helvetesild_screening_3, human_decision = human_code, key_result = TRUE)
summary(helvetesild_3_analysis)
view(helvetesild_3_analysis)

helvetesild_3_analysis_errors <- screen_errors(
  helvetesild_3_analysis, 
  human_decision = "human_code"  
)
#------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Confusion matrix

confusion_helvetesild3 <- table(
  Human = helvetesild_screening_3$answer_data$human_code,
  AI = helvetesild_screening_3$answer_data$decision_binary
)
print(confusion_helvetesild3)
view(confusion_helvetesild3) # row data of the confusion matrix


confusion_helvetesild3_values <- helvetesild_screening_3$answer_data %>%
  mutate(result_type = case_when(
    human_code == 1 & decision_binary == 1 ~ "True Positive (TP)",
    human_code == 0 & decision_binary == 0 ~ "True Negative (TN)",
    human_code == 0 & decision_binary == 1 ~ "False Positive (FP)",
    human_code == 1 & decision_binary == 0 ~ "False Negative (FN)"
  ))
print(confusion_helvetesild3_values)
view(confusion_helvetesild3_values)
colnames(confusion_helvetesild3_values)


# Plot_confusion matrix
library(ggplot2)

# 1. We count how many of each (TP, TN, etc.) exist to create the plot data
plot_confusion_counts <- confusion_helvetesild3_values %>%
  group_by(human_code, decision_binary, result_type) %>%
  summarise(count = n(), .groups = 'drop')
view(plot_confusion_counts)

# 2. Create the plot

#-------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Saving the analyzed object in R
saveRDS(helvetesild_screening_3, "helvetesild_screening_3.rds")
saveRDS(confusion_helvetesild3_values, "confusion_helvetesild3_values")
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Export to Excel
helvetesild_3_excel<-helvetesild_screening_3$answer_data
writexl::write_xlsx(helvetesild_3_excel, "helvetesild_3_excel.xlsx")

confusion_helvetesild3_excel<-confusion_helvetesild3_values
writexl::write_xlsx(confusion_helvetesild3_excel, "confusion_helvetesild3_excel.xlsx")
#------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
##helvetesild3.1 - Prompten er oppdatert til ?? eksplisitt inkludere Zostavax-studier og kunnskapsoppsummeringer for C% C8ke gjenfinning (recall).
Dato: 12/02/2026#
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
# utvalg av falske negativer i helvetesiltd_3#

FN_helvetesild3<- confusion_helvetesild3_values%>% #ny variabell = FN
  filter(result_type == "False Negative (FN)")

view(FN_helvetesild3)
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#prompt_FN_helvetesild3.1

prompt_FN_helvetesild3.1<-"Role: You are an expert systematic review screener specializing in vaccinology and epidemiology. 
Task: Evaluate whether a study meets the following specific inclusion criteria. 
Population: Adults aged  fifty years or older. Include participants regardless of previous vaccination history, history of herpes zoster, or presence of comorbidities (e.g., cardiovascular disease, Alzheimerb