#!/bin/bash

# Requirements: grip, wkhtmltopdf
# pip install grip
# https://github.com/pdfkit/pdfkit/wiki/Installing-WKHTMLTOPDF

set -e


for position_title_normalcase in \
  "Analyste / Concepteur" \
  "Java Architect" \
  "Tech / Team Lead" \
  "Director of Engineering" \
  "Lead/Senior Full-Stack Developer" \
  "Director, R\&D" \
  "Director of Software Development" \
  "Lead/Senior Java Developer" \
  "Software Development Manager (Cloud)" \
  "Architecte de Solutions" \
  "DevOps Lead" \
  "Manager of Application Development" \
  "Senior Full Stack Developer" \
  "Expert Java Developer" \
  "Manager, Application Development and Automation" \
  "Senior Java Tech Lead" \
  "IT Manager" \
  "Software Development Manager" \
  "Software Engineering Director" \
  "Leader \& Consultant - Software Engineering" \
; do

  echo
  echo Generating resume for position of $position_title_normalcase

  resume_filename="resumes/Jonathan-Demers$(echo "-${position_title_normalcase}-" | sed -r 's/[^a-zA-Z0-9]+/-/g')Resume"

  cp Jonathan-Demers-Resume-Template.md $resume_filename.md

  position_title_uppercase="$(echo $position_title_normalcase | tr a-z A-Z)"
  sed -i -r "s|RESUME_FILENAME|$resume_filename|g" $resume_filename.md
  sed -i -r "s|POSITION_TITLE_UPPERCASE|$position_title_uppercase|g" $resume_filename.md
  sed -i -r "s|POSITION_TITLE_NORMALCASE|$position_title_normalcase|g" $resume_filename.md
  grip $resume_filename.md --title=" " --export $resume_filename.html
  wkhtmltopdf --page-size letter $resume_filename.html $resume_filename.pdf

  for ext in md html pdf; do
    cp $resume_filename.$ext Jonathan-Demers-Resume.$ext
  done

done
