# AIscreenR as a Second Screener in LEVAK: A Proof of Concept Using a Health Technology Assessment of Herpes Zoster Vaccination


Prepared by: Jose F. Meneses-Echávez. Collaborators: Rafael Nozal, Brita
Askeland, Birgitte Klüwer, Anna Hayman R, Ingvild Kirkehei, Kjersti
Rydland Department of Infectious Disease Control and Vaccines, Norwegian
Institute of Public Health, Oslo, Norway Contact: jose.meneses@fhi.no
Date: 07.05.2026

# Key summary

This proof of concept represents the first validation of an AI-assisted
workflow for literature selection within a living evidence map for the
Adult Vaccination Program in Norway, referred to as LEVAK (in Norwegian,
*Levende Evidenskart for Vaksiner*). LEVAK is intended to be an
interactive living evidence hub covering the three vaccines included in
the national program: COVID-19, influenza, and pneumococcal vaccines. It
will also monitor research on attitudes toward vaccination and
interventions for increasing vaccination coverage and influencing public
attitudes toward vaccination.

This report evaluates the R package `AIscreenR` for title and abstract
screening, using a health technology assessment (HTA) of herpes zoster
vaccination (HZV) as a benchmark (Heen et al. 2026). Researchers at the
Department of Infectious Disease Control and Vaccines at the Norwegian
Institute of Public Health conducted the original manual screening of
titles and abstracts. Their screening decisions serve as the reference
standard for this proof of concept evaluation.

The unit of analysis for this validation consisted of 11,445 references
retrieved by the HZV team from the databases included in the HTA (Heen
et al. 2026). We prepared the reference library and developed prompts
based on the selection criteria used in the HTA. To evaluate the
performance of `AIscreenR`, we present a confusion matrix and report
performance metrics, including accuracy and workload savings.

The screening results presented in this report are the product of an
iterative process. An initial screening, referred to as HZV Screening 1,
was conducted using a first draft of the prompt with GPT-4o-mini.
Subsequently, a refined prompt was deployed in both GPT-4o-mini and
GPT-5-mini to compare their performance. Based on the results of this
iteration, we then conducted HZV Screening 2 using both models.

The best screening performance was obtained using GPT-5-mini with the
fine-tuned prompt, as follows:

**Key findings**

`AIscreenR` correctly identified 87% of the references included by the
HZV team. This performance exceeds the 75% threshold recommended in the
literature for implementation within evidence synthesis workflows
(Vembye et al. 2025).

`AIscreenR` reduced the screening workload by nearly 82%. It safely
identified and removed 9,337 references (82% of the total) that had also
been excluded by the HZV team.

The LLMs tend to be over-inclusive, which allows researchers to safely
double-check the data. `AIscreenR` included 1,972 references (17%) that
were ultimately excluded by the HZV team. Consequently, the HZV team
would have only needed to screen 2,079 out of the 11,445 total
references to identify the 123 included studies.

**Conclusion**

`AIscreenR` should currently be utilized to prioritize screening rather
than to replace human review entirely. This tool can safely be used as a
second screener for title and abstract screening in an evidence
synthesis, such as the one conducted by the HZV team. Fine tuning the
prompts is crucial. The recall and specificity values align with the
recommendations of Vembye et al. (Vembye et al. 2025) for a trustworthy
an valid use of `AIscreenR` in evidence synthesis. Further validation
studies will help us better understand the potential of `AIscreenR` in
prioritizing vaccine research.

# Background

## AIscreenR

