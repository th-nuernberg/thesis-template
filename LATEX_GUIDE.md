# LaTeX Guide

This guide covers common LaTeX patterns used in this template.
For a general introduction to LaTeX, see the [Overleaf Learn LaTeX](https://www.overleaf.com/learn) documentation.

## Acronyms

Define acronyms in `glossary.tex`:

```tex
\newacronym{key}{Short}{Long Name}
```

Use an acronym in the text with:

```tex
\gls{key}
```

On first use, LaTeX prints the long form followed by the acronym, for example `Long Name (Short)`.
On later uses, it prints only the short form.

To capitalize the first letter, use:

```tex
\Gls{key}
```

Use the plural form with:

```tex
\glspl{key}
```

By default, this usually adds an `s`.
If you need a custom plural form, define it when creating the acronym:

```tex
\newacronym[shortplural={Shorts}]{key}{Short}{Long Name}
```

## Glossary Entries

Define glossary entries in `glossary.tex`:

```tex
\newglossaryentry{library}{
    name=library,
    description={A collection of pre-compiled routines that a program can use}
}
```

Use a glossary entry in the text with:

```tex
\gls{library}
```

## Citations

Add bibliographic entries to `refs.bib`:

```bibtex
@book{Goodliffe2007,
  author = {Pete Goodliffe},
  title = {Code Craft},
  year = {2007},
  publisher = {No Starch Press}
}
```

Cite a source by using its key from `refs.bib`:

```tex
\cite{Goodliffe2007}
```

## Footnotes

Place footnotes directly where they should appear in the text:

```tex
This is a sentence with a footnote.\footnote{This is the footnote text.}
```

## Figures, SVG and Draw.io

Prefer SVG over PNG for diagrams.
SVG files are vector graphics, so lines, text and shapes stay sharp when zoomed or printed.
PNG files are raster images and can become blurry when scaled.
Use PNG for screenshots or photos, but prefer SVG for architecture diagrams, flow charts and simple graphics.

Put figures in `figures/`.
Include an SVG figure like this:

```tex
\begin{figure}[ht]
    \centering
    \includesvg[width=0.8\textwidth]{figures/example.drawio.svg}
    \caption{Short description of the figure}
    \label{fig:example}
\end{figure}
```

Reference the figure in the text with:

```tex
\ref{fig:example}
```

Draw.io is useful for diagrams because the graphic remains editable later.
Export diagrams as `.drawio.svg` files.
This format can be included directly as SVG in LaTeX and still preserves the Draw.io editing data.

## Code Blocks

Code blocks are rendered with `minted`.
The template adds line numbers automatically and wraps long lines.

For short code snippets, write the code directly in the document:

```tex
\begin{listing}[htbp]
    \caption{Short Python example}
    \label{lst:example-inline}
    \begin{minted}{python}
x = 1
if x == 1:
    print("x is 1.")
    \end{minted}
\end{listing}
```

For longer code snippets, include the code from a separate file:

```tex
\begin{listing}[htbp]
    \caption{Python example from file}
    \label{lst:example-file}
    \inputminted{python}{code/example.py}
\end{listing}
```

Reference a listing in the text with:

```tex
\ref{lst:example-file}
```

For other languages, replace `python` with another language name, such as `java`, `bash`, `json` or `text`.
Because `minted` provides syntax highlighting, LaTeX must be run with `shell-escape`.
This is already configured in the `Makefile`.