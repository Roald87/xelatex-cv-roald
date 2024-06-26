\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cv-roald}[2024/04/07 My custom CV class v5.0.0]
\LoadClass[a4paper]{article}

% ---------------------------------------------------------------------------- %
%                                 PARAMETERS                                   %
% ---------------------------------------------------------------------------- %
% Size of the margin
\newlength{\margin}
\setlength{\margin}{25mm}

% Size of the left column
\newlength{\leftcol}
\setlength{\leftcol}{19 mm}

% Height of the header
\newlength{\hdrheight}
\setlength{\hdrheight}{35mm}

% Vertical space between rows/paragraphs
\newlength{\vspacepar}
\setlength{\vspacepar}{0.6\baselineskip}

% Horizontal space before and after vertical bar (|) between address and 
% the contact details
\newlength{\hspaddress}
\setlength{\hspaddress}{1em}

% Horizontal space after font awesome icons
\newcommand{\FAspace}{\hspace{0.5 em}}

% Left indentation (before the bullet) of an itemized list
\setlength{\leftmargini}{2em}

% # REQUIRED PACKAGES
% Adjust the margins of a page
\RequirePackage[margin = \margin, top = \hdrheight]{geometry} 

% ---------------------------------------------------------------------------- %
%                              CALCULATED LENGTHS                              %
% ---------------------------------------------------------------------------- %

% # REQUIRED PACKAGES
% To calculate lengths, for example the skip after the header
\RequirePackage{calc} 

% Width of the right column
\newlength{\rightcol}
\setlength{\rightcol}{\textwidth-\leftcol}

% ---------------------------------------------------------------------------- %
%                              CLASS OPTION                                    %
% ---------------------------------------------------------------------------- %

% # REQUIRED PACKAGES
% Flexible macros for defining and setting keys
\RequirePackage{xkeyval} %
% Draw things (needed for the header).
\RequirePackage{tikz} 

