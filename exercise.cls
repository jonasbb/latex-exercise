% special LaTeX class for exercises
% Malte Schmitz - Januar 2010

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{exercise}

% input encoding
\RequirePackage[utf8]{inputenc}

% new german spelling
\RequirePackage[english,ngerman]{babel}

% choose font
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage{textcomp}
\RequirePackage{courier}

% load xkeyval before loading KOMA to make shure
% KOMA uses xkeyval instead if keyval
\RequirePackage{xkeyval}

% KOMA-Script class for article
\LoadClass{scrartcl}
\KOMAoption{fontsize}{10pt}
\KOMAoption{parskip}{half}

% set type area
\RequirePackage[paper=a4paper,
                left=2.5cm,
                right=2.5cm,
                top=4cm,
                marginparsep=1cm,
                marginparwidth=3cm,
                bottom=2cm,
                headsep=.5cm,
                footskip=1cm,
                head=33pt]{geometry}

% headings witout numbers
\RequirePackage[headsepline=0.2pt]{scrlayer-scrpage}
\KOMAoption{headings}{normal}
\setcounter{secnumdepth}{0}

% special task header
\RequirePackage{ifthen}
\RequirePackage{twoopt}
\newcounter{task}
\setcounter{task}{0}
\renewcommand{\thetask}{\arabic{task}}
\newcounter{sheet}
\setcounter{sheet}{0}
\renewcommand{\thesheet}{\arabic{sheet}}
\providecommand{\taskname}{Aufgabe}
\providecommand{\taskcommand}{section}
\newcommand{\invoketaskcommand}{\csname\taskcommand\endcsname}
\newcommandtwoopt{\task}[2][][]{%
  \ifthenelse{\equal{#2}{}}{%
    \addtocounter{task}{1}%
    \ifthenelse{\equal{#1}{}}{%
      \invoketaskcommand{\taskname{} \thetask}%
    }{%
      \invoketaskcommand[\taskname{} \thetask: #1]{\taskname{} \thetask\quad\mdseries\color{black}#1}%
    }%
  }{%
    \ifthenelse{\equal{#1}{}}{%
      \invoketaskcommand{#2}%
    }{%
      \invoketaskcommand[#2: #1]{#2\quad\mdseries\color{black}#1}%
    }%
  }%
}

% content of head and foot
\providecommand{\sheetname}{Übungszettel}
\newcommand{\@sheettext}{}
\pagestyle{scrheadings}
\clearscrheadfoot
\automark{section}
\newcommand{\setgroup}[1] {\ohead{#1}}

\newcommand{\addstudent}[2][]{%
  \scr@ifundefinedorrelax{@students@value}{%
    \newcommand{\@students@value}{#2 \ifthenelse{\equal{#1}{}}{}{(#1)}}%
    \newcommand{\@students@pdf}{#2}%
  }{%
    \expandafter\def\expandafter\@students@value\expandafter{%
      \@students@value\\#2 \ifthenelse{\equal{#1}{}}{}{(#1)}}%
    \expandafter\def\expandafter\@students@pdf\expandafter{%
      \@students@pdf{}, #2}}%
  \hypersetup{pdfauthor={\@students@pdf}}%
  \ihead{{\@students@value}}}

\newcommand{\settitle}[2][\@sheettext] {%
  \hypersetup{pdftitle={#2},pdfsubject={#1}}%
  \chead{\large~\\\vskip-0.9em\textbf{#2}\\\vskip0.1em \textcolor{maincolor}{#1}}}

\RequirePackage{zref-totpages}
\cfoot*{%
  \ifnum\ztotpages>1% We know the total number of pages and it is more than one --> page numbers!
    {\arabic{page}~/~\ztotpages}%
  \else%
    \ifnum\ztotpages=1% There is only one page in total --> no page numbers!
      %
    \else%
      \arabic{page}% We do not know the total number of pages yet --> recompile needed
    \fi%
  \fi%
}

% layout of head and foot
\setkomafont{pageheadfoot}{\small\sffamily}
\setkomafont{pagefoot}{\sffamily}

% add maincolor to section layout
\addtokomafont{section}{\color{maincolor}}

% enable colors
\RequirePackage[table]{xcolor}
% define color of university of luebeck
\xdefinecolor{uni-luebeck}{RGB}{0, 120, 140}
\xdefinecolor{cispa}{RGB}{0, 156, 196}
\xdefinecolor{cispa-dark}{RGB}{0, 128, 161}
\colorlet{maincolor}{orange}

% zebra tables
\newcommand{\mainrowcolors}{\rowcolors{1}{maincolor!25}{maincolor!5}}
\newenvironment{zebratabular}{\mainrowcolors\begin{tabular}}{\end{tabular}}
\newcommand{\setrownumber}[1]{\global\rownum#1\relax}
\newcommand{\headerrow}{\rowcolor{maincolor!50}\setrownumber1}

% set special behaviour for hyperlinks in pdfs
\RequirePackage{hyperref}
\hypersetup{breaklinks=true,
            pdfborder={0 0 0},
            pdfhighlight={/N}}
\RequirePackage[all]{hypcap}

% german quotes
\RequirePackage[babel,german=guillemets]{csquotes}
% for normal german quotes use german=quotes

% math
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{mathtools}
\mathtoolsset{showonlyrefs} % only show number on referenced formula
% float left of formulas
\@fleqntrue\let\mathindent\@mathmargin \@mathmargin=\leftmargini

% listings
\RequirePackage{listings}
\definecolor{darkgreen}{rgb}{0,0.3,0}
\definecolor{darkorange}{rgb}{0.71,0.4,0.11}
\lstset{%
  basicstyle=\ttfamily,%
  keywordstyle=\color{maincolor}\bfseries,%
  identifierstyle=\color{darkorange},%
  commentstyle=\color{black!80},
  stringstyle=\color{darkgreen},
  numbers=left,%
  numberstyle=\footnotesize,%
  frame=lines,%
  captionpos={b},% set caption pos to bottom
  backgroundcolor=\color{maincolor!5},%
  rulecolor=\color{maincolor!70},%
  framerule=1pt,%
  showstringspaces=false,%
  upquote=true}
% german umlauts
\lstset{
  literate={ö}{{\"o}}1
           {ä}{{\"a}}1
           {ü}{{\"u}}1
           {ß}{{\ss}}1
}
% Define x86/x64 Assembler
\lstdefinelanguage
   [x64]{Assembler}     % add a "x64" dialect of Assembler
   [x86masm]{Assembler} % based on the "x86masm" dialect
   % with these extra keywords:
   {morekeywords={CDQE,CQO,CMPSQ,CMPXCHG16B,JRCXZ,LODSQ,MOVSXD, %
                  POPFQ,PUSHFQ,SCASQ,STOSQ,IRETQ,RDTSCP,SWAPGS, %
                  CMOVE, .text, .data, %
                  rax,rdx,rcx,rbx,rsi,rdi,rsp,rbp, %
                  r8,r8d,r8w,r8b,r9,r9d,r9w,r9b, %
                  r10,r10d,r10w,r10b,r11,r11d,r11w,r11b,
                  r12,r12d,r12w,r12b,r13,r13d,r13w,r13b %
                  }}

% nice tick
\newcommand{\tick}{\checkmark}

% often used sets
\newcommand{\set}[1]{\mathbb{#1}}
\newcommand{\R}{\set{R}}
\newcommand{\N}{\set{N}}
\newcommand{\Z}{\set{Z}}
\newcommand{\Q}{\set{Q}}

% custom operators
\newcommand{\op}[1]{\operatorname{#1}}

% nice blitz symbol
\RequirePackage{stmaryrd}
\newcommand{\blitz}{\quad\ensuremath{\lightning}}

% nice dx symbol
\newcommand{\dx}[1][x]{\,\mathrm{d}#1}
\newcommand{\dt}{\dx[t]}

% nice transposed symbol
\newcommand{\trans}[1]{{#1}^\text{T}}

% nice z.z. symbol
\newcommand{\zz}{\mathrm{Z\kern-.3em\raise-0.5ex\hbox{Z}}}

% better list envorinment
\RequirePackage{paralist}
\setdefaultenum{\color{maincolor}a)}{\color{maincolor}1.}{\color{maincolor}i.}{\color{maincolor}A.}
\setdefaultitem{\color{maincolor}\textbullet}%
  {\color{maincolor}\normalfont\bfseries \textendash}%
  {\color{maincolor}\textasteriskcentered}{\color{maincolor}\textperiodcentered}
% variant list environments for convenience
\newcommand{\setvaritem}{%
  \setdefaultitem{\color{maincolor}\normalfont\bfseries \textendash}%
    {\color{maincolor}\textasteriskcentered}{\color{maincolor}\textperiodcentered}{}}
\newcommand{\setvarenum}{%
  \setdefaultenum{\color{maincolor}1)}{\color{maincolor}a)}{}{}}
\newenvironment{varitemize}{%
  \setvaritem\begin{itemize}}{\end{itemize}}
\newenvironment{varcompactitem}{%
  \setvaritem\begin{compactitem}}{\end{compactitem}}
\newenvironment{varenumerate}{%
  \setvarenum\begin{enumerate}}{\end{enumerate}}
\newenvironment{varcompactenum}{%
  \setvarenum\begin{compactenum}}{\end{compactenum}}

% redefine existing list environments to color every item in the maincolor
\newcommand{\ifempty}[3]{\ifthenelse{\equal{#1}{}}{#2}{#3}}
\newcommand{\@oldenumerate}{}
\newcommand{\@olditemize}{}
\let\@oldenumerate\enumerate
\let\@olditemize\itemize
\let\@oldcompactenum\compactenum
\let\@oldcompactitem\compactitem
\renewcommand{\enumerate}[1][]{\ifempty{#1}{\@oldenumerate}{\@oldenumerate[\color{maincolor}#1]}}
\renewcommand{\itemize}[1][]{\ifempty{#1}{\@olditemize}{\@olditemize[\color{maincolor}#1]}}
\renewcommand{\compactenum}[1][]{\ifempty{#1}{\@oldcompactenum}{\@oldcompactenum[\color{maincolor}#1]}}
\renewcommand{\compactitem}[1][]{\ifempty{#1}{\@oldcompactitem}{\@oldcompactitem[\color{maincolor}#1]}}

% funny lists using dingbats
\RequirePackage{pifont}
\newenvironment{dingitem}[2][pzd]{\begin{itemize}[\Pisymbol{#1}{#2}]}{\end{itemize}}
\newenvironment{compactdingitem}[2][pzd]{\begin{compactitem}[\Pisymbol{#1}{#2}]}{\end{compactitem}}
% enumerations
\newcounter{@dingenumindex}
\newcommand{\@dingenumitem}{\stepcounter{@dingenumindex}\color{maincolor}\Pisymbol{pzd}{\value{@dingenumindex}}}
\newenvironment{dingenum}[2][pzd]{\setcounter{@dingenumindex}{#2}\addtocounter{@dingenumindex}{-2}\@olditemize[\@dingenumitem]}{\enditemize}
\newcounter{@compactdingenumindex}
\newcommand{\@compactdingenumitem}[1]{\stepcounter{@compactdingenumindex}\color{maincolor}\Pisymbol{#1}{\value{@compactdingenumindex}}}
\newenvironment{compactdingenum}[2][pzd]{\setcounter{@compactdingenumindex}{#2}\addtocounter{@compactdingenumindex}{-2}\@oldcompactitem[\@compactdingenumitem{#1}]}{\endcompactitem}

% paragraph without latex magic
\newcommand{\inhead}[1]{\begin{sffamily}\bfseries #1 \end{sffamily}}

% special proof environment
\providecommand{\proofname}{Beweis}
\providecommand{\qedsymbol}{\textcolor{maincolor}{$\square$}}
\newcommand{\qed}{\hfill\text{\qedsymbol}}
\newenvironment{proof}{%
  \trivlist
  \newif\if@qed@set% prevent \qed from being called twice in one proof
  \renewcommand{\qed}{\if@qed@set\else\hfill\text{\qedsymbol}\fi\global\@qed@settrue}
  \item[\hskip\labelsep
        \upshape\bfseries\sffamily
    \textcolor{maincolor}{\proofname}\quad]\ignorespaces
}{\qed\endtrivlist}

% special claim environment
\providecommand{\claimname}{Behauptung}
\newenvironment{claim}{%
  \trivlist
  \item[\hskip\labelsep
        \itshape
    \claimname\quad]\ignorespaces
}{\endtrivlist}

% key=value management
% must be at the end, because macros and counters are redefined
\newcommand{\@familyname}{Uni}
\DefineFamily{\@familyname} % define new family
\DefineFamilyMember{\@familyname} % register this class as a family member
\FamilyBoolKey{\@familyname}{biglinespread}{@biglinespread}
\DefineFamilyKey{\@familyname}{sheet}{%
  \setcounter{sheet}{#1}%
  \renewcommand{\@sheettext}{\sheetname{} \thesheet}}
\DefineFamilyKey{\@familyname}{task}{%
  \setcounter{task}{#1}%
  \addtocounter{task}{-1}}
\FamilyBoolKey{\@familyname}{prefix}{@prefix}
\DefineFamilyKey{\@familyname}{maincolor}{%
  \colorlet{maincolor}{#1}
}
\define@choicekey*{\@familyname.\@currname.\@currext}{language}[\val\nr]{de,en}{%
  \ifcase\nr\relax
    % de = deutsch
    \AtBeginDocument{\selectlanguage{ngerman}} % babel
    \renewcommand{\taskname}{Aufgabe}
    \renewcommand{\sheetname}{Übungszettel}
    \renewcommand{\proofname}{Beweis}
    \renewcommand{\claimname}{Behauptung}
  \or
    % en = english
    \AtBeginDocument{\selectlanguage{english}} % babel
    \renewcommand{\taskname}{Task}
    \renewcommand{\sheetname}{Exercise Sheet}
    \renewcommand{\proofname}{Proof}
    \renewcommand{\claimname}{Claim}
  \fi
}
% place vectors in bold
\let\oldvec\vec
\let\vec\boldsymbol
\define@choicekey*{\@familyname.\@currname.\@currext}{vec}[\val\nr]{arrow,bold,underline}{%
  \ifcase\nr\relax
    % arrow
    \let\vec\oldvec
  \or
    % bold
    \let\vec\boldsymbol
  \or
    % underline
    \let\vec\underline
  \fi
}
\FamilyProcessOptions{\@familyname}

% 1.5 times line spreading?
\if@biglinespread
  \linespread{1.25}%
\else
  \linespread{1}%
\fi

% add sheet to task counter?
\if@prefix
  \renewcommand{\thetask}{\thesheet.\arabic{task}}
\fi

% Disable the wide space after a dot
\AtBeginDocument{
  \let\nonfrenchspacing=\frenchspacing
  \frenchspacing
}

% Implement some support for multiple choice exercises
%
% This adds the main command \correctitem.
% It can be used instead of \item and marks the correct solution for a multiple choice exercise.
% It takes an optional argument which is printed behind the bullet point.
%
% The command \multiplechoicesolutions prints the solutions to the previous questions based on the \correctitem command

\RequirePackage{etoolbox}

\def\@multiplechoicesolutionlist{}
\newcommand{\@printlist}[2][,]{{% Print list
  % % http://tex.stackexchange.com/a/89187/5764
  % \def\listsep{\def\listsep{#1}}% Delayed execution of list separator
  % \renewcommand{\do}[1]{\listsep`##1'}%

  \renewcommand*{\do}[1]{\item ##1}%
  \begin{itemize}
    \dolistloop\@multiplechoicesolutionlist
  \end{itemize}
}}

\newcommand{\correctitem}[1][]{%
  \item%
  \listxadd{\@multiplechoicesolutionlist}{\alph{enumi}) \number\value{enumii}~#1}%
  \textcolor{maincolor}{\tick~#1}%
}
\newcommand{\multiplechoicesolutions}{
  \@printlist{\@multiplechoicesolutionlist}
  \global\def\@multiplechoicesolutionlist{}
}

% Definitions for the solution boxes:
\RequirePackage{mdframed}
\RequirePackage{comment}

\includecomment{solution}
\includecomment{notinsolution}

\begin{solution}
\specialcomment{solutionbox}
  {\begin{mdframed}[
    backgroundcolor=maincolor!5,
    leftline=false,
    rightline=false,
    linecolor=maincolor!70,
    linewidth=1pt,
  ]{\textcolor{maincolor}{\textbf{\textsf{Solution:}}}~}}
  {\end{mdframed}}
\end{solution}

\begin{notinsolution}
\specialcomment{notinsolutionbox} {} {}
\end{notinsolution}

% By default we include the solutions.
% Command used for excluding the solutions.
\newcommand{\withoutsolutions}{\excludecomment{solutionbox}
  \renewcommand{\nosolutionspagebreak}{\pagebreak}
  \renewcommand{\solutionspagebreak}{}
  \renewcommand{\correctitem}[1][]{\item }
}

\newcommand{\nosolutionspagebreak}{}
\newcommand{\solutionspagebreak}{\pagebreak}
