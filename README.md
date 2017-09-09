# CV Template for XeLaTeX
I created a custom curriculum vitae class file (`.cls`), see the comments in `cv-roald-example.tex` to understand how it works. 

# Screenshot of cv-roald-example.pdf
![Example](cv-roald-example.png)

# Changes in version 3
## Changes which affect regular users
- Added a new `documentclass` option `colorharmony`, which defines a new color using color harmony models. The new color is called `second` and can use this color in the document with `\color{second}`. This color is also used for the new `link{}` command, see below.
- Added a new `documentclass` option `titlecolor`, which allows you to set a separate color (compared to the header) of the titles.
- Defined a new command `\FAspace` which replaces the old length `\FAspace` (and therefore breaks compatibility with the v2 class file). Now you can use `\FAspace` directly in the document, instead of using `\hspace{\FAspace}`.
- Defined a new command `\link{someurl.com}`, which places a fontawesome logo in the document with the link. The color is detemined using the color harmony models.