`AIscreenR` (Vembye et al. 2025) is an R package designed to streamline
the title and abstract screening phase of evidence synthesis by
deploying Large Language Models (LLMs) through the [OpenAI
API](https://openai.com/nb-NO/api/). `AIscreenR` provides a
communication interface between researchers and large language models
(LLMs). Researchers instruct the LLM to assess the eligibility of a
study by using a prompt that mirrors the selection criteria. It is most
commonly used to reduce the immense manual workload of evidence
synthesis, particularly by serving as an efficient “second reviewer”
that can accurately identify and remove irrelevant studies (Vembye et
al. 2025).

`AIscreenR`’s performance was validated in 2025, using as a benchmark
the screening decisions from 22 high-quality systematic reviews with
different levels of complexity (Vembye et al. 2025). `AIscreenR` showed
that the LLM performed on par with, and in some cases even better than,
human reviewers in title and abstract screening (Vembye et al. 2025).
The tool demonstrated high accuracy and reliability, especially when a
“human-in-the-loop” strategy was employed.

# Objective

To evaluate the performance of `AIscreenR` in screening references at
the title and abstract level, using a health technology assessment on
herpes zoster vaccination as the gold-standard comparative benchmark.\

# Methods

This proof-of-concept evaluation is conducted to better understand the
performance of `AIscreenR` in title and abstract selection within
evidence synthesis for vaccine research. We aim to deploy `AIscreenR` as
the screener for relevant vaccine research to be mapped into a living
evidence map (acronym: LEVAK). The methodological framework adheres to
recent guidance presented by Cochrane (Gartlehner et al. 2026).

As detailed in the full HZV report (Heen et al. 2026), an experienced
librarian searched in electronic databases by an experienced librarian.
Pairs of researchers manually and independently screened the studies and
resolved disagreements on inclusion via consensus. The final list of
included and excluded studies was provided by the HZV project leader
(Eli Heen) in a RIS file. The following sections of the document outline
the data cleaning and preparation, as well as the `AIscreenR` pipeline
used to execute the screening.

We constructed a confusion matrix to display the performance of
`AIscreenR` compared to the final screening decisions from the HZV
report (Heen et al. 2026). In evidence synthesis, the confusion matrix
help us in (Ghosh 2022):

- Error Analysis: Identifying misclassification patterns.

- Bias Detection: Understanding the balance between False Negatives (FN)
  and False Positives (FP).

- LLM Selection: Comparing different models based on their screening
  performance.

- Fine-tuning: Evaluating how the LLMs respond to different prompting
  approaches.

The confusion matrix visualizes the following metrics:

• True Positives (TP): The number of references correctly included by
`AIscreenR` (i.e., references also included by the HZV team).

• True Negatives (TN): The number of references correctly excluded by
`AIscreenR` (i.e., references also excluded by the HZV team).

• False Positives (FP): References incorrectly included by `AIscreenR`
(Type I errors), meaning references included by `AIscreenR` but excluded
by the HZV team.

• False Negatives (FN): References incorrectly excluded by `AIscreenR`
(Type II errors).

True negatives (TN) are important for reducing workload, as they
represent the number of references that a review team can avoid
screening by using AIscreenR. In contrast, false negatives (FN)
represent the relevant references that would have been missed without
human verification.

Based on the confusion matrix, we then calculated the following metrics:

• **Recall** (Sensitivity, also known as true positive rate): The
proportion of truly relevant studies correctly included by `AIscreenR`.
Recall is the most critical metric; a target of \>90% ensures that study
selection in LEVAK is safe and does not miss critical new evidence.

• **Specificity** (true negative rate): The proportion of truly
irrelevant studies correctly excluded by `AIscreenR`. High specificity
help researchers stay focused on relevant studies. If specificity is
low, researchers will have to manually screen too many irrelevant papers
(False Positives).

## Data requirements

For the `AIscreenR` screening functions to operate successfully, the
dataset must contain at least three specific variables: a unique
identifier for each record (e.g., `studyid`), the article `title`, and
the `abstract`.

It is also highly recommended to include a `human_code` variable
containing previous screening decisions (0 for excluded, 1 for included)
in order to validate the AI’s performance.

## Data quality

Before the screening phase, users must ensure data quality by filtering
out records with missing abstracts and resolving any character encoding
issues that could interfere with the API’s token processing in
`AIscreenR`.

In many academic workflows, the search results will most likely be saved
in an EndNote library before being brought into R. To facilitate the
import, users should export their EndNote library as an XML or RIS file,
as these formats are the most stable for preserving the relationship
between titles and abstracts.

Once exported, the `synthesisr::read_refs()` function can parse these
files directly, maintaining the metadata structure required for the
screening process. This function belongs to the
[`synthesisr`](https://cran.r-project.org/web/packages/synthesisr/vignettes/synthesisr_vignette.html)
package, which is a specialized tool for importing, exporting, and
manipulating bibliographic data in R.

## HZV use case

On 30 January 2026, the research librarian (Marita Heintz) provided the
literature search results in a RIS file (.ris) format. The results of
the title and abstract screening for the original Herpes Zoster vaccine
HTA were not available. Instead, Eli Heeen and Lene Juvet provided Jose
Meneses with the final list of included studies and those excluded at
the full-text stage.

To reconstruct the dataset for validation, Jose Meneses manually coded
these references in EndNote to establish the following classifications:

- **Title and Abstract Screening (TA)**

  - Included references (`Included_TA`)

  - Excluded references (`Excluded_TA`)

- **Full-Text Screening (FT)**

  - Included references (`Included_FT`)

  - Excluded references (`Excluded_FT`)

After manually coding the `Included_TA` references in EndNote, we
reconstructed the `Excluded_TA` set by subtracting the `Included_TA`
references from the complete library of references. To replicate this in
EndNote, follow these steps:

1.  Navigate to **Groups** \> **Create From Groups**.

2.  Name the new group (e.g., `Excluded_TA`).

3.  Under “Include References in,” select the **All References** group.

4.  Set the operator to **NOT** and select the `Included_TA` group in
    the dropdown.

5.  Click **Create**.

### Human_code variable

The `human_code` variable allows us to validate `AIscreenR` ’s
performance, as it contains the screening decisions made by the HZV team
(i.e., the human reviewers).

We manually created a new field in EndNote to assign human assessments
to each reference. This `human_code` variable must be 0 for
`Excluded_TA` and 1 for `Included_TA`. To add this variable to each
reference in our RIS file, we must first create the custom field in
EndNote using the following steps:

#### Step 1: Create the Field in Your References

To make a tag “global,” you must first ensure the field exists within
your database records.

1.  Go to **Edit \> Preferences** (Windows) **\>** Select **Reference
    Types** from the menu **\> Modify Reference Types**.

2.  Find one of the empty columns (such as `Custom 1`) and type the name
    you want (e.g., *human_code*).

3.  Click **OK**. All your references will now have this new field
    available.

#### Step 2: Bulk Fill the Field

If you want this field (tag) to appear across all existing references
without typing them one by one:

1.  Select all your references (**Ctrl+A**).

2.  Go to the **Library** menu \> **Change/Move/Copy Fields**.

3.  In the **Change Fields** tab, select the field you just named (e.g.,
    *Custom 1*).

4.  Choose the option **Replace whole field with:** and type the text
    you want to appear (e.g, 1 for `Included_TA`).

5.  Press **OK**.

6.  Repeat these steps for the `Excluded_TA`.

#### Step 3: Configure the RIS Export Format

EndNote does not export custom fields by default. You must instruct it
to associate your new field with a RIS tag (such as `U1`).

1.  Go to **Edit \> Output Styles \> Edit “RefMan (RIS) Export”**.

2.  In the menu on the left, click on **Templates**.

3.  Locate the reference type you use most (e.g., *Journal Article*).

4.  You will see a list of tags like `AU  - Author`. Go to the end of
    the list and manually add:

    - Type `U1  -` and then click the **Insert Field** button to select
      your custom field (e.g., *Custom 1*).

5.  **Save your changes:** Go to **File \> Save As** and give it a name
    like `Custom RIS Export`.

#### Step 4: Exporting the edited RIS file

Ensure that when you clicked **File \> Export** in EndNote, you actually
select the new “`Custom RIS Export`” style, rather than the default
“RefMan (RIS) Export, to ensure the `U1` field is included in the final
file.

### Adjustment to references (optional)

We restricted the database to the variables required by `AIscreenR`: ID,
title, abstract, and `human_code`. The `human_code` variable is
essential only when human screening results are available, as it enables
a direct comparison between `AIScreenR`’s performance and the decisions
made by human reviewers.

## AIscreenR workflow

The following is a step-by-step description of the workflow:

### Package and Data upload

It is practical to centralize all packages and functions used for the
evaluation and reporting into a dedicated code chunk.

``` r
#install.packages("rsconnect")
library(rsconnect)

# Load packages and libraries
library(AIscreenR)
library(writexl)
library(dplyr)
library(synthesisr)
library(tibble)
library(revtools)
library(flextable)
library(tinytex)
library(tidyr)
library(ggplot2)
library(gt)
library(webshot2)
library(packrat)
library(rsconnect)
library(chromote)
library(readxl)
library(future)
library(openxlsx)
library(languageserver)

devtools::install_github("MikkelVembye/AIscreenR") # most recent pakcage updates
```

### Set API Key

`AIscreenR` uses an API key to connect to a Large Language Model (LLM),
in this case, the OpenAI API to connect to ChatGPT. After obtaining your
API key (which is private and confidential), you can save it using the
following code:

``` r
# usethis::edit_r_environ() # Run this code to open your .Renviron file and  write CHATGPT_KEY=your_key. Thereafter, close and save the .Renviron file and restart RStudio (ctrl + shift + F10). From now on, the AIscreenR functions will automatically use get_api_key() to retrieve your API key from your R environment. 

get_api_key() # To check the API Key was saved successfully.
```

### Importing the dataset

To import references for `AIscreenR`, you typically utilize the
`synthesisr` or `revtools` packages to convert standard bibliographic
files—such as .ris, .bib, or .txt—into an R-compatible data frame. The
process begins by reading the raw file into R, which generates a table
where each row represents a unique study (Vembye et al. 2025).

We import the references that will be screened by `AIscreenR`.

``` r
HZV_references<-read_excel("validation/HZV/data/HZV_References.xlsx")
# references read. This is the main file from the search results and coded with the screenign decision from the content experts.

# In case you want to restrict the dataframe only to the variables required by AIscreenR: 
# HZV_references <- HZV_references %>% 
#   select(ID, human_code, title, abstract, studyid)

# saving the file in the data folder
saveRDS(HZV_references, "validation/HZV/data/HZV_references.rds")
```

### Missing titles check

Missing titles: Use the following code to ensure no references are
missing a title.

``` r
sum(is.na(HZV_references$title)) # 0 - All the references have a title (No titles missing).
```

    [1] 0

### Missing abstract check

The abstract is the primary source of information used by the LLM to
determine whether a study meets the inclusion criteria. `AIscreenR`,
independent of the specific GPT model employed, tends to exclude
references by default when information is insufficient (e.g., when the
abstract is missing). Therefore, relevant studies without abstracts may
result in False Negatives (key evidence is omitted from the synthesis).

Furthermore, the validation metrics for `AIscreenR` assume the LLM has
access to the same data as a human reviewer. Empty abstract fields
artificially lower the performance scores, leading to biased conclusions
regarding the tool’s validation.

The abstracts in the database show “No information” instead of “NA”. Use
this code to standardize the missing values to “NA”:

``` r
# Verify the "No information" items.
sum(HZV_references$abstract == "No information", na.rm = TRUE) # 1616 abstracts are missing
```

    [1] 1616

``` r
# Convert "No information" to a real "NA".
# HZV_references$abstract[HZV_references$abstract == "No information"] <- NA
```

We can check the number of missing abstracts now:

``` r
sum(is.na(HZV_references$abstract)) # check missing abstracts = 0 
```

    [1] 0

Abstracts are missing for 1,616 references, representing 14% of the
11,445 total entries in the EndNote library.

# **HZV screening 1**

This is our first, exploratory screening.

**Date**: 25/February/2026. Screening run at NIPH in Oslo, Norway.

### Prompt (HZV screening 1)

The prompt is the set of instructions that the LLM follows to determine
the relevance of each study. It must mirror the selection criteria,
defining the key inclusion and exclusion criteria as clearly as
possible. To ensure high accuracy, the prompt should be detailed and
thorough.

You can draft the prompt in either R or Word before integrating it into
the pipeline.

``` r
HZV_prompt1 <- "Role: You are an expert systematic review screener specializing in vaccinology and epidemiology. 
# Task: Evaluate whether a study meets the following specific inclusion criteria. 
# Population: Adults aged fifty years or older. Include participants regardless of previous vaccination history, history of herpes zoster, or presence of comorbidities (e.g., cardiovascular disease, Alzheimer’s). 
# Intervention: Recombinant Zoster Vaccine (RZV) (e.g., Shingrix, HZ/su) or Zoster Vaccine Live (ZVL) (e.g., Zostavax). 
# Comparison/Control: Placebo, no vaccine, or an alternative vaccine (including head-to-head comparisons between RZV and ZVL). 
# Study Design: Included: RCTs, non-randomized studies, observational studies (prospective/retrospective cohort, registry-based, quasi-experimental, case-control, nested case-control), and post-marketing safety evaluations. 
# Secondary Research: Include systematic reviews, meta-analyses, and literature reviews. 
# Excluded: Case studies and case series. 
# Evaluation Rule: Does the study meet all the inclusion criteria? Only include the study if every criterion is satisfied."

# saving the prompt in the corresponding folder
writeLines(HZV_prompt1, "validation/HZV/prompts/HZV_prompt1")
```

### Screening command

``` r
#HZV_screening <- tabscreen_gpt(
  #data = HZV_references,
  #prompt = HZV_prompt1,
  #studyid = ID,
  #title = title,
  #abstract = abstract,
  #model = "gpt-4o-mini",
  #reps = 1,
  #decision_description = TRUE
#)
```

# Results (HZV screening 1)

### Exploring the screening results

Print the results of the screening done by `AIscreenR`. Check the
following variables:

- **decision_gpt:** the raw gpt decision - either “1”, “0”, “1.1” for
  inclusion, exclusion, or uncertainty.

- **detailed_description:** the detailed description of the given
  decision made by OpenAI’s GPT API models.

- **decision_binary:** the binary gpt decision, that is 1 for inclusion
  and 0 for exclusion.

``` r
HZV_screening <- readRDS("validation/HZV/outputs/HZV_screening.rds") # load the screening results

# Preview of the screening results data.
view(HZV_screening$answer_data) # inspect the data

# Distribution of LLM-generated screening decisions
HZV_screening$answer_data %>%  
  count(decision_binary)

#Saving the screening results file
saveRDS(HZV_screening, "validation/HZV/outputs/HZV_screening.rds")
```

`AIscreenR` excluded 10,227 references and included 1,214.

We found that *four* references were marked as ‘NA’ by the software. We
checked these manually and reclassified them as excluded (0) as they are
not deemed relevant to the study.

``` r
#Assign 0 to the references with NA (n=4)
HZV_screening$answer_data$decision_binary[is.na(HZV_screening$answer_data$decision_binary)]<-0

#Check
HZV_screening$answer_data %>%  
  count(decision_binary)
```

After cleaning the data, `AIscreenR` excluded 10,231 references and
included 1,214 references.

1.  

``` r
# Data wrangling_row data (first table)
HZV_screening_rawtable <- HZV_screening$answer_data %>%
  count(decision_binary) %>%
  mutate(
    Decision = if_else(decision_binary == 1, "Included", "Excluded"),
    Percentage = n / sum(n)
  ) %>%
  select(Decision, n, Percentage)
view(HZV_screening_rawtable)

# Saving the object in R and also as Excel
saveRDS(HZV_screening_rawtable, "validation/HZV/outputs/HZV_screening_rawtable.rds")
writexl::write_xlsx(HZV_screening_rawtable, "validation/HZV/outputs/HZV_screening_rawtable.xlsx")
```

<div id="tbl-HZV-screening-rawtable">

Table 1: AIscreenR screening results

<div class="cell-output-display">

<div id="vfxcyvqvlj" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#vfxcyvqvlj table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#vfxcyvqvlj thead, #vfxcyvqvlj tbody, #vfxcyvqvlj tfoot, #vfxcyvqvlj tr, #vfxcyvqvlj td, #vfxcyvqvlj th {
  border-style: none;
}
&#10;#vfxcyvqvlj p {
  margin: 0;
  padding: 0;
}
&#10;#vfxcyvqvlj .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #004D80;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #004D80;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#vfxcyvqvlj .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#vfxcyvqvlj .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#vfxcyvqvlj .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#vfxcyvqvlj .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#vfxcyvqvlj .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
}
&#10;#vfxcyvqvlj .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #0076BA;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#vfxcyvqvlj .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#vfxcyvqvlj .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#vfxcyvqvlj .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#vfxcyvqvlj .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#vfxcyvqvlj .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#vfxcyvqvlj .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#vfxcyvqvlj .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #0076BA;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#vfxcyvqvlj .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #0076BA;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
  vertical-align: middle;
}
&#10;#vfxcyvqvlj .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#vfxcyvqvlj .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#vfxcyvqvlj .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: none;
  border-top-width: 1px;
  border-top-color: #89D3FE;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #89D3FE;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #89D3FE;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#vfxcyvqvlj .gt_stub {
  color: #FFFFFF;
  background-color: #0076BA;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #0076BA;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#vfxcyvqvlj .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#vfxcyvqvlj .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#vfxcyvqvlj .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#vfxcyvqvlj .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#vfxcyvqvlj .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #0076BA;
}
&#10;#vfxcyvqvlj .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#vfxcyvqvlj .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
}
&#10;#vfxcyvqvlj .gt_grand_summary_row {
  color: #333333;
  background-color: #89D3FE;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#vfxcyvqvlj .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #0076BA;
}
&#10;#vfxcyvqvlj .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #0076BA;
}
&#10;#vfxcyvqvlj .gt_striped {
  background-color: #F4F4F4;
}
&#10;#vfxcyvqvlj .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #0076BA;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
}
&#10;#vfxcyvqvlj .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#vfxcyvqvlj .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#vfxcyvqvlj .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#vfxcyvqvlj .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#vfxcyvqvlj .gt_left {
  text-align: left;
}
&#10;#vfxcyvqvlj .gt_center {
  text-align: center;
}
&#10;#vfxcyvqvlj .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#vfxcyvqvlj .gt_font_normal {
  font-weight: normal;
}
&#10;#vfxcyvqvlj .gt_font_bold {
  font-weight: bold;
}
&#10;#vfxcyvqvlj .gt_font_italic {
  font-style: italic;
}
&#10;#vfxcyvqvlj .gt_super {
  font-size: 65%;
}
&#10;#vfxcyvqvlj .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#vfxcyvqvlj .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#vfxcyvqvlj .gt_indent_1 {
  text-indent: 5px;
}
&#10;#vfxcyvqvlj .gt_indent_2 {
  text-indent: 10px;
}
&#10;#vfxcyvqvlj .gt_indent_3 {
  text-indent: 15px;
}
&#10;#vfxcyvqvlj .gt_indent_4 {
  text-indent: 20px;
}
&#10;#vfxcyvqvlj .gt_indent_5 {
  text-indent: 25px;
}
&#10;#vfxcyvqvlj .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}
&#10;#vfxcyvqvlj div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>

