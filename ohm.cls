%----------------------------------------------------------------------
% Ohm-Doc LaTeX Class
% 
% Copyright (c) 2026, Marvin Fette
%
% Please read the README.md for instructions on how to use this template.
%----------------------------------------------------------------------
% Class identification
%----------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ohm}[2026/04/15 TeX Template for TH N\"{u}rnberg thesis]
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
\newif\ifrep
\DeclareOption{report}{\reptrue}
% Language for standard headings
\newif\ifde
\DeclareOption{german}{\detrue}
\newif\ifen
\DeclareOption{english}{\entrue}
% Cover layout
\newif\ifsinglepage
\DeclareOption{singlepage}{\singlepagetrue}
\DeclareOption{doublepage}{\singlepagefalse}
\ProcessOptions\relax
% Validate that a document type is set
\ifma\else\ifba\else\ifrep\else
	\ClassError{ohm}{Document type not set}{Set either master, bachelor, or report document type option}
\fi\fi\fi
%----------------------------------------------------------------------
% Class Loading
%----------------------------------------------------------------------
\LoadClass{report}
%----------------------------------------------------------------------
% Define the primary color for the document
%----------------------------------------------------------------------
\RequirePackage{xcolor}
\definecolor{ohmRed}{HTML}{C72426}
%----------------------------------------------------------------------
% Packages
%----------------------------------------------------------------------
\RequirePackage[T1]{fontenc}
\RequirePackage{setspace}
\RequirePackage{float}
\RequirePackage{url}
\RequirePackage[final]{graphicx}
\RequirePackage{ragged2e}
\RequirePackage{parskip}
\RequirePackage[utf8]{inputenc}
\RequirePackage[
	acronym,
	nonumberlist,
	nopostdot
]{glossaries}
\RequirePackage{environ}
\RequirePackage{blindtext}
\RequirePackage{svg}
\RequirePackage{caption}
%----------------------------------------------------------------------
% Useable Commands
%----------------------------------------------------------------------
% Abstract and Kurzdarstellung storage
\newcommand{\theabstract}{}
\RenewEnviron{abstract}{\global\let\theabstract\BODY}
\newcommand{\thekurzdarstellung}{}
\NewEnviron{kurzdarstellung}{\global\let\thekurzdarstellung\BODY}
% Acknowledgements storage
\newcommand{\theacknowledgements}{}
\NewEnviron{acknowledgements}{\global\let\theacknowledgements\BODY}
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
% Command to create a list of keywords for the title page, supports multiple keywords
\newcommand{\thekeywords}{}
\newif\ifhasKeywords
\newif\ifhasMultipleKeywords
\newcommand{\keyword}[1]
{
	\ifhasKeywords
		\expandafter\def\expandafter\thekeywords\expandafter{\thekeywords, #1}
		\hasMultipleKeywordstrue
	\else
		\expandafter\def\expandafter\thekeywords\expandafter{#1}
	\fi
	\hasKeywordstrue
}
% Command to reference a repository
\newcommand{\therepository}{}
\newif\ifhasRepository
\newcommand{\repository}[1]
{
	\expandafter\def\expandafter\therepository\expandafter{#1}
	\hasRepositorytrue
}
% Command to reference a company for the title page
\newcommand{\thecompany}{}
\newif\ifhasCompany
\newcommand{\company}[1]
{
	\expandafter\def\expandafter\thecompany\expandafter{#1}
	\hasCompanytrue
}
% Command to declare the subject for the report
\newcommand{\thesubject}{}
\newif\ifhasSubject
\newcommand{\subject}[1]
{
	\expandafter\def\expandafter\thesubject\expandafter{#1}
	\hasSubjecttrue
}
%----------------------------------------------------------------------
% Paper and format settings
%----------------------------------------------------------------------
\RequirePackage[a4paper,right=2.75cm,left=2.75cm,top=3.5cm]{geometry}
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\renewcommand{\headrulewidth}{0pt}
\captionsetup[table]{position=bottom}
\captionsetup{width=0.95\textwidth} 
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}
%----------------------------------------------------------------------
% Code listings
%----------------------------------------------------------------------
\RequirePackage{minted}
\setminted{xleftmargin=2\parindent,linenos,breaklines,numbersep=10pt}
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
	\else \ifrep \newcommand{\type}{Bericht}
	\fi\fi\fi
	% Override list and reference names
	\renewcommand{\contentsname}{Inhaltsverzeichnis}
	\renewcommand{\listtablename}{Tabellenverzeichnis}
	\renewcommand{\listfigurename}{Abbildungsverzeichnis}
	\renewcommand{\listoflistingscaption}{Quellcodeverzeichnis}
	\renewcommand{\bibname}{Referenzen}
\else
	\ifen
		% Redefine standard names for English
		\newcommand{\faculty}{Faculty of Computer Science}
		% Set standard names
		\ifma \newcommand{\type}{Master Thesis}
		\else \ifba \newcommand{\type}{Bachelor Thesis}
		\else \ifrep \newcommand{\type}{Report}
		\fi\fi\fi
		% Override list and reference names
		\renewcommand{\contentsname}{Table of Contents}
		\renewcommand{\listtablename}{List of Tables}
		\renewcommand{\listfigurename}{List of Figures}
		\renewcommand{\listoflistingscaption}{List of Listings}
		\renewcommand{\bibname}{References}
	\else
		\ClassError{ohm}{Language not set}{Set either de or en language option}
	\fi
\fi
%----------------------------------------------------------------------
% Hyperref and PDF metadata
%----------------------------------------------------------------------
% Write XMP metadata file with expanded macros before pdfx reads it
\newwrite\xmpdatafile
\AtBeginDocument{%
	\immediate\openout\xmpdatafile=\jobname.xmpdata\relax
	\immediate\write\xmpdatafile{\string\Title{\@title}}%
	\immediate\write\xmpdatafile{\string\Author{\@author}}%
	\immediate\write\xmpdatafile{\string\Keywords{\thekeywords}}%
	\immediate\closeout\xmpdatafile
}
\RequirePackage[a-2b,mathxmp]{pdfx}
\RequirePackage[hyperpageref]{backref}
\ifde
	\renewcommand*{\backref}[1]{}
	\renewcommand*{\backrefalt}[4]{%
		\ifcase #1 (Nicht zitiert.)%
		\or (Zitiert auf Seite~#2.)%
		\else (Zitiert auf Seiten~#2.)%
		\fi
	}
\else
	\renewcommand*{\backref}[1]{}
	\renewcommand*{\backrefalt}[4]{%
		\ifcase #1 (Not cited.)%
		\or (Cited on page~#2.)%
		\else (Cited on pages~#2.)%
		\fi
	}
\fi
% Implement a command for full references that include both the number and the name of the referenced element
\newcommand*{\fullref}[1]{\hyperref[{#1}]{\ref*{#1}\mbox{,}~\nameref*{#1}}}

% Set PDF metadata
\hypersetup{%
	bookmarksopen=true,
	bookmarksnumbered=true,
	bookmarksopenlevel=1,
	plainpages=false,
	hypertexnames=true,
	linktocpage=true
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
	\ifde \bibliographystyle{format/deIEEEtran}
	\else \bibliographystyle{ieeetr}
	\fi
\else
	\ifwmaainf
		\bibliographystyle{format/wmaainf}
	\else
		\ClassError{ohm}{Bibliography style not set}{Set either ieee or wmaainf bibliography style}
	\fi
\fi
%----------------------------------------------------------------------
% Title page definition
%----------------------------------------------------------------------
\renewcommand{\maketitle}{
	\begin{titlepage}
		% first page
		\thispagestyle{empty}
		\centering
		\ifsinglepage
			\footnotesize
			\faculty\;\ifen at \else an der \fi Technische Hochschule N\"{u}rnberg\\[2ex]
			\normalsize
			\vspace*{8ex}
		\else
			\vspace*{4ex}
		\fi
		\includesvg[width=0.9\linewidth]{figures/ohm-logo.svg}\\[1cm]
		\Large
		\type {\;\ifrep \ifen at \else in \fi\fi}\\
		\ifrep
			\ifhasSubject
				\vspace*{4ex}
				\large
				\thesubject\\
				\vspace*{4ex}
			\else
				\vspace*{8ex}
			\fi
		\else
			\vspace*{8ex}
		\fi
		\huge
		\@title\\
		\vspace*{8ex}
		\Large
		\@author\\
		\ifsinglepage
			\vspace*{8ex}
			\large
			\begin{center}
			\begin{tabular}{l p{0.4\textwidth}}
				\ifhasExaminers
					\ifde Pr\"{u}fer: \else \ifhasMultipleExaminers Examiners: \else Examiner: \fi \fi & \theexaminers\\[1.2ex]
				\fi
				\ifhasSupervisors
					\ifde Betreuer: \else \ifhasMultipleSupervisors Supervisors: \else Supervisor: \fi \fi & \thesupervisors$^*$\\[0.4ex]
				\fi
			\end{tabular}
			\end{center}
			\vspace*{\fill}
			\footnotesize
			\singlespacing
			\begin{center}
				\copyright\;\;\ifhasCompany \thecompany \else \@author \fi,\;\the\year
			\end{center}
			\justifying
			\singlespacing
			\ifen
				\noindent This work, including its parts, \textbf{is protected by copyright}. Any use outside the narrow limits of copyright law without the consent of \ifhasCompany \thecompany~ \else the author \fi is prohibited and punishable by law. This applies in particular to reproductions, translations, microfilming and storage and processing in electronic systems.
			\else
				\noindent Diese Arbeit, einschließlich ihrer Teile, \textbf{ist urheberrechtlich geschützt}. Jede Verwertung außerhalb der engen Grenzen des Urheberrechtsgesetzes ohne Zustimmung von \ifhasCompany \thecompany~ \else dem Urheber \fi ist untersagt und strafbar. Dies gilt insbesondere für Vervielfältigungen, Übersetzungen, Mikroverfilmung und die Speicherung und Verarbeitung in elektronischen Systemen.
			\fi
			\singlespacing
			\ifhasCompany
				\footnoterule
				$^*${\footnotesize \ifen Supervisors at \else Betreuer bei \fi \thecompany}
			\fi
		\else
			\vspace*{\fill}
			\footnotesize
			\faculty\;\ifen at \else an der \fi Technische Hochschule N\"{u}rnberg\\
			\textsc{N\"{u}rnberg \the\year}
			% second page
			\clearpage
			\thispagestyle{empty}
			\vspace*{7ex}
			\Large
			\faculty\;\ifen at \else an der \fi Technische Hochschule N\"{u}rnberg\\
			\vspace*{4ex}
			\@author\\
			\huge
			\vspace*{2ex}
			\textbf{\@title}\\
			\vspace*{16ex}
			\large
			\begin{center}
			\begin{tabular}{l p{0.4\textwidth}}
				\ifhasExaminers
					\ifde Pr\"{u}fer: \else \ifhasMultipleExaminers Examiners: \else Examiner: \fi \fi & \theexaminers\\[1.2ex]
				\fi
				\ifhasSupervisors
					\ifde Betreuer: \else \ifhasMultipleSupervisors Supervisors: \else Supervisor: \fi \fi & \thesupervisors$^*$\\[0.4ex]
				\fi
			\end{tabular}
			\end{center}
			\vspace*{\fill}
			\footnotesize
			\singlespacing
			\begin{center}
				\copyright\;\;\ifhasCompany \thecompany \else \@author \fi,\;\the\year
			\end{center}
			\justifying
			\singlespacing
			\ifen
				\noindent This work, including its parts, \textbf{is protected by copyright}. Any use outside the narrow limits of copyright law without the consent of \ifhasCompany \thecompany~ \else the author \fi is prohibited and punishable by law. This applies in particular to reproductions, translations, microfilming and storage and processing in electronic systems.
			\else
				\noindent Diese Arbeit, einschließlich ihrer Teile, \textbf{ist urheberrechtlich geschützt}. Jede Verwertung außerhalb der engen Grenzen des Urheberrechtsgesetzes ohne Zustimmung von \ifhasCompany \thecompany~ \else dem Urheber \fi ist untersagt und strafbar. Dies gilt insbesondere für Vervielfältigungen, Übersetzungen, Mikroverfilmung und die Speicherung und Verarbeitung in elektronischen Systemen.
			\fi
			\singlespacing
			\ifhasCompany
				\footnoterule
				$^*${\footnotesize \ifen Supervisors at \else Betreuer bei \fi \thecompany}
			\fi
		\fi
	\end{titlepage}
}
%----------------------------------------------------------------------
% Table of content
%----------------------------------------------------------------------
\newcommand{\maketableofcontents}{
	\pdfbookmark[0]{\contentsname}{contents}
	\tableofcontents
}
%----------------------------------------------------------------------
% Abstract, Keywords, and Kurzdarstellung
%----------------------------------------------------------------------
\newcommand{\makeabstract}{
	\chapter*{\ifde Kurzdarstellung\else Abstract\fi}
	\label{ch:abstract}
	\ifen
		\theabstract
	\else
		\thekurzdarstellung
	\fi
	\section*{\ifde Schlagwörter\else Keywords\fi}
	\label{sec:keywords}
	\thekeywords
	\pagebreak
	\ifen
		\thispagestyle{empty}
		\section*{\ifde Kurzdarstellung\else Kurzdarstellung\fi}
		\label{sec:kurzdarstellung}
		\thekurzdarstellung
	\fi
}
%----------------------------------------------------------------------
% Acknowledgements
%----------------------------------------------------------------------
\newcommand{\makeacknowledgements}{
	\ifrep
	\else
		\ifx\theacknowledgements\empty\else
			\chapter*{\ifde Danksagung\else Acknowledgements\fi}
			\label{ch:acknowledgements}
			\theacknowledgements
		\fi
	\fi
}
%----------------------------------------------------------------------
% Acronyms
%----------------------------------------------------------------------
\newcommand{\makeacronyms}{
	\begin{small}
		\printnoidxglossary[type=\acronymtype,title={\ifde Abk\"{u}rzungsverzeichnis\else List of Acronyms\fi}]
	\end{small}
}
%----------------------------------------------------------------------
% Glossary and Lexicon
%----------------------------------------------------------------------
\newcommand{\makelexicon}{
	\begin{small}
		\printnoidxglossary[type=main,title={\ifde Glossar\else Glossary\fi}]
	\end{small}
}
%----------------------------------------------------------------------
% Bibliography
%----------------------------------------------------------------------
\newcommand{\makebibliography}{
	\begin{small}
		\bibliography{refs}
	\end{small}
}