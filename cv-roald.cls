\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cv-roald}[2017/07/25 My custom CV class]
\LoadClass[a4paper]{article}

% ---------------------------------------------------------------------------- %
%                                 PARAMETERS                                   %
% ---------------------------------------------------------------------------- %
% Size of the margin
\newlength{\margin}
\setlength{\margin}{25mm}

% # REQUIRED PACKAGES
% Adjust the margins of a page
\RequirePackage[margin = \margin]{geometry} 

% Size of the left column
\newlength{\leftcol}
\setlength{\leftcol}{19 mm}

% Height of the header
\newlength{\hdrheight}
\setlength{\hdrheight}{35mm}

% Vertical space between rows/paragraphs
\newlength{\vspacepar}
\setlength{\vspacepar}{0.3\baselineskip}

% Horizontal space before and after vertical bar (|) between address and 
% the contact details
\newlength{\hspaddress}
\setlength{\hspaddress}{1em}

% Horizontal space after font awesome icons
\newlength{\FAspace}
\setlength{\FAspace}{0.2em}

% ---------------------------------------------------------------------------- %
%                              CALCULATED LENGTHS                              %
% ---------------------------------------------------------------------------- %

% # REQUIRED PACKAGES
% To calculate lengths, for example the skip after the header
\RequirePackage{calc} 

% Skip after the header
\newlength{\hdrskip}
\setlength{\hdrskip}{\hdrheight-\margin}

% Width of the right column
\newlength{\rightcol}
\setlength{\rightcol}{\textwidth-\leftcol}

% ---------------------------------------------------------------------------- %
%                              CLASS OPTION                                    %
% ---------------------------------------------------------------------------- %

% # REQUIRED PACKAGES
% Use options in key value format for package options
\RequirePackage{kvoptions-patch}
% Flexible macros for defining and setting keys
\RequirePackage{xkeyval} %
% Enable the use of colours
\RequirePackage{xcolor} 

% Add option to change the color of the header and titles
% \define@key[<prefix>]{<family>}{<key>}[<default>]{<function>}
\define@key{cv-roald.cls}{changecolor}[102, 204, 51]{%
    \definecolor{maincolor}{RGB}{#1}%
}

\ExecuteOptionsX{changecolor}
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
% Subliminal refinements towards typographical perfection 
\RequirePackage{microtype}

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

% # REQUIRED PACKAGES
% Draw things (needed for the header)
\RequirePackage{tikz} 

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
            fill=maincolor, 
            minimum height=\hdrheight, 
            minimum width=\paperwidth, 
            outer sep=0,
            ] (name) at (current page.north west) {};
        % Node for the name
        \node[
            anchor=base, 
            text=white, 
            inner sep=0.25 cm
            ] (nametext) at (name.base) {%
                \fontsize{40pt}{32pt}\color{white}%
                {\titlefont #1~}{\titlefont \textbf{#2}\par}
                };
        % Address
        \node[
            anchor=north, 
            text=white, 
            ] (address) at (nametext.south)  {#3 \par};
        % Phone/mail/nationality
        \node[
            anchor=north, 
            text=white, 
            ] at (address.south)  {#4};
    \end{tikzpicture}
    \vspace{\hdrskip}
} 

% Places a picture on the top right of the page
\newcommand{\photo}[1]{%
    \begin{tikzpicture}[remember picture, overlay]
        \node[
            anchor=north east, 
            inner sep=0,
            outer sep=0,
            ] at (current page.north east) 
                {\includegraphics[height=\hdrheight]{#1}};
    \end{tikzpicture}
    \vspace{-0.5\hdrskip}
}

% ---------------------------------------------------------------------------- %
%                                  TITLE FORMAT                                %
% ---------------------------------------------------------------------------- %

% # REQUIRED PACKAGES
% To alter the style and spacing of titles 
\RequirePackage{titlesec} 

% Change format of the section title
\titleformat{\section}%
    {\titlefont\color{maincolor}\huge\bfseries}{\thesection}{0em}{}
\titlespacing*{\section}%
    {0pt}{1.5ex plus 0.2ex minus .2ex}{-0.5ex plus .2ex}

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
% For tables
\RequirePackage{tabularx} 
% Reduce spacing between items
\RequirePackage{enumitem} 
% Change item separation of lists globally
\setlist{parsep=1 pt, topsep=1 pt} 

% New environment with two columns, a narrow one on the left for the dates and
% a right one for what was done during that period.
\newenvironment{tabularcv}{%
    \tabularx{\textwidth}{%
        @{}>{\raggedright\arraybackslash}p{\leftcol}%
        @{}>{\raggedright\arraybackslash}p{\rightcol}%
        }%
    }%
    {\endtabularx}%

% Use bullet point lists inside a tabular environment    
\newenvironment{tabitemize}{
    \itemize}{
    \vspace*{-\baselineskip}
    \enditemize}    

% ---------------------------------------------------------------------------- %
%                              BODY TEXT OPTIONS                               %
% ---------------------------------------------------------------------------- %

% # REQUIRED PACKAGES
% To change \parindent and \parskip
\RequirePackage{parskip}

% Remove indent at the start of a new paragraph
\setlength{\parindent}{0pt}    

% Add extra vertical space between paragraphs    
\setlength{\parskip}{\vspacepar} 