<table class="gt_table cell" data-quarto-postprocess="true"
data-quarto-disable-processing="false" data-quarto-bootstrap="false">
<thead>
<tr class="gt_heading">
<th colspan="3" class="gt_heading gt_title gt_font_normal">AIScreenR
screening results</th>
</tr>
<tr class="gt_heading">
<th colspan="3"
class="gt_heading gt_subtitle gt_font_normal gt_bottom_border">Distribution
of AIScreenR Screening Results</th>
</tr>
<tr class="gt_col_headings">
<th id="Decision"
class="gt_col_heading gt_columns_bottom_border gt_left"
data-quarto-table-cell-role="th" scope="col">Decision</th>
<th id="n" class="gt_col_heading gt_columns_bottom_border gt_right"
data-quarto-table-cell-role="th" scope="col">Frequency (n)</th>
<th id="Percentage"
class="gt_col_heading gt_columns_bottom_border gt_right"
data-quarto-table-cell-role="th" scope="col">Percentage (%)</th>
</tr>
</thead>
<tbody class="gt_table_body">
<tr>
<td class="gt_row gt_left" headers="Decision">Excluded</td>
<td class="gt_row gt_right" headers="n">10231</td>
<td class="gt_row gt_right" headers="Percentage">89.4%</td>
</tr>
<tr>
<td class="gt_row gt_left gt_striped" headers="Decision">Included</td>
<td class="gt_row gt_right gt_striped" headers="n">1214</td>
<td class="gt_row gt_right gt_striped" headers="Percentage">10.6%</td>
</tr>
</tbody><tfoot>
<tr class="gt_sourcenotes">
<td colspan="3" class="gt_sourcenote">Note: Four references returned an
error in AIScreenR; these were manually reviewed and categorized as
excluded</td>
</tr>
</tfoot>
&#10;</table>

</div>

</div>

</div>

Now that the data are clean with unique values of either included and
excluded by `AIscreenR`, we can proceed to the analysis.

## Analyzing the results

`AIscreenR` (and other AI tools) is seen as a diagnostic tool, detecting
relevant references for the review question and excluding irrelevant
ones. There are two primary entries: the binary inclusion/exclusion
decisions made by the HZV team (human reviewers) and those made by
`AIscreenR`. This comparison results in a 2x2 table, which we refer to
as a ‘Confusion Matrix’ (Ghosh 2022).

### Confusion matrix

To prepare the key metrics for the confusion matrix, we retrieve the raw
data (the distribution of decisions made by both `AIscreenR` and
humans), organize these into a data frame, and then generate the
confusion matrix table.

1.  Retrieve and prepare the raw data.

``` r
# Preparing the raw data for the metrics:
HZV_confusion <- table(
  Human = HZV_screening$answer_data$human_code,
  AI = HZV_screening$answer_data$decision_binary
)
```

2.  Organize the data in a data frame.

``` r
# Converting the raw data of the confusion matrix to a data frame (mandatory step in dplyr)
HZV_confusion_df <- as.data.frame(HZV_confusion)
colnames(HZV_confusion_df) <- c("human_code", "decision_binary", "n")

HZV_confusion_final <- HZV_confusion_df %>% # using the dataframe (df)
  mutate(
    Human = if_else(human_code == 1, "Included", "Excluded"),
    AIscreenR = if_else(decision_binary == 1, "Included", "Excluded")
  ) %>%
    pivot_wider(id_cols = Human, names_from = AIscreenR, values_from = n)
```

3.  Plotting the confusion matrix table.

The evaluation of the HZV screening process (n = 11,445 references from
the searches) is shown in
<a href="#tbl-confusion-matrix" class="quarto-xref">Table 2</a>.

<div id="tbl-confusion-matrix">

Table 2: Confusion matrix AIscreenR vs HZV team

<div class="cell-output-display">

<div id="bjjypiszne" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#bjjypiszne table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#bjjypiszne thead, #bjjypiszne tbody, #bjjypiszne tfoot, #bjjypiszne tr, #bjjypiszne td, #bjjypiszne th {
  border-style: none;
}
&#10;#bjjypiszne p {
  margin: 0;
  padding: 0;
}
&#10;#bjjypiszne .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #004D80;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #004D80;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#bjjypiszne .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#bjjypiszne .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#bjjypiszne .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#bjjypiszne .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#bjjypiszne .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
}
&#10;#bjjypiszne .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #0076BA;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#bjjypiszne .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#bjjypiszne .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#bjjypiszne .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#bjjypiszne .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#bjjypiszne .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#bjjypiszne .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#bjjypiszne .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #0076BA;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#bjjypiszne .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #0076BA;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
  vertical-align: middle;
}
&#10;#bjjypiszne .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#bjjypiszne .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#bjjypiszne .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: none;
  border-top-width: 1px;
  border-top-color: #89D3FE;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #89D3FE;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #89D3FE;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#bjjypiszne .gt_stub {
  color: #FFFFFF;
  background-color: #0076BA;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #0076BA;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#bjjypiszne .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#bjjypiszne .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#bjjypiszne .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#bjjypiszne .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#bjjypiszne .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #0076BA;
}
&#10;#bjjypiszne .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#bjjypiszne .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
}
&#10;#bjjypiszne .gt_grand_summary_row {
  color: #333333;
  background-color: #89D3FE;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#bjjypiszne .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #0076BA;
}
&#10;#bjjypiszne .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #0076BA;
}
&#10;#bjjypiszne .gt_striped {
  background-color: #F4F4F4;
}
&#10;#bjjypiszne .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #0076BA;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
}
&#10;#bjjypiszne .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#bjjypiszne .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#bjjypiszne .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#bjjypiszne .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#bjjypiszne .gt_left {
  text-align: left;
}
&#10;#bjjypiszne .gt_center {
  text-align: center;
}
&#10;#bjjypiszne .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#bjjypiszne .gt_font_normal {
  font-weight: normal;
}
&#10;#bjjypiszne .gt_font_bold {
  font-weight: bold;
}
&#10;#bjjypiszne .gt_font_italic {
  font-style: italic;
}
&#10;#bjjypiszne .gt_super {
  font-size: 65%;
}
&#10;#bjjypiszne .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#bjjypiszne .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#bjjypiszne .gt_indent_1 {
  text-indent: 5px;
}
&#10;#bjjypiszne .gt_indent_2 {
  text-indent: 10px;
}
&#10;#bjjypiszne .gt_indent_3 {
  text-indent: 15px;
}
&#10;#bjjypiszne .gt_indent_4 {
  text-indent: 20px;
}
&#10;#bjjypiszne .gt_indent_5 {
  text-indent: 25px;
}
&#10;#bjjypiszne .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}
&#10;#bjjypiszne div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>

