#!/bin/bash

# sudo apt install pandoc texlive-latex-base texlive-fonts-recommended texlive-latex-extra texlive-xetex texlive-fonts-extra fonts-liberation fonts-noto
# wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-3/wkhtmltox_0.12.6.1-3.bookworm_amd64.deb
# sudo apt install ./wkhtmltox_0.12.6.1-3.bookworm_amd64.deb

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

  pandoc $resume_filename.md -o $resume_filename.html \
    --standalone \
    --highlight-style=tango \
    --metadata title=" " \
    --css=https://cdn.jsdelivr.net/npm/water.css@2/out/water.css
  sed -i -r "s|<title> </title>|<title>Jonathan Demers - $position_title_normalcase</title>|g" $resume_filename.html
  sed -i '/<\/body>/e cat Jonathan-Demers-Resume-Template-Footer.html' $resume_filename.html
  unix2dos $resume_filename.html

  wkhtmltopdf --enable-local-file-access --page-size letter $resume_filename.html $resume_filename.pdf

  for ext in md html pdf; do
    cp $resume_filename.$ext Jonathan-Demers-Resume.$ext
  done

done
