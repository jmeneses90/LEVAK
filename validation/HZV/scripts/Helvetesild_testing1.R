#------------------------------------------------------------------------------
#Install libraries and packages
if (!require("devtools")) install.packages("devtools")
devtools::install_github("MikkelVembye/AIscreenR")
install.packages("writexl")
library(writexl)
library(dplyr)
library(synthesisr)
library(AIscreenR)
library(tibble)
library(revtools)
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#Importing the RIS file
references<-read_refs("C:/Users/JOFM/OneDrive - Folkehelseinstituttet/Research projects/FHI/Smittevern/VVP/Helvetesild_testing/HZ_justert_testing_v1.txt")
View(references)
references$abstract
summary(references$abstract)
summary(references$title)
summary(references$ID)
colnames(references)

references_clean <- references %>% #cleaning_adjusting ID column name
  mutate(ID = row_number()) %>% 
  select(ID, title, abstract) %>%
  mutate(human_code = 0) %>% 
  
head(references_clean)
view(references_clean)
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#Check missing metadata: titles and abstracts
sum(is.na(references_clean$title)) # verify missing titles
sum(is.na(references_clean$abstract)) # verify missing abstracts
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#Prompt
prompt<-"You are an expert in systematic reviews within the fields of vaccinology and epidemiology. Your task is to evaluate whether studies meet the following inclusion criteria: 
Population: Immunocompetent adults aged 50 years and older. 
Intervention: Recombinant Zoster Vaccine (RZV), specifically Shingrix. 
Comparison/Control: Placebo, no vaccine, or Zoster Vaccine Live (ZVL / Zostavax). 
Study Design: Randomized Controlled Trials (RCTs) or Non-Randomized Studies of Interventions (NRSI / observational studies). 
Evaluation Rule: Does the study meet all the inclusion criteria? Only include the study if every criterion is satisfied."
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#Set API-key
set_api_key()
get_api_key()
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#Approximate price of screening before running the screening
app_obj <- 
  approximate_price_gpt(
    data = references_clean[1:100, ],
    prompt = prompt,
    studyid = references_clean$ID, # indicate the variable with the studyid in the data
    title = references_clean$title, # indicate the variable with the titles in the data
    abstract = references_clean$abstract, # indicate the variable with the abstracts in the data
    model = "gpt-4o-mini",
    rep = 1 
  )
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#Screening
helvetesild_screening_gpt <- tabscreen_gpt(
  data = references_clean,
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
print(helvetesild_screening_gpt)
view(helvetesild_screening_gpt$answer_data)
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Saving the analyzed object in R
saveRDS(helvetesild_screening_gpt, "helvetesild_screening_gpt.rds")
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Export to Excel
helvetesild_gpt_excel<-helvetesild_screening_gpt$answer_data
writexl::write_xlsx(helvetesild_gpt_excel, "helvetesild_gpt_excel.xlsx")
#------------------------------------------------------------------------------