<table class="gt_table cell" data-quarto-postprocess="true"
data-quarto-disable-processing="false" data-quarto-bootstrap="false">
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr class="gt_heading">
<th colspan="3" class="gt_heading gt_title gt_font_normal">Confusion
matrix AIscreenR vs HZV team</th>
</tr>
<tr class="gt_heading">
<th colspan="3"
class="gt_heading gt_subtitle gt_font_normal gt_bottom_border">Performance
analysis in study selection</th>
</tr>
<tr class="gt_col_headings gt_spanner_row">
<th rowspan="2" id="a::stub"
class="gt_col_heading gt_columns_bottom_border gt_left"
data-quarto-table-cell-role="th" scope="col">Human reviewers</th>
<th colspan="2" id="AIscreenR"
class="gt_center gt_columns_top_border gt_column_spanner_outer"
data-quarto-table-cell-role="th" scope="colgroup"><div
class="gt_column_spanner">
AIscreenR
</div></th>
</tr>
<tr class="gt_col_headings">
<th id="Included"
class="gt_col_heading gt_columns_bottom_border gt_right"
data-quarto-table-cell-role="th" scope="col">Included</th>
<th id="Excluded"
class="gt_col_heading gt_columns_bottom_border gt_right"
data-quarto-table-cell-role="th" scope="col">Excluded</th>
</tr>
</thead>
<tbody class="gt_table_body">
<tr>
<td id="stub_1_1" class="gt_row gt_center gt_stub"
data-quarto-table-cell-role="th" scope="row">Included</td>
<td class="gt_row gt_right" headers="stub_1_1 Included">75</td>
<td class="gt_row gt_right" headers="stub_1_1 Excluded">48</td>
</tr>
<tr>
<td id="stub_1_2" class="gt_row gt_center gt_stub"
data-quarto-table-cell-role="th" scope="row">Excluded</td>
<td class="gt_row gt_right gt_striped"
headers="stub_1_2 Included">1138</td>
<td class="gt_row gt_right gt_striped"
headers="stub_1_2 Excluded">10171</td>
</tr>
<tr>
<td id="grand_summary_stub_1"
class="gt_row gt_left gt_stub gt_grand_summary_row gt_first_grand_summary_row gt_last_summary_row"
data-quarto-table-cell-role="th" scope="row">Total</td>
<td
class="gt_row gt_right gt_grand_summary_row gt_first_grand_summary_row gt_last_summary_row"
headers="grand_summary_stub_1 Included">1,213</td>
<td
class="gt_row gt_right gt_grand_summary_row gt_first_grand_summary_row gt_last_summary_row"
headers="grand_summary_stub_1 Excluded">10,219</td>
</tr>
</tbody>
</table>

</div>

</div>

</div>

Interpreting the results (`AIscreenR` using gpt-4o-mini):

- **True Negatives (TN)=** 10,171 references (88.9%) were correctly
  excluded by both the HZV team and `AIscreenR`. In other words,
  `AIscreenR` safely removed 89% of the irrelevant records.

- **False Negatives (FN) =** 48 references (0.4%) included by the HZV
  team but missed by `AIscreenR`.

- **True Positives (TP) =** 75 references. These are the relevant
  studies correctly identified by both HZV team and `AIscreenR`.

- **False Positives (FP) =** 1,138 references were included by
  `AIscreenR` but excluded by the HZV team. This represents the
  *“residual manual workload”* (i.e., the 1,138 papers the review team
  still needs to check manually to ensure they are truly irrelevant).

### Key performance metrics

Based on the key performance metrics in the confusion matrix, we can now
estimate the accuracy and the recall.

#### Recall (Sensitivity)

Recall represents the proportion of truly relevant references that were
correctly identified and included by `AIscreenR`. This is critical
metric as it measures the `AIscreenR`’s ability to find “all the needles
in the haystack.” A high recall ensures that no relevant studies are
missed during the screening process.

#### Accuracy

Accuracy is the proportion of all decisions made by `AIscreenR` (both
inclusions and exclusions) that were correct. While informative,
accuracy can sometimes be misleading in systematic reviews if the number
of irrelevant papers vastly outweighs the relevant ones (class
imbalance).

The `screen_analyzer` function in `AIscreenR` calculates both recall and
accuracy <a href="#tbl-HZV-performance" class="quarto-xref">Table 3</a>.

<div id="tbl-HZV-performance">

Table 3: Performance metrics of AIscreenR results

<div class="cell-output-display">

<div id="dkrtqmurmx" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#dkrtqmurmx table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#dkrtqmurmx thead, #dkrtqmurmx tbody, #dkrtqmurmx tfoot, #dkrtqmurmx tr, #dkrtqmurmx td, #dkrtqmurmx th {
  border-style: none;
}
&#10;#dkrtqmurmx p {
  margin: 0;
  padding: 0;
}
&#10;#dkrtqmurmx .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: 80%;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #5F5F5F;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #5F5F5F;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#dkrtqmurmx .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#dkrtqmurmx .gt_title {
  color: #FFFFFF;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#dkrtqmurmx .gt_subtitle {
  color: #FFFFFF;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#dkrtqmurmx .gt_heading {
  background-color: #2C3E50;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#dkrtqmurmx .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #5F5F5F;
}
&#10;#dkrtqmurmx .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #5F5F5F;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #5F5F5F;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#dkrtqmurmx .gt_col_heading {
  color: #FFFFFF;
  background-color: #5F5F5F;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#dkrtqmurmx .gt_column_spanner_outer {
  color: #FFFFFF;
  background-color: #5F5F5F;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#dkrtqmurmx .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#dkrtqmurmx .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#dkrtqmurmx .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #5F5F5F;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#dkrtqmurmx .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#dkrtqmurmx .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #5F5F5F;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #5F5F5F;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#dkrtqmurmx .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #5F5F5F;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #5F5F5F;
  vertical-align: middle;
}
&#10;#dkrtqmurmx .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#dkrtqmurmx .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#dkrtqmurmx .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: none;
  border-top-width: 1px;
  border-top-color: #D5D5D5;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D5D5D5;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D5D5D5;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#dkrtqmurmx .gt_stub {
  color: #333333;
  background-color: #D5D5D5;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D5D5D5;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#dkrtqmurmx .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#dkrtqmurmx .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#dkrtqmurmx .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#dkrtqmurmx .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#dkrtqmurmx .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #5F5F5F;
}
&#10;#dkrtqmurmx .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#dkrtqmurmx .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #5F5F5F;
}
&#10;#dkrtqmurmx .gt_grand_summary_row {
  color: #333333;
  background-color: #D5D5D5;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#dkrtqmurmx .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #5F5F5F;
}
&#10;#dkrtqmurmx .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #5F5F5F;
}
&#10;#dkrtqmurmx .gt_striped {
  background-color: #F4F4F4;
}
&#10;#dkrtqmurmx .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #5F5F5F;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #5F5F5F;
}
&#10;#dkrtqmurmx .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#dkrtqmurmx .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#dkrtqmurmx .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#dkrtqmurmx .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#dkrtqmurmx .gt_left {
  text-align: left;
}
&#10;#dkrtqmurmx .gt_center {
  text-align: center;
}
&#10;#dkrtqmurmx .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#dkrtqmurmx .gt_font_normal {
  font-weight: normal;
}
&#10;#dkrtqmurmx .gt_font_bold {
  font-weight: bold;
}
&#10;#dkrtqmurmx .gt_font_italic {
  font-style: italic;
}
&#10;#dkrtqmurmx .gt_super {
  font-size: 65%;
}
&#10;#dkrtqmurmx .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#dkrtqmurmx .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#dkrtqmurmx .gt_indent_1 {
  text-indent: 5px;
}
&#10;#dkrtqmurmx .gt_indent_2 {
  text-indent: 10px;
}
&#10;#dkrtqmurmx .gt_indent_3 {
  text-indent: 15px;
}
&#10;#dkrtqmurmx .gt_indent_4 {
  text-indent: 20px;
}
&#10;#dkrtqmurmx .gt_indent_5 {
  text-indent: 25px;
}
&#10;#dkrtqmurmx .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}
&#10;#dkrtqmurmx div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>

<table class="gt_table cell" data-quarto-postprocess="true"
data-quarto-disable-processing="false" data-quarto-bootstrap="false">
<thead>
<tr class="gt_heading">
<th colspan="3" class="gt_heading gt_title gt_font_normal">Performance
metrics of AIscreenR results</th>
</tr>
<tr class="gt_heading">
<th colspan="3"
class="gt_heading gt_subtitle gt_font_normal gt_bottom_border">Comparative
performance of AIscreenR in screening references at the title and
abstract level on herpes zoster vaccination as the gold-standard
comparative benchmark</th>
</tr>
<tr class="gt_col_headings">
<th id="model" class="gt_col_heading gt_columns_bottom_border gt_left"
data-quarto-table-cell-role="th" scope="col">gpt-4o-mini</th>
<th id="recall" class="gt_col_heading gt_columns_bottom_border gt_right"
data-quarto-table-cell-role="th" scope="col">Recall (Sensitivity)</th>
<th id="specificity"
class="gt_col_heading gt_columns_bottom_border gt_right"
data-quarto-table-cell-role="th" scope="col">Specificity</th>
</tr>
</thead>
<tbody class="gt_table_body">
<tr>
<td class="gt_row gt_left" headers="model">gpt-4o-mini</td>
<td class="gt_row gt_right" headers="recall">61.0%</td>
<td class="gt_row gt_right" headers="specificity">89.9%</td>
</tr>
</tbody>
</table>

</div>

</div>

</div>

#### Specificity

Specificity measures the proportion of truly irrelevant references that
were correctly excluded by `AIscreenR`. Unlike Recall that focuses on
finding what is relevant, Specificity focuses on accurately “clearing
out” the noise. High specificity reduces the number of irrelevant
references that researchers must manually double-check.

#### Workload Savings

Workload savings quantifies the efficiency gain provided by `AIscreenR`,
expressed as the percentage of the total references that the review team
no longer needs to screen manually because `AIscreenR` correctly
excluded. This metric directly reflects the time and resource reduction
achieved by implementing `AIscreenR`.

<a href="#tbl-keymetrics" class="quarto-xref">Table 4</a> presents the
key performance metrics of `AIscreenR` in screening the studies compared
to the HZV team.

<div id="tbl-keymetrics">

Table 4: Key performance metrics in screening of AIScreenR vs HZV team

| Performance metric | Value | Interpretation |
|----|----|----|
| Recall (Sensitivity) | 61.0% | The most vital metric for quality. It shows that `AIscreenR` captured 61% of the relevant references. The remaining 39% (the 48 False Negatives) were missed. |
| Accuracy | 89.5% | The overall proportion of correct decisions (both inclusions and exclusions) made by `AIscreenR`. While high, accuracy can be misleading in imbalanced datasets. |
| Specificity | 89.9% | The ability of `AIscreenR` to correctly identify and discard irrelevant studies. A 90% specificity is excellent for significantly narrowing down a large library. |
| Workload savings | 89.4% | The “Efficiency Gain.” It measures the percentage of the total library that the HZV team was able to skip screening entirely thanks to `AIscreenR.` |

</div>

NOTE: The LEVAK team will soon add the results of the screening
performance analysis from the screen_analyzer function in `AIscreenR`.

# Conclusions (HZV screening 1)

- `AIscreenR` should be used to prioritize screening rather than
  replacing human review entirely.

