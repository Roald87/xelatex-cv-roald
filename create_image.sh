#!/bin/bash

# Create a .png image from the cv-roald-example.pdf file
convert -density 150 cv-roald-example.pdf -quality 70 -alpha Remove \( +clone -background black -shadow 40x8+0+0 \) +swap -background white -layers merge +repage cv-roald-example.png