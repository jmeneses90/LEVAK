# Living Evidence Map of the Adult Immunisation Program in Norway (LEVAK)

Welcome to LEVAK! LEVAK is a living evidence map on vaccine research developed by the Department of Infectious Disease Control and Vaccines at the Norwegian Institute of Public Health. This site outlines the methods underpinning LEVAK and provides insights into the validation framework upon which it is built.
The studies presented in LEVAK are selected using an [AIscreenR-assisted workflow](https://mikkelvembye.github.io/AIScreenR/).

## Abstract

**Background**: Living evidence approaches are useful in navigating the steadily growing volume of vaccine research. Recent advances in artificial intelligence offer new opportunities to semi-automate workflows while preserving methodological rigor and transparency. This protocol outlines the development of a living evidence map for the Adult Immunisation in Norway, referred to as LEVAK. This will be a continually updated, interactive evidence map for the three vaccines in the national program: COVID-19, influenza, and pneumococcal vaccines alongside research on public attitudes toward vaccination and interventions to increase coverage.

**Methods**: LEVAK is co-developed with content experts who bring experience in vaccine research and healthcare policymaking. They collaborate with evidence synthesists and librarians to prioritize research questions and develop search strategies. These are peer-reviewed before being executed in MEDLINE and Embase for primary studies and supplemented with searches for systematic reviews in Epistemonikos and the Cochrane Database of Systematic Reviews. Following comprehensive validation, an artificial intelligence-assisted tool, AIscreenR, is deployed to select studies meeting predefined selection criteria. The resulting evidence hubs are digitized and presented via an interactive dashboard developed in Python. A user-experience analysis is planned to enhance the usability and scalability of LEVAK. Details regarding communication and retirement plans are also presented. 

**Discussion**: Validation, transparency, and accountability are critical in LEVAK. We present findings from a proof-of-concept evaluation of AIscreenR in our workflow. When benchmarked against a recently published health-technology assessment on herpes zoster vaccines, AIscreenR demonstrated high recall and specificity (both above 80%), alongside substantial workload savings. This is further strengthened by independent, peer-reviewed literature searches and adherence to methodological and reporting standards.

LEVAK will offer users an interactive overview of available peer-reviewed studies as well as research trends and gaps in prioritized research areas. Of note, LEVAK screens studies at the title and abstract level, without full-text assessments, quality appraisal, and data synthesis. We envision LEVAK serving as a valuable resource beyond Norway, enabling the broader international community to easily navigate near real-time living evidence. 


## Objectives and scope
The overarching aim of LEVAK is to provide users with a timely and living overview of the peer-reviewed evidence for the prioritized vaccines and topics. The Norwegian Institute of Public Health will use LEVAK to inform recommendations for the Adult Immunisation Program. 

LEVAK will also facilitate collaboration between the institute and other interest-holders (e.g., The Norwegian Ministry of Health and Care Services, The Norwegian Directorate of Health, Regional Health Authorities, municipalities, and academia). These collaborations may also extend to international organizations.

## Registration
Preliminary versions of the LEVAK protocol, results of the validation studies, and accompanying metadata will be made continuously available in the [LEVAK repository](https://osf.io/pmut5/overview). This GitHub repository helps us keep the code accessible and updated. Furthermore, the LEVAK methodological framework, validations, and reporting will adhere to the most recent guiding documents, including the Cochrane Handbook [^1], PRISMA statement [^2],  and the Responsible Use of AI in Evidence Synthesis [(RAISE)](https://osf.io/fwaud/overview).

## Methods

### LEVAK workflow

The living approach in LEVAK begins with the prioritization of research questions in collaboration with content experts for the different categories (i.e., three vaccines in the Adult Immunisation Program in Norway: pneumococcal, COVID-19, and influenza, as well as attitudes toward vaccination and interventions to increase coverage). A research librarian develops and runs database searches, which are peer-reviewed by a second librarian. The librarian shares drafts of the search strategies with content experts and the LEVAK team for feedback and validation. The resulting deduplicated file is used for study selection in the AI-supported screening tool, [AIscreenR](https://mikkelvembye.github.io/AIScreenR/).

Before formal deployment for each vaccine in the VVP, our team develops specific prompts together with the content experts to validate the performance of AIscreenR for study selection. The studies included by AIscreenR are then archived in the digital dashboard. Finally, feedback and insights will be iteratively gathered from end-users to ensure the LEVAK dashboard remains relevant and user-friendly.

<img src="images\Figure_1_workflow.png" alt="LEVAK Framework" width="650"/>


Text
Text


---
### References
[^1]: Higgins JPT TJ, Chandler J, Cumpston M, Li T, Page MJ, et al, editor(s). Cochrane Handbook for Systematic Reviews of Interventions version 6.5 (updated August 2024). Cochrane; 2024 [Available from: www.cochrane.org/handbook].

[^2]: Akl EA, Khabsa J, Iannizzi C, Piechotta V, Kahale LA, Barker JM, et al. Extension of the PRISMA 2020 statement for living systematic reviews (PRISMA-LSR): checklist and explanation. BMJ. 2024;387:e079183.