- `AIscreenR` identified 61% of the references included by the HZV team,
  meaning it overlooked 48 relevant studies. This recall should be
  higher (at least 75% before full implementation in evidence synthesis
  workflows).

- `AIscreenR` resulted in a workload reduction of nearly 90% during the
  tittle and abstract screening of the 11,445 references retrieved from
  the databases.

- The HZV team could have safely excluded 90% of the total references by
  using `AIscreenR`.

# False Negative Analysis

To address the low recall observed in the initial `AIscreenR` screening,
we must analyze the False Negatives (FNs) to identify potential
improvements for the prompt. The FNs are those relevant studies that
`AIscreenR` excluded but the humans had included.

A refined prompt should, in theory, improve `AIscreenR`’s recall by
providing the LLM with clearer inclusion and exclusion boundaries.

## Select the False Negatives

The unit of analysis at this stage consists of all False Negatives
identified in the screening confusion matrix. We must create a dedicated
variable containing these FNs to systematically inspect the exclusion
reasons provided by `AIscreenR`
<a href="#tbl-confusion-matrix" class="quarto-xref">Table 2</a>.

``` r
# Create the groups in the confusion matrix: TP, TN, FN, FP
HZV_screening_excel <- read_excel("validation/HZV/outputs/HZV_screening_excel.xlsx")

HZV_confusion<- HZV_screening_excel%>%  # new object
  mutate(result_type = case_when(
    human_code == 1 & decision_binary == 1 ~ "True Positive (TP)",
    human_code == 0 & decision_binary == 0 ~ "True Negative (TN)",
    human_code == 0 & decision_binary == 1 ~ "False Positive (FP)",
    human_code == 1 & decision_binary == 0 ~ "False Negative (FN)"
  ))
view(HZV_confusion)
saveRDS(HZV_confusion, "validation/HZV/outputs/HZV_confusion.rds")

# Extract the FNs from "HZV_confusion"
HZV_FN<- HZV_confusion%>%
  filter(result_type== "False Negative (FN)") 
view(HZV_FN)
# This is the new variable containing all the False Negatives(FNs).

HZV_FN <- HZV_FN |> 
  dplyr::select(ID, title, abstract) #preparing the dataset for the next screening round

writexl::write_xlsx(HZV_FN, "validation/HZV/outputs/HZV_FN.xlsx")
saveRDS(HZV_FN, "validation/HZV/outputs/HZV_FN.rds")
```

With the False Negatives now stored in an object called ‘HZV_FN’, we
will export this dataset to review the exclusion reasons provided by
`AIscreenR` (column “detailed_description”). This analysis will directly
inform the necessary refinements to our screening prompt.

## Prompt optimisation

Analysis of the exclusion reasons revealed that `AIscreenR` incorrectly
excluded references that did not specify the vaccine type, did not limit
participants to a specific age group, focused on vaccine safety and
studies on varicella/chickenpox vaccines.

After implementing these changes in the prompt, the optimised prompt is
now saved as a new variable in our R environment, as follows:

``` r
HZV_prompt2<-"Role: You are an expert systematic review screener specializing in vaccinology and epidemiology. 
Task: Evaluate whether a study meets the following specific inclusion criteria. 
Population: Adults of any age (18 years and older), with a specific focus on including middle-aged, older adults, and the elderly (e.g., 60–70 years, 80+ years, and beyond). Include individuals regardless of:  
Vaccination History: Including those with or without a previous history of vaccination (e.g., varicella/chickenpox). 
Medical History: Including those with or without prior episodes of herpes zoster. 
Health Status: Including participants with or without existing comorbidities or chronic conditions. This encompasses healthy populations as well as participants with conditions such as cardiovascular disease, organ or stem cell transplantation, Alzheimer’s disease, or other immunocompromising factors. 
Intervention: Studies evaluating the effectiveness and safety of either the Recombinant Zoster Vaccine (RZV; e.g., Shingrix, HZ/su), the Zoster Vaccine Live (ZVL; e.g., Zostavax), or unspecified zoster vaccines, such as those evaluated in national vaccination programs. 
Comparison/Control: Placebo, no vaccine, or alternative vaccines (including head-to-head comparisons between RZV and ZVL). 
Study Design: Randomized controlled trials (RCTs), non-randomized studies, and observational studies (prospective/retrospective cohort, population-based, registry-based, quasi-experimental, case-control, and nested case-control). Systematic reviews, meta-analyses, and post-marketing safety evaluations are also eligible. 
Exclude the following: Commentaries, narrative reviews, case studies, and case series. 
Evaluation Rule: Does the study meet all the inclusion criteria? Only include the study if every criterion is satisfied.
If you are uncertain about the inclusion of a study or if the study shows signs that the full text might meet the inclusion criteria,
choose INCLUDE to minimize the risk of missing relevant studies."

writeLines(HZV_prompt2, "validation/HZV/prompts/HZV_prompt2") #saving the prompt in the corresponding folder
```

**Running the screening using the optimised prompt**

**Date**: 27/February/2026. Screening run at NIPH in Oslo, Norway.

``` r
# Screening command
# HZV_FN_screening <- tabscreen_gpt(  
#   data = HZV_FN,
#   prompt = HZV_prompt2,
#   title = title,
#   abstract = abstract,
#   studyid = ID,
#   model = "gpt-4o-mini",
#   decision_description = TRUE,
#   max_tries = 10,
#   reps = 1
#   )

# saveRDS(HZV_FN_screening, "validation/HZV/outputs/HZV_FN_screening.rds")
```

**Analyzing the results**

To evaluate the impact of the optimised prompt, we measured the
reduction in False Negatives (FNs). This is calculated by subtracting
the new FNs (optimised) from the FNs in the initial screening. This
equals the prompt’s effectiveness in capturing previously missed
relevant references, thereby improving recall.

``` r
# HZV_FN_screening$answer_data%>%  #view the results
#   count(decision_binary) 
```

- The previous number of FNs in HZV_confusion_final was 48.

- HZV_optimised_screening = `AIscreenR` using GPT-4o-mini included 29
  (TPs) references and excluded 19 references (FNs).

- FN reduction = 29 references (60% FN reduction rate).

The fine-tuned prompt reduced the FNs rate by 60%.

## False Negative analysis using GPT-5-mini

We evaluate the comparative performance of OpenAI’s recent model,
GPT-5-mini, which is optimized for high-volume requests and offers
greater speed than GPT-4o-mini. According to OpenAI’s technical
documentation (OpenAI 2026), GPT-5-mini excels in efficiency, featuring
a 400K token context window, which is a significant increase over the
128K window found in GPT-4o-mini. Newer models will be tested in future
updates of this work.

To validate the performance of GPT-5-mini in controlling false negatives
(FNs), we re-ran the original prompt on the identified FN cases and
switched the model variable to GPT-5-mini, and compared the results.

``` r
#HZV_FN_gpt5_screening <- tabscreen_gpt(  
 #data = HZV_FN,
  #prompt = HZV_prompt2,
  #studyid = ID,
  #title = title,
  #abstract = abstract,
  #model = "gpt-5-mini",  ## changing the model **
  #reps = 1,
  #decision_description = TRUE
  #)

# Distribution of LLM-generated screening decisions
HZV_FN_gpt5_screening <- readRDS("validation/HZV/outputs/HZV_FN_gpt5_screening.rds")

HZV_FN_gpt5_screening$answer_data %>%  
  count(decision_binary) #Checking the raw numbers

view(HZV_FN_gpt5_screening$answer_data) # inspect the data

#Saving the results file
saveRDS(HZV_FN_gpt5_screening, "validation/HZV/outputs/HZV_FN_gpt5_screening.rds")
```

GPT-5-mini included 33 FN references (69% FN reduction rate), relative
to the 29 references included by GPT-4o-mini (60% FN reduction rate).
This represents a 9% screening performance gain.

# **HZV screening 2**

The optimised prompt (‘HZV_prompt2’), which improved screening
performance during False Negative Analysis, can now be used to re-run
the entire screening process. This iteration is expected to enhance the
overall recall of `AIscreenR` by reducing the False Negatives.

The impact of the optimised prompt will be evaluated using both
gpt-4o-mini and gpt-5-mini.

## HZV screening 2 using gpt-4o-mini

Running the screening using the optimised prompt: **Date**:
27/February/2026. Screening run at NIPH in Oslo, Norway.

``` r
#HZV_screening2 <- tabscreen_gpt(
  #data = HZV_references,     #The same set of references.
  #prompt = HZV_prompt2, #This is the optimised prompt.
  #studyid = ID,
  #title = title,
  #abstract = abstract,
  #model = "gpt-4o-mini",
  #reps = 1,
  #decision_description = TRUE
  #)
```

In **HZV screening 2 using gpt-4o-mini**, `AIscreenR` included 1,368 and
excluded 10,077 references.

``` r
HZV_screening2 <- readRDS("validation/HZV/outputs/HZV_screening2.rds")

#Saving the results file
saveRDS(HZV_screening2, "validation/HZV/outputs/HZV_screening2.rds")

# Preview of the screening results data.
view(HZV_screening2$answer_data) # inspect the data

# Distribution of LLM-generated screening decisions
HZV_screening2$answer_data %>%  
  count(decision_binary)

#Assign 0 to the references with NA (n=6)
HZV_screening2$answer_data$decision_binary[is.na(HZV_screening2$answer_data$decision_binary)]<-0

#Check
HZV_screening2$answer_data %>%  
  count(decision_binary)

writexl::write_xlsx(HZV_screening2$answer_data, "validation/HZV/outputs/HZV_screening2.xlsx") # Export to Excel
```

### Confusion matrix

1.  Preparing the raw data for the confusion matrix.

``` r
# Preparing the raw data for the metrics:
HZV_confusion2 <- table(
  Human = HZV_screening2$answer_data$human_code,
  AI = HZV_screening2$answer_data$decision_binary
)
# print(HZV_confusion2)
# view(HZV_confusion2)
# colnames(HZV_confusion2)
```

2.  Organizing the data in a data frame.

``` r
# Converting the raw data of the confusion matrix to a data frame (mandatory step in dplyr)
HZV_confusion2_df <- as.data.frame(HZV_confusion2)
colnames(HZV_confusion2_df) <- c("human_code", "decision_binary", "n")

HZV_confusion2_final <- HZV_confusion2_df %>% # using the dataframe (df)
  mutate(
    Human = if_else(human_code == 1, "Included", "Excluded"),
    AIScreenR = if_else(decision_binary == 1, "Included", "Excluded")
  ) %>%
    pivot_wider(id_cols = Human,names_from = AIScreenR,values_from = n)
View(HZV_confusion2_final)
```

