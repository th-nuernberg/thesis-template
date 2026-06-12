%----------------------------------------------------------------------
% Ohm-Expose LaTeX Class
% 
% Copyright (c) 2026, Marvin Fette
%
% Please read the README.md for instructions on how to use this template.
%----------------------------------------------------------------------
% Class identification
%----------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{expose}[2026/06/02 TeX Template for TH N\"{u}rnberg expose]
%----------------------------------------------------------------------
% Class Options
%----------------------------------------------------------------------
% Bibiliography reference style
\newif\ifieee
\DeclareOption{ieee}{\ieeetrue}
\newif\ifwmaainf
\DeclareOption{wmaainf}{\wmaainftrue}
% Document Type
\newif\ifma
\DeclareOption{master}{\matrue}
\newif\ifba
\DeclareOption{bachelor}{\batrue}
% Language for standard headings
\newif\ifde
\DeclareOption{german}{\detrue}
\newif\ifen
\DeclareOption{english}{\entrue}
\ProcessOptions\relax
% Validate that a document type is set
\ifma\else\ifba\else
	\ClassError{expose}{Document type not set}{Set either master or bachelor document type option}
\fi\fi
%----------------------------------------------------------------------
% Class Loading
%----------------------------------------------------------------------
\LoadClass[11pt]{article}
%----------------------------------------------------------------------
% Define the primary color for the document
%----------------------------------------------------------------------
\RequirePackage{xcolor}
\definecolor{ohmRed}{HTML}{C72426}
%----------------------------------------------------------------------
% Packages
%----------------------------------------------------------------------
\RequirePackage{fancyhdr}
\RequirePackage[compact]{titlesec}
\RequirePackage{setspace}
\RequirePackage{multicol}
\RequirePackage{lastpage}
\RequirePackage{parskip}
\RequirePackage{blindtext}
\RequirePackage[colorlinks=true, allcolors=ohmRed]{hyperref}
\RequirePackage{etoolbox}
\RequirePackage{pgfgantt}
%----------------------------------------------------------------------
% Useable Commands
%----------------------------------------------------------------------
% Command to add a supervisor to the title page, supports multiple supervisors
\newcommand{\thesupervisors}{}
\newif\ifhasSupervisors
\newif\ifhasMultipleSupervisors
\newcommand{\supervisor}[1]
{
	\ifhasSupervisors
		\expandafter\def\expandafter\thesupervisors\expandafter{\thesupervisors \newline #1}
		\hasMultipleSupervisorstrue
	\else
		\expandafter\def\expandafter\thesupervisors\expandafter{#1}
	\fi
	\hasSupervisorstrue
}
% Command to add an examiner to the title page, supports multiple examiners
\newcommand{\theexaminers}{}
\newif\ifhasExaminers
\newif\ifhasMultipleExaminers
\newcommand{\examiner}[1]
{
	\ifhasExaminers
		\expandafter\def\expandafter\theexaminers\expandafter{\theexaminers \newline #1}
		\hasMultipleExaminerstrue
	\else
		\expandafter\def\expandafter\theexaminers\expandafter{#1}
	\fi
	\hasExaminerstrue
}
% Command to set the first examiner on the title page
\newcommand{\thefirstexaminer}{}
\newcommand{\firstexaminer}[1]
{
	\expandafter\def\expandafter\thefirstexaminer\expandafter{#1}
}
% Command to reference a company for the title page
\newcommand{\thecompany}{}
\newif\ifhasCompany
\newcommand{\company}[1]
{
	\expandafter\def\expandafter\thecompany\expandafter{#1}
	\hasCompanytrue
}
%----------------------------------------------------------------------
% Paper and format settings
%----------------------------------------------------------------------
\RequirePackage[a4paper, top=1.5cm, bottom=3cm, left=2cm, right=2cm, nomarginpar, includehead]{geometry}
\setlength\columnsep{.8cm}
\renewcommand{\labelenumii}{\arabic{enumi}.\arabic{enumii}}
%----------------------------------------------------------------------
% Geometry settings for landscape pages
%----------------------------------------------------------------------
\def\ifGm@preamble#1{\@firstofone}
\appto\restoregeometry{%
	\pdfpagewidth=\paperwidth
	\pdfpageheight=\paperheight}
\apptocmd\newgeometry{%
	\pdfpagewidth=\paperwidth
	\pdfpageheight=\paperheight}{}{}
%----------------------------------------------------------------------
% Language settings
%----------------------------------------------------------------------
\ifde
	% Import German language settings
	\RequirePackage[english, ngerman]{babel}
	% Redefine standard names for German
	\newcommand{\faculty}{Fakult\"{a}t Informatik}
	% Set standard names
	\ifma \newcommand{\type}{Masterarbeit}
	\else \ifba \newcommand{\type}{Bachelorarbeit}
	\fi\fi
	\renewcommand{\refname}{Referenzen}
\else
	\ifen
		% Redefine standard names for English
		\newcommand{\faculty}{Faculty of Computer Science}
		% Set standard names
		\ifma \newcommand{\type}{Master Thesis}
		\else \ifba \newcommand{\type}{Bachelor Thesis}
		\fi\fi
		% Override list and reference names
		\renewcommand{\refname}{References}
	\else
		\ClassError{expose}{Language not set}{Set either de or en language option}
	\fi
\fi
%----------------------------------------------------------------------
% Header & Footer
%----------------------------------------------------------------------
\setlength{\headheight}{15pt}
\renewcommand{\headrulewidth}{0pt}
\pagenumbering{arabic}
\fancyhead{}\fancyfoot{}
% Set diff header & footer for the first page
\fancypagestyle{firstpage}{
	\fancyhead[C]{{\footnotesize \faculty\;\ifen at \else an der \fi Technische Hochschule N\"{u}rnberg \ifhasCompany\ifen and \else und \fi \thecompany\fi}}
	\fancyfoot[C]{{\footnotesize \textsc{N\"{u}rnberg \the\year}}}
}
% Following pages
\fancypagestyle{pages}{
	\fancyhead[C]{{\footnotesize Expose: \@title}}
	\fancyfoot[C]{\footnotesize \ifen Page \else Seite \fi \thepage\;\ifen of\else von\fi\;\pageref*{LastPage}}
}
%----------------------------------------------------------------------
% Landscape page environment
%----------------------------------------------------------------------
\newenvironment{landscapepage}{
	\clearpage
	\newgeometry{top=1.5cm, bottom=3cm, left=2cm, right=2cm, nomarginpar, includehead, landscape}
	\setlength{\headwidth}{\textwidth}
	\thispagestyle{pages}
}{
	\clearpage
	\restoregeometry
	\setlength{\headwidth}{\textwidth}
}
%----------------------------------------------------------------------
% Shortcuts
%----------------------------------------------------------------------
\newcommand{\ua}{\mbox{u.\,a.\ }}
\newcommand{\zB}{\mbox{z.\,B.\ }}
\newcommand{\dahe}{\mbox{d.\,h.,\ }}
\newcommand{\bzw}{\mbox{bzw.\ }}
\newcommand{\bzgl}{\mbox{bzgl.\ }}
\newcommand{\eg}{\mbox{e.\,g.\ }}
\newcommand{\ie}{\mbox{i.\,e.\ }}
\newcommand{\wrt}{\mbox{w.\,r.\,t.\ }}
\newcommand{\etal}{\mbox{\emph{et\,al.\ }}}
%---------------------------------------------------------------------
% bibliography settings
%---------------------------------------------------------------------
% Set bibliography style based on class options
\ifieee
	\ifde \bibliographystyle{../format/deIEEEtran}
	\else \bibliographystyle{ieeetr}
	\fi
\else
	\ifwmaainf
		\bibliographystyle{../format/wmaainf}
	\else
		\ClassError{expose}{Bibliography style not set}{Set either ieee or wmaainf bibliography style}
	\fi
\fi
%----------------------------------------------------------------------
% Title definition
%----------------------------------------------------------------------
\renewcommand{\maketitle}{{
	\raggedright 
	\begin{center}
		{\huge \bfseries \@title}\\[4ex]
		{\large \@author, Expose for a \type%
		\ifhasExaminers, \ifhasMultipleExaminers Examiners\else Examiner\fi: \theexaminers\fi%
		\ifhasSupervisors, \ifhasMultipleSupervisors Supervisors\else Supervisor\fi: \thesupervisors\fi}\\[8ex]
	\end{center}
}}
%----------------------------------------------------------------------
% Bibliography
%----------------------------------------------------------------------
\newcommand{\makebibliography}{
	\begin{small}
		\bibliography{../refs}
	\end{small}
}