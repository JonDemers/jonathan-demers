#!/bin/bash

# Requirements: grip, wkhtmltopdf
# pip install grip
# https://github.com/pdfkit/pdfkit/wiki/Installing-WKHTMLTOPDF

set -e


for position_title_normalcase in \
  "Manager, Application Development and Automation" \
  "Senior Java Tech Lead" \
  "IT Manager" \
  "Software Development Manager" \
  "Software Engineering Director" \
; do

  echo
  echo Generating resume for position of $position_title_normalcase

  filename="output/Jonathan-Demers-$(echo $position_title_normalcase | sed -r 's/[^a-zA-Z0-9 -]//g' | sed -r 's/ /-/g')-Resume"

  cp Jonathan-Demers-Resume-Template.md $filename.md

  position_title_uppercase="$(echo $position_title_normalcase | tr a-z A-Z)"
  sed -i -r "s/POSITION_TITLE_UPPERCASE/$position_title_uppercase/g" $filename.md
  sed -i -r "s/POSITION_TITLE_NORMALCASE/$position_title_normalcase/g" $filename.md
  grip $filename.md --title=" " --export $filename.html
  wkhtmltopdf --page-size letter $filename.html $filename.pdf

  for ext in md html pdf; do
    cp $filename.$ext Jonathan-Demers-Resume.$ext
  done

done