3.  Plotting the confusion matrix

The evaluation of the **HZV screening 2 using** **gpt-4o-mini** (n =
11,445 references from the searches) is shown in
<a href="#tbl-confusion-matrix2_gpt4omini"
class="quarto-xref">Table 5</a>.

<div id="tbl-confusion-matrix2_gpt4omini">

Table 5: Confusion matrix AIscreenR vs HZV team - optimised prompt using
gpt-4o-mini

<div class="cell-output-display">

<div id="ojznqgelii" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#ojznqgelii table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#ojznqgelii thead, #ojznqgelii tbody, #ojznqgelii tfoot, #ojznqgelii tr, #ojznqgelii td, #ojznqgelii th {
  border-style: none;
}
&#10;#ojznqgelii p {
  margin: 0;
  padding: 0;
}
&#10;#ojznqgelii .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #004D80;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #004D80;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#ojznqgelii .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#ojznqgelii .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#ojznqgelii .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#ojznqgelii .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#ojznqgelii .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
}
&#10;#ojznqgelii .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #0076BA;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#ojznqgelii .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#ojznqgelii .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#ojznqgelii .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#ojznqgelii .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#ojznqgelii .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#ojznqgelii .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#ojznqgelii .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #0076BA;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#ojznqgelii .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #0076BA;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
  vertical-align: middle;
}
&#10;#ojznqgelii .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#ojznqgelii .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#ojznqgelii .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: none;
  border-top-width: 1px;
  border-top-color: #89D3FE;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #89D3FE;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #89D3FE;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#ojznqgelii .gt_stub {
  color: #FFFFFF;
  background-color: #0076BA;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #0076BA;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#ojznqgelii .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#ojznqgelii .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#ojznqgelii .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#ojznqgelii .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#ojznqgelii .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #0076BA;
}
&#10;#ojznqgelii .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#ojznqgelii .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
}
&#10;#ojznqgelii .gt_grand_summary_row {
  color: #333333;
  background-color: #89D3FE;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#ojznqgelii .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #0076BA;
}
&#10;#ojznqgelii .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #0076BA;
}
&#10;#ojznqgelii .gt_striped {
  background-color: #F4F4F4;
}
&#10;#ojznqgelii .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #0076BA;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
}
&#10;#ojznqgelii .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#ojznqgelii .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#ojznqgelii .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#ojznqgelii .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#ojznqgelii .gt_left {
  text-align: left;
}
&#10;#ojznqgelii .gt_center {
  text-align: center;
}
&#10;#ojznqgelii .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#ojznqgelii .gt_font_normal {
  font-weight: normal;
}
&#10;#ojznqgelii .gt_font_bold {
  font-weight: bold;
}
&#10;#ojznqgelii .gt_font_italic {
  font-style: italic;
}
&#10;#ojznqgelii .gt_super {
  font-size: 65%;
}
&#10;#ojznqgelii .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#ojznqgelii .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#ojznqgelii .gt_indent_1 {
  text-indent: 5px;
}
&#10;#ojznqgelii .gt_indent_2 {
  text-indent: 10px;
}
&#10;#ojznqgelii .gt_indent_3 {
  text-indent: 15px;
}
&#10;#ojznqgelii .gt_indent_4 {
  text-indent: 20px;
}
&#10;#ojznqgelii .gt_indent_5 {
  text-indent: 25px;
}
&#10;#ojznqgelii .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}
&#10;#ojznqgelii div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>

<table class="gt_table cell" data-quarto-postprocess="true"
data-quarto-disable-processing="false" data-quarto-bootstrap="false">
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr class="gt_heading">
<th colspan="3" class="gt_heading gt_title gt_font_normal">Confusion
matrix AIscreenR vs HZV team - optimised prompt</th>
</tr>
<tr class="gt_heading">
<th colspan="3"
class="gt_heading gt_subtitle gt_font_normal gt_bottom_border">Performance
analysis in study selection</th>
</tr>
<tr class="gt_col_headings gt_spanner_row">
<th rowspan="2" id="a::stub"
class="gt_col_heading gt_columns_bottom_border gt_left"
data-quarto-table-cell-role="th" scope="col">Human reviewers</th>
<th colspan="2" id="AIscreenR"
class="gt_center gt_columns_top_border gt_column_spanner_outer"
data-quarto-table-cell-role="th" scope="colgroup"><div
class="gt_column_spanner">
AIscreenR
</div></th>
</tr>
<tr class="gt_col_headings">
<th id="Included"
class="gt_col_heading gt_columns_bottom_border gt_right"
data-quarto-table-cell-role="th" scope="col">Included</th>
<th id="Excluded"
class="gt_col_heading gt_columns_bottom_border gt_right"
data-quarto-table-cell-role="th" scope="col">Excluded</th>
</tr>
</thead>
<tbody class="gt_table_body">
<tr>
<td id="stub_1_1" class="gt_row gt_center gt_stub"
data-quarto-table-cell-role="th" scope="row">Included</td>
<td class="gt_row gt_right" headers="stub_1_1 Included">96</td>
<td class="gt_row gt_right" headers="stub_1_1 Excluded">27</td>
</tr>
<tr>
<td id="stub_1_2" class="gt_row gt_center gt_stub"
data-quarto-table-cell-role="th" scope="row">Excluded</td>
<td class="gt_row gt_right gt_striped"
headers="stub_1_2 Included">1271</td>
<td class="gt_row gt_right gt_striped"
headers="stub_1_2 Excluded">10038</td>
</tr>
<tr>
<td id="grand_summary_stub_1"
class="gt_row gt_left gt_stub gt_grand_summary_row gt_first_grand_summary_row gt_last_summary_row"
data-quarto-table-cell-role="th" scope="row">Total</td>
<td
class="gt_row gt_right gt_grand_summary_row gt_first_grand_summary_row gt_last_summary_row"
headers="grand_summary_stub_1 Included">1,367</td>
<td
class="gt_row gt_right gt_grand_summary_row gt_first_grand_summary_row gt_last_summary_row"
headers="grand_summary_stub_1 Excluded">10,065</td>
</tr>
</tbody>
</table>

</div>

</div>

</div>

Interpreting the results of **HZV screening 2 using gpt4-o-mini**:

- **True Negatives (TN)=** 10,038 references (88%) were correctly
  excluded by both the HZV team and `AIscreenR`. In other words,
  `AIscreenR` safely removed 89% of the irrelevant records.

- **False Negatives (FN) =** 27 references (0.2%) included by the HZV
  team but missed by `AIscreenR`.

- **True Positives (TP) =** 96 references. These are the relevant
  studies correctly identified by both HZV team and `AIscreenR`.

- **False Positives (FP) =** 1,271 references were included by
  `AIscreenR` but excluded by the HZV team. This represents the residual
  manual workload (i.e., the 1,271 papers the review team still needs to
  check manually to ensure they are truly irrelevant).

### Key performance metrics

We estimate the accuracy and the recall of the optimised screening
<a href="#tbl-keymetricstuned" class="quarto-xref">Table 6</a>.

<div id="tbl-keymetricstuned">

Table 6: Key performance metrics in screening of AIscreenR vs HZV team:
HZV screening 2 using gpt4-o-mini

| Performance metric | Value | Interpretation |
|----|----|----|
| Recall (Sensitivity) | 78% | `AIscreenR` correctly identifies 78% of actually included references. |
| Accuracy | 89% | Overall, `AIscreenR` correctly classifies 89% of all references. |
| Specificity | 89% | `AIscreenR` correctly identifies 89% of actually excluded references. |
| Workload savings | 89% | The HZV team would have skipped the manual screening of 10,038 references (89%) by using `AIscreenR`. |

</div>

## Full screening using gpt-5-mini

Running the screening using the optimised prompt:

``` r
# HZV_screening_5gpt <- tabscreen_gpt(
#   data = HZV_references,
#   prompt = HZV_prompt2,
#   studyid = ID,
#   title = title,
#   abstract = abstract,
#   model = "gpt-5-mini",
#   reps = 1,
#   decision_description = TRUE
# )
```

Inspecting the screening results:

``` r
HZV_screening_5gpt <- readRDS("validation/HZV/outputs/HZV_screening_5gpt.rds")
# Preview of the screening results data.
view(HZV_screening_5gpt$answer_data) # inspect the data

# Distribution of LLM-generated screening decisions
HZV_screening_5gpt$answer_data%>%  
  count(decision_binary)

#Assign 0 to the references with NA (n=2)
HZV_screening_5gpt$answer_data$decision_binary[is.na(HZV_screening_5gpt$answer_data$decision_binary)]<-0

#Check
HZV_screening_5gpt$answer_data %>%  
  count(decision_binary)

#Saving the results file
saveRDS(HZV_screening_5gpt, "validation/HZV/outputs/HZV_screening_5gpt.rds")
```

In **HZV screening using gpt-5-mini**, `AIscreenR` excluded 9,366
references and included 2,079. Of note, *two* references were marked as
‘NA’ by the software. We checked these manually and reclassified them as
excluded (0) as they are not deemed relevant to the study.\

### Confusion matrix

1.  Preparing the raw data for the confusion matrix.

``` r
# Preparing the raw data for the metrics:
HZV_confusion2_gpt5 <- table( Human = HZV_screening_5gpt$answer_data$human_code, AI = HZV_screening_5gpt$answer_data$decision_binary)
print(HZV_confusion2_gpt5)
colnames(HZV_confusion2_gpt5)
```

2.  Organizing the data in a data frame.

``` r
# Converting the raw data of the confusion matrix to a data frame (mandatory step in dplyr)
HZV_confusion2_gpt5 <- as.data.frame(HZV_confusion2_gpt5)
colnames(HZV_confusion2_gpt5) <- c("human_code", "decision_binary", "n")

HZV_confusion2_gpt5_final <- HZV_confusion2_gpt5 %>% # using the dataframe (df)
  mutate(
    Human = if_else(human_code == 1, "Included", "Excluded"),
    AIscreenR = if_else(decision_binary == 1, "Included", "Excluded")
  ) %>%
    pivot_wider(id_cols = Human,names_from = AIscreenR,values_from = n)
View(HZV_confusion2_gpt5_final)
```

