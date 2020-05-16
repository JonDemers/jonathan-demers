#!/bin/bash

# Requirements: grip, wkhtmltopdf
# pip install grip
# https://github.com/pdfkit/pdfkit/wiki/Installing-WKHTMLTOPDF

set -e

grip Jonathan-Demers-Resume.md --title=" " --export Jonathan-Demers-Resume.html

wkhtmltopdf Jonathan-Demers-Resume.html Jonathan-Demers-Resume.pdf