% Add option to change the color of the header and titles
% \define@key[<prefix>]{<family>}{<key>}[<default>]{<function>}
\define@key{cv-roald.cls}{changecolor}[169, 53, 40]{%
    \definecolor{main}{RGB}{#1}%
}

% Process changecolor to define main color, else colorharmony and titlecolor
% will not work correctly.
\ExecuteOptionsX{changecolor}
\ProcessOptionsX%

\define@key{cv-roald.cls}{colorharmony}[wheel,2,3]{%
    \colorlet{second}{main>#1}%
}

% Process colorharmony to define second color, or else titlecolor will not work.
\ExecuteOptionsX{colorharmony}
\ProcessOptionsX%

\define@key{cv-roald.cls}{titlecolor}[main]{%
    \colorlet{title}{#1}%
}

\ExecuteOptionsX{titlecolor}
\ProcessOptionsX%

% ---------------------------------------------------------------------------- %
%                                     FONTS                                    %
% ---------------------------------------------------------------------------- %

% # REQUIRED PACKAGES
% Needed to run XeLaTeX
\RequirePackage{fontspec}
% Important to add, else fontawesome will not work with XeLaTeX 
\defaultfontfeatures{ 
  Path = Fonts/
}
% Load cool icons, such as the linked in logo
\RequirePackage{fontawesome} 

\setmainfont{SourceSansPro}[ 
  Path = Fonts/,
  Extension = .otf ,
  UprightFont = *-Light,
  ItalicFont = *-LightIt,
  BoldFont = *-Semibold,
]    

\newfontfamily\titlefont{AdventPro}[ 
  Path = Fonts/,
  Extension = .ttf,
  UprightFont = *-ExtraLight,
  BoldFont = *-SemiBold,
]        

% ---------------------------------------------------------------------------- %
%                                   HEADER                                     %
% ---------------------------------------------------------------------------- %

% Separator with a horizontal space before and after. Is used in the header as 
% a separator between address and contact details
\newcommand{\sep}{\hspace{\hspaddress} | \hspace{\hspaddress}}

% This places a header on top of the page.
% #1 First name
% #2 Last name
% #3 = Address
% #4 = Phone, mail and LinkedIn
\newcommand{\header}[4]{%
  \begin{tikzpicture}[remember picture, overlay]
    % Colored bar on top of the page
    \node[
        below right, 
        fill=main, 
        minimum height=\hdrheight, 
        minimum width=\paperwidth, 
        outer sep=0,
      ] (name) at (current page.north west) {};
    % Node for the name
    \node[
        anchor=base, 
        text=white,
        inner sep=0.25 cm,
      ] (nametext) at (name.base) {%
        \fontsize{40pt}{32pt}\color{white}%
        {\titlefont #1~}{\titlefont \textbf{#2}\par}
        };
    % Address
    \node[
        anchor=north, 
        text=white,
      ] (address) at (nametext.south) {#3\par};
    % Phone/mail/nationality
    \node[
        anchor=north, 
        text=white,
      ] at (address.south)  {#4\par};
  \end{tikzpicture}
} 

% Places a picture on the top right of the page
\newcommand{\photo}[1]{%
  \begin{tikzpicture}[remember picture, overlay]
    \node[
        anchor=north east, 
        inner sep=0 pt,
        outer sep=0 pt,
      ] at (current page.north east)
        {\includegraphics[height=\hdrheight]{#1}\par};    
  \end{tikzpicture}%
  % Fix when picture is added, else the text moves down. 
  \vspace*{-1.5\baselineskip}
}%

% URL header link command, because they need to be white
\newcommand{\headerref}[3][white]{\href{https://#2}{\color{#1}{#3}}}

% special commands for linkedin, github and your own webpage
\newcommand{\linkedin}[1]{\headerref{linkedin.com/in/#1}{\faLinkedinSquare /in/#1}}
\newcommand{\github}[1]{\headerref{github.com/#1}{\faGithub /#1}}
\newcommand{\website}[1]{\headerref{#1}{\faGlobe \FAspace #1}}

% ---------------------------------------------------------------------------- %
%                                  TITLE FORMAT                                %
% ---------------------------------------------------------------------------- %

% # REQUIRED PACKAGES
% To alter the style and spacing of titles 
\RequirePackage{titlesec} 

% Change format of the section title
\titleformat{\section}%
  {\titlefont\color{title}\huge\bfseries}{\thesection}{0em}{}
% \titlespacing{command}{left spacing}{before spacing}{after spacing}[right]
\titlespacing*{\section}%
  {0pt}{1ex plus 0.2ex minus 0.2ex}{0ex plus 0.1ex minus 0.1ex}

% Defines a new command which can be used as a formatter for your Job title and 
% location.
% example: \worktitle{Study name/Job title}{Location}.
% #1 = Job or education title 
% #2 = Company and location
\newcommand{\worktitle}[2]{
  {\bfseries\MakeUppercase{#1}}  
  {\itshape #2}
}

% ---------------------------------------------------------------------------- %
%                               ENVIRONMENTS                                   %
% ---------------------------------------------------------------------------- %

% # REQUIRED PACKAGES
% Increase spacing after text, between rows
\usepackage{cellspace}
\setlength{\cellspacebottomlimit}{\vspacepar}

% New environment with two columns, a narrow one on the left for the dates and
% a right one for what was done during that period.
\newenvironment{tabularcv}{%
  \par\noindent
  \begin{tabular}{
      @{}>{\raggedright\arraybackslash}S{p{\leftcol}}
      @{}>{\raggedright\arraybackslash}S{p{\rightcol}}
      @{}
    }
  }
  {\end{tabular}}

% ---------------------------------------------------------------------------- %
%                              BODY TEXT OPTIONS                               %
% ---------------------------------------------------------------------------- %

% # REQUIRED PACKAGES
% To change \parindent and it adjusts the skips between list items.
\RequirePackage{parskip}

% Remove indent at the start of a new paragraph
\setlength{\parindent}{0pt}  

\RequirePackage{hyperref}

% Links will be in the second color as determined by the color wheel
\hypersetup{colorlinks=true, urlcolor=second}
% Places a link to a website with a fontawesome logo
\newcommand{\link}[1]{\href{#1}{\faExternalLink}}  
