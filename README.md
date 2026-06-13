# LaTeX Template for Theses and Reports at TH Nürnberg

Basic template for reports, bachelor's theses and master's theses at the [Technische Hochschule Nürnberg Georg Simon Ohm](https://www.th-nuernberg.de/). This version of the template is intended for digital `PDF/A-2b` compliant submissions.

When working on Windows, it is recommended to use [TeX Live](https://wiki.ubuntuusers.de/TeX_Live/) and [VS Code](https://code.visualstudio.com/) on [WSL2](https://learn.microsoft.com/de-de/windows/wsl/install) rather than using any other IDE for Windows. Alternatively, you can use `make` directly or upload the template to Overleaf.

> [!WARNING]
> The `master` branch is a refactoring and is build to be compatible with the new digital Thesis Platform of Computer Science Faculty. This Version does not create out of the box a book print format. If you want to use the "old" book print format, please checkout the Branch [`book-print`](https://github.com/th-nuernberg/thesis-template/tree/book-print).

If you are new to LaTeX, get familiar with its syntax first by reading the [LaTeX Guide](LATEX_GUIDE.md).

## Template options

The template class, selected with `\documentclass` in `document.tex`, provides three options:

- **Bibliography Style**: Switch between `ieee` and `wmaainf` BibTeX style.
- **Type of Document**: Switch between `master`, `bachelor` and `report` layout.
- **Language Setting**: Switch between `german` and `english`, which automatically translates most of the layout.
- **Cover Layout**: Switch between `singlepage` and `doublepage` to toggle the length of the cover page. The amount of information will be the same.

> [!IMPORTANT]
> This template uses the [shell escape](https://tex.stackexchange.com/a/88741) option in Make and the LaTeX Workshop extension for VS Code to optimize compile time when including figures. If you have security concerns about this, adjust the `Makefile` or `.vscode/settings.json`. Usually, this setting can be left untouched.

## Getting started: writing a thesis expose

A good start for a thesis is to write an expose for the thesis topic. This repository also provides an expose template written in LaTeX; more about the expose can be found in the [expose README](expose/README.md) file.

## A few tips for writing your thesis

- Create a branch for your thesis; this allows you to easily sync with upstream (this repository).
- Disable automatic hard line wrap (with newlines); use soft wrap instead. [(What's that about?)](https://stackoverflow.com/questions/319925/difference-between-hard-wrap-and-soft-wrap)
- Write one sentence per line -- this makes for nice diffs in git.
- For capitalization of headings, follow the [IEEE Style Manual](https://journals.ieeeauthorcenter.ieee.org/your-role-in-article-production/ieee-editorial-style-manual/).
- Use UTF-8 encoding for your files to make special characters work.
- Keep your literature up to date -- add references to your bib file as you read them.

## Other resources regarding your thesis

- [Informationen Fakultät Informatik](https://elearning.ohmportal.de/mod/page/view.php?id=203579) (German, Ohm intranet)
- [Wie schreibe ich eine Abschlussarbeit](https://www.in.th-nuernberg.de/Professors/Weber/Abschlussarbeit%20Methodik.pdf) by Prof. Dr. Rainer Weber (German, Ohm intranet).
- [Overleaf Learn LaTeX](https://www.overleaf.com/learn)