3.  Plotting the confusion matrix

The evaluation of the **HZV screening using gpt-5-mini** is shown in
<a href="#tbl-HZV_confusion2_gpt5" class="quarto-xref">Table 7</a>.

<div id="tbl-HZV_confusion2_gpt5">

Table 7: Confusion matrix AIscreenR vs HZV team - optimised prompt using
gpt-5-mini

<div class="cell-output-display">

<div id="wqkfaisvlt" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#wqkfaisvlt table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#wqkfaisvlt thead, #wqkfaisvlt tbody, #wqkfaisvlt tfoot, #wqkfaisvlt tr, #wqkfaisvlt td, #wqkfaisvlt th {
  border-style: none;
}
&#10;#wqkfaisvlt p {
  margin: 0;
  padding: 0;
}
&#10;#wqkfaisvlt .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #004D80;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #004D80;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#wqkfaisvlt .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#wqkfaisvlt .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#wqkfaisvlt .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#wqkfaisvlt .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#wqkfaisvlt .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
}
&#10;#wqkfaisvlt .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #0076BA;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#wqkfaisvlt .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#wqkfaisvlt .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#wqkfaisvlt .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#wqkfaisvlt .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#wqkfaisvlt .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#wqkfaisvlt .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#wqkfaisvlt .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #0076BA;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#wqkfaisvlt .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #0076BA;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
  vertical-align: middle;
}
&#10;#wqkfaisvlt .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#wqkfaisvlt .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#wqkfaisvlt .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: none;
  border-top-width: 1px;
  border-top-color: #89D3FE;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #89D3FE;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #89D3FE;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#wqkfaisvlt .gt_stub {
  color: #FFFFFF;
  background-color: #0076BA;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #0076BA;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#wqkfaisvlt .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#wqkfaisvlt .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#wqkfaisvlt .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#wqkfaisvlt .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#wqkfaisvlt .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #0076BA;
}
&#10;#wqkfaisvlt .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#wqkfaisvlt .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
}
&#10;#wqkfaisvlt .gt_grand_summary_row {
  color: #333333;
  background-color: #89D3FE;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#wqkfaisvlt .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #0076BA;
}
&#10;#wqkfaisvlt .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #0076BA;
}
&#10;#wqkfaisvlt .gt_striped {
  background-color: #F4F4F4;
}
&#10;#wqkfaisvlt .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #0076BA;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #0076BA;
}
&#10;#wqkfaisvlt .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#wqkfaisvlt .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#wqkfaisvlt .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#wqkfaisvlt .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#wqkfaisvlt .gt_left {
  text-align: left;
}
&#10;#wqkfaisvlt .gt_center {
  text-align: center;
}
&#10;#wqkfaisvlt .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#wqkfaisvlt .gt_font_normal {
  font-weight: normal;
}
&#10;#wqkfaisvlt .gt_font_bold {
  font-weight: bold;
}
&#10;#wqkfaisvlt .gt_font_italic {
  font-style: italic;
}
&#10;#wqkfaisvlt .gt_super {
  font-size: 65%;
}
&#10;#wqkfaisvlt .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#wqkfaisvlt .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#wqkfaisvlt .gt_indent_1 {
  text-indent: 5px;
}
&#10;#wqkfaisvlt .gt_indent_2 {
  text-indent: 10px;
}
&#10;#wqkfaisvlt .gt_indent_3 {
  text-indent: 15px;
}
&#10;#wqkfaisvlt .gt_indent_4 {
  text-indent: 20px;
}
&#10;#wqkfaisvlt .gt_indent_5 {
  text-indent: 25px;
}
&#10;#wqkfaisvlt .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}
&#10;#wqkfaisvlt div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>

<table class="gt_table cell" data-quarto-postprocess="true"
data-quarto-disable-processing="false" data-quarto-bootstrap="false">
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr class="gt_heading">
<th colspan="3" class="gt_heading gt_title gt_font_normal">Confusion
matrix AIscreenR vs HZV team - optimised prompt using gpt-5-mini</th>
</tr>
<tr class="gt_heading">
<th colspan="3"
class="gt_heading gt_subtitle gt_font_normal gt_bottom_border">Performance
analysis in study selection</th>
</tr>
<tr class="gt_col_headings gt_spanner_row">
<th rowspan="2" id="a::stub"
class="gt_col_heading gt_columns_bottom_border gt_left"
data-quarto-table-cell-role="th" scope="col">Human reviewers</th>
<th colspan="2" id="AIscreenR"
class="gt_center gt_columns_top_border gt_column_spanner_outer"
data-quarto-table-cell-role="th" scope="colgroup"><div
class="gt_column_spanner">
AIscreenR
</div></th>
</tr>
<tr class="gt_col_headings">
<th id="Included"
class="gt_col_heading gt_columns_bottom_border gt_right"
data-quarto-table-cell-role="th" scope="col">Included</th>
<th id="Excluded"
class="gt_col_heading gt_columns_bottom_border gt_right"
data-quarto-table-cell-role="th" scope="col">Excluded</th>
</tr>
</thead>
<tbody class="gt_table_body">
<tr>
<td id="stub_1_1" class="gt_row gt_center gt_stub"
data-quarto-table-cell-role="th" scope="row">Included</td>
<td class="gt_row gt_right" headers="stub_1_1 Included">107</td>
<td class="gt_row gt_right" headers="stub_1_1 Excluded">16</td>
</tr>
<tr>
<td id="stub_1_2" class="gt_row gt_center gt_stub"
data-quarto-table-cell-role="th" scope="row">Excluded</td>
<td class="gt_row gt_right gt_striped"
headers="stub_1_2 Included">1972</td>
<td class="gt_row gt_right gt_striped"
headers="stub_1_2 Excluded">9337</td>
</tr>
<tr>
<td id="grand_summary_stub_1"
class="gt_row gt_left gt_stub gt_grand_summary_row gt_first_grand_summary_row gt_last_summary_row"
data-quarto-table-cell-role="th" scope="row">Total</td>
<td
class="gt_row gt_right gt_grand_summary_row gt_first_grand_summary_row gt_last_summary_row"
headers="grand_summary_stub_1 Included">2,079</td>
<td
class="gt_row gt_right gt_grand_summary_row gt_first_grand_summary_row gt_last_summary_row"
headers="grand_summary_stub_1 Excluded">9,353</td>
</tr>
</tbody>
</table>

</div>

</div>

</div>

Interpreting the results of **HZV screening using gpt-5-mini**:

- **True Negatives (TN)=** 9,337 references (82%) were correctly
  excluded by both the HZV team and `AIscreenR`. In other words,
  `AIscreenR` safely removed 82% of the irrelevant records.

- **False Negatives (FN) =** 16 references (0.14%) included by the HZV
  team but missed (or wrongly excluded) by `AIscreenR`.

- **True Positives (TP) =** 107 references. These are the relevant
  studies correctly identified by both HZV team and `AIscreenR`.

- **False Positives (FP) =** 1,972 references (17%) were included by
  `AIscreenR` but excluded by the HZV team. This represents the
  *“residual manual workload”* (i.e., the 1,972 papers the review team
  still needs to check manually to ensure they are truly irrelevant).

### Key performance metrics (HZV screening using gpt-5-mini)

We estimate the accuracy and the recall of the fine-tuned screening
using `screen_analyzer` function in `AIscreenR`

| Performance metric | Value | Interpretation |
|----|----|----|
| Recall (Sensitivity) | 87% | `AIscreenR` correctly identifies 87% of actually included references. |
| Accuracy | 83% | Overall, `AIscreenR` correctly classifies 83% of all references. |
| Specificity | 83% | `AIscreenR` correctly identifies 83% of actually excluded references. |
| Workload savings | 82% | The HZV team would have skipped the manual screening of 9,337 references (82%) by using `AIscreenR`. |

Key performance metrics in screening of AIscreenR vs HZV team: HZV
screening using gpt-5-mini.

# **Conclusion**

The comparison of GPT-4o mini and GPT-5 mini using the fine-tuned prompt
in both models revealed higher recall for GPT-5 mini (87%) compared with
GPT-4o mini (78%), whereas specificity was slightly higher for GPT-4o
mini (89%) than for GPT-5 mini (83%). This also translated into greater
workload savings with GPT-4o mini (89% vs. 82% with GPT-5 mini).

This proof of concept suggests that LLMs can be safely used to
prioritize relevant studies during title and abstract screening of HZV
vaccine research. We will use GPT-5 mini in our literature selection
pipelines as part of the Living Evidence Map of Vaccine Research
(LEVAK). The same pipeline presented in this document will be used for
subsequent validations in the diseases included in LEVAK: influenza,
COVID-19, and pneumococcal disease.

# Stability assessment of AIscreenR performance

The LLMs may give different answers over time, and these differences in
the screening decisions affect the robustness of the studies included in
LEVAK. This analysis aims to evaluate the stability of the screening
decisions made by `AIscreenR` by comparing the results from previous
iterations with ewer ones to assess their similarity. We hypothesized
that `AIscreenR` maintains a stable performance over time when using the
same set of references and the same judgments from content experts.

## Stability assessment 1

#### Second iteration using GPT-5-mini

This assessment was conducted by Jose Meneses on October 15, 2026.

**Step 1: Splitting the references into chunks**

We first split the entire set of references (11, 445 references) into
manageable chunks to optimize processing and efficiency.

``` r
chunks <- split (HZV_references,
    ceiling(seq_len(nrow(HZV_references))/200))

length(chunks)        # nr of chunks
```

    [1] 58

``` r
nrow(chunks[[1]])     # must be 200
```

    [1] 200

**Step 2. Creating a folder to store chunks**

``` r
# # # creating the folder (directory)
# dir.create("screening_chunks", showWarnings = FALSE)
```

**Step 3. Setting up the loop**

This loop processes all the chunks in sequence, with *i* being the chunk
number. The function `sprintf("chunk_%03d.rds", i)` names the files
(screened chunks) using a three-digit zero-padded format (e.g., `i = 1`
will be `chunk_001.rds`, and `i = 12` will be `chunk_012.rds`).

``` r
# # setting up the loop
# for (i in seq_along(chunks)) {
#     f <- file.path("screening_chunks", sprintf("chunk_%03d.rds", i))  # naming the files
#   if (file.exists(f)) next       # skips completed iterations
```

