# Living Evidence Map of the Adult Immunisation Program in Norway (LEVAK)

Welcome to LEVAK! LEVAK is a living evidence map on vaccine research developed by the Department of Infectious Disease Control and Vaccines at the Norwegian Institute of Public Health. This site outlines the methods underpinning LEVAK and provides insights into the validation framework upon which it is built.
The studies presented in LEVAK are selected using an AIscreenR-assisted workflow. Further details on AIscnreenR are available at its won repo: https://mikkelvembye.github.io/AIscreenR/.  

Text text example

## Uploading the libraries and packages

This text describes the title/subtitle - it's just an example.

```{r}
# Load packages and libraries
library(rsconnect)
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

devtools::install_github("MikkelVembye/AIscreenR") # install the most recent pakcage update
```

Text - example

## setting the API key

This text describes the title/subtitle - it's just an example.

```{r}
# usethis::edit_r_environ() # Run this code to open your .Renviron file and  write CHATGPT_KEY=your_key. Thereafter, close and save the .Renviron file and restart RStudio (ctrl + shift + F10). From now on, the AIscreenR functions will automatically use get_api_key() to retrieve your API key from your R environment. 

get_api_key() # To check the API Key was saved successfully.
```

This text describes the title/subtitle - it's just an example.

### Third level subtitle
This text describes the title/subtitle - it's just an example.
This text describes the title/subtitle - it's just an example.

