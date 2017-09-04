# CV Template for XeLaTeX
I created a custom curriculum vitae class file (`.cls`), see the comments in `cv-roald-example.tex` to understand how it works. 

# Screenshot of cv-roald-example.pdf
![Example](cv-roald-example.png)

# Changes in version 2
### Changes which affect regular users
- You can change the color of the header and titles using the `changecolor` option. Example: `\documentclass[changecolor={111, 156, 45}]{cv-roald}`.
- You can add a picture to the top right of the page using the command `\photo{filename}`.
- It is no longer needed to start a new table row with `\\[\vspacepar]`, now `\\` is sufficient. The row spacing is now defined globally in the class file.

### Small changes in the background
- Removed a lot of variables from the class file.
- Improved the formatting of the `.cls` and `.tex` files.