**Step 4. Screening pipeline**

`tryCatch(A, error = B)` means “try A, and if it produces an error, do B
instead of stopping all of R”.

- Part A is the same `tabscreen_gpt()` call we used in previous
  screenings, but with `data = chunks[[i]]`. It thus screens only that
  single chunk.

- Part B is a function that runs if an error occurs (for example, the
  text/html error). It prints a message stating which chunk failed and
  what the error was (`conditionMessage(e)`), and returns `NULL`
  (nothing). The result, whether it is a real result or `NULL`, is saved
  in `res`.

``` r
#   res <- tryCatch(
#     tabscreen_gpt(
#       data = chunks[[i]],
#       prompt = HZV_prompt2,
#       studyid = ID,
#       title = title,
#       abstract = abstract,
#       model = "gpt-5-mini",
#       reps = 1,
#       decision_description = TRUE
#     ),
#     error = function(e) { message("Bolk ", i, " feilet: ", conditionMessage(e)); NULL }
#   )
```

**Step 5. Saving the screened chunks**

``` r
#   if (!is.null(res)) saveRDS(res, f)
# }
```

**Step 6. Combining the screened chunks and saving the outputs**

``` r
# # checking the structure of the chunks
# str(readRDS(files[1]), max.level = 1) 

# # putting the 'answer_data' together
# HZV_screening_5gpt_2 <- purrr::map(files, \(f) readRDS(f)$answer_data) |>
#   purrr::list_rbind()

# nrow(HZV_screening_5gpt_2) #checking the number of rows in the data
# dplyr::n_distinct(HZV_screening_5gpt_2$studyid) == nrow(HZV_references) # should be TRUE
# saveRDS(HZV_screening_5gpt_2, "validation/HZV/outputs/HZV_screening_5gpt_2.rds") # saving the screening results
# writexl::write_xlsx(HZV_screening_5gpt_2, "validation/HZV/outputs/HZV_screening_5gpt_2.xlsx") 
```

**Step 7. Checking the completeness of the screening**

``` r
HZV_screening_5gpt_2 <- read_excel("validation/HZV/outputs/HZV_screening_5gpt_2.xlsx") 

dplyr::n_distinct(HZV_screening_5gpt_2$studyid) == nrow(HZV_references) # should be TRUE
```

    [1] FALSE

``` r
setdiff(HZV_references$ID, HZV_screening_5gpt_2$studyid) # to see which studies were not screened
```

      [1] "7400" "7401" "7402" "7403" "7404" "7405" "7406" "7407" "7408" "7409"
     [11] "7410" "7411" "7412" "7413" "7414" "7415" "7416" "7417" "7418" "7419"
     [21] "7420" "7421" "7422" "7423" "7424" "7425" "7426" "7427" "7428" "7429"
     [31] "7430" "7431" "7432" "7433" "7434" "7435" "7436" "7437" "7438" "7439"
     [41] "7440" "7441" "7442" "7443" "7444" "7445" "7446" "7447" "7448" "7449"
     [51] "7450" "7451" "7452" "7453" "7454" "7455" "7456" "7457" "7458" "7459"
     [61] "7460" "7461" "7462" "7463" "7464" "7465" "7466" "7467" "7468" "7469"
     [71] "7470" "7471" "7472" "7473" "7474" "7475" "7476" "7477" "7478" "7479"
     [81] "7480" "7481" "7482" "7483" "7484" "7485" "7486" "7487" "7488" "7489"
     [91] "7490" "7491" "7492" "7493" "7494" "7495" "7496" "7497" "7498" "7499"
    [101] "7500" "7501" "7502" "7503" "7504" "7505" "7506" "7507" "7508" "7509"
    [111] "7510" "7511" "7512" "7513" "7514" "7515" "7516" "7517" "7518" "7519"
    [121] "7520" "7521" "7522" "7523" "7524" "7525" "7526" "7527" "7528" "7529"
    [131] "7530" "7531" "7532" "7533" "7534" "7535" "7536" "7537" "7538" "7539"
    [141] "7540" "7541" "7542" "7543" "7544" "7545" "7546" "7547" "7548" "7549"
    [151] "7550" "7551" "7552" "7553" "7554" "7555" "7556" "7557" "7558" "7559"
    [161] "7560" "7561" "7562" "7563" "7564" "7565" "7566" "7567" "7568" "7569"
    [171] "7570" "7571" "7572" "7573" "7574" "7575" "7576" "7577" "7578" "7579"
    [181] "7580" "7581" "7582" "7583" "7584" "7585" "7586" "7587" "7588" "7589"
    [191] "7590" "7591" "7592" "7593" "7594" "7595" "7596" "7597" "7598" "7599"

The following code allows up determine the chunks that were not
screened:

``` r
done <- list.files("screening_chunks") # retrieves a list of the screened/complete chunks
all_expected <- sprintf("chunk_%03d.rds", seq_along(chunks)) # creates a list of all chunks that should exist and formats them following the three-digit zero-padded format (to ensure consistency).
setdiff(all_expected, done) # calculates the difference
```

     [1] "chunk_001.rds" "chunk_002.rds" "chunk_003.rds" "chunk_004.rds"
     [5] "chunk_005.rds" "chunk_006.rds" "chunk_007.rds" "chunk_008.rds"
     [9] "chunk_009.rds" "chunk_010.rds" "chunk_011.rds" "chunk_012.rds"
    [13] "chunk_013.rds" "chunk_014.rds" "chunk_015.rds" "chunk_016.rds"
    [17] "chunk_017.rds" "chunk_018.rds" "chunk_019.rds" "chunk_020.rds"
    [21] "chunk_021.rds" "chunk_022.rds" "chunk_023.rds" "chunk_024.rds"
    [25] "chunk_025.rds" "chunk_026.rds" "chunk_027.rds" "chunk_028.rds"
    [29] "chunk_029.rds" "chunk_030.rds" "chunk_031.rds" "chunk_032.rds"
    [33] "chunk_033.rds" "chunk_034.rds" "chunk_035.rds" "chunk_036.rds"
    [37] "chunk_037.rds" "chunk_038.rds" "chunk_039.rds" "chunk_040.rds"
    [41] "chunk_041.rds" "chunk_042.rds" "chunk_043.rds" "chunk_044.rds"
    [45] "chunk_045.rds" "chunk_046.rds" "chunk_047.rds" "chunk_048.rds"
    [49] "chunk_049.rds" "chunk_050.rds" "chunk_051.rds" "chunk_052.rds"
    [53] "chunk_053.rds" "chunk_054.rds" "chunk_055.rds" "chunk_056.rds"
    [57] "chunk_057.rds" "chunk_058.rds"

Result = 200 references from the chunk nr. 38 were not screened.

Running the screening command with the missing chunk of references

``` r
missing_ids_gpt5_2 <- setdiff(HZV_references$ID, HZV_screening_5gpt_2$studyid)

HZV_missing_gpt5_2 <- dplyr::filter(HZV_references, ID %in% missing_ids_gpt5_2)
nrow(HZV_missing_gpt5_2) # checking 
```

    [1] 200

``` r
# res_missing_gpt5_2 <- tabscreen_gpt(
#   data = HZV_missing_gpt5_2,
#   prompt = HZV_prompt2,
#   studyid = ID,
#   title = title,
#   abstract = abstract,
#   model = "gpt-5-mini",
#   reps = 1,
#   decision_description = TRUE
# )

res_missing_gpt5_2 <- readRDS("validation/HZV/outputs/res_missing_gpt5_2.rds")

class(res_missing_gpt5_2)
```

    [1] "gpt"  "list"

``` r
saveRDS(res_missing_gpt5_2, "validation/HZV/outputs/res_missing_gpt5_2.rds")
```

xxx

``` r
HZV_screening_5gpt_2 <- dplyr::bind_rows(
  HZV_screening_5gpt_2,
  res_missing_gpt5_2$answer_data
)

saveRDS(HZV_screening_5gpt_2, "validation/HZV/outputs/HZV_screening_5gpt_2.rds")
class(HZV_screening_5gpt_2) 
```

    [1] "tbl_df"     "tbl"        "data.frame"

Being updated.

``` r
# HZV_analysis_it2 <-screen_analyzer(HZV_screening_5gpt_2, human_decision = human_code, key_result = FALSE)

# view(HZV_analysis_it2)
# saveRDS(HZV_analysis_it2, "validation/HZV/outputs/HZV_analysis_it2.rds")
```

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-Gartlehner2026" class="csl-entry">

Gartlehner, Gerald, Susan Banda, Max Callaghan, et al. 2026. “Cochrane
Evaluation of (Semi-)automated Review Methods: Protocol for an Adaptive
Platform Study Within Reviews.” *Journal of Clinical Epidemiology*,
ahead of print. <https://doi.org/10.1016/j.jclinepi.2026.112390>.

</div>

<div id="ref-ghosh2022a" class="csl-entry">

Ghosh, Chandril. 2022. *Data Analysis with Machine Learning for
Psychologists*. Springer International Publishing.
<https://doi.org/10.1007/978-3-031-14634-3>.

</div>

<div id="ref-HZV_FHI2026" class="csl-entry">

Heen, Eli, Ingun Heiene Tveteraas, Joakim Øverbø, et al. 2026. *Vaksine
Mot Herpes Zoster i Voksenvaksinasjonsprogram: Fullstendig
Metodevurdering \[Herpes Zoster Vaccine to Elderly in a National
Immunization Program\]*. Metodevurdering. Folkehelseinstituttet -
Norwegian Institute of Public Health.

</div>

<div id="ref-openai_models_docs" class="csl-entry">

OpenAI. 2026. “OpenAI API Documentation: Models.”
<https://developers.openai.com/api/docs/models>.

</div>

<div id="ref-vembye2025" class="csl-entry">

Vembye, Mikkel Helding, Julian Christensen, Anja Bondebjerg Mølgaard,
and Frederikke Lykke Witthöft Schytt. 2025. “Generative Pretrained
Transformer Models Can Function as Highly Reliable Second Screeners of
Titles and Abstracts in Systematic Reviews: A Proof of Concept and
Common Guidelines.” *Psychological Methods*, ahead of print, July 10.
<https://doi.org/10.1037/met0000769>.

</div>

</div>
