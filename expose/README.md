# LaTeX Template for a Thesis Expose at TH Nürnberg

Basic template to write a thesis expose at the [Technische Hochschule Nürnberg Georg Simon Ohm](https://www.th-nuernberg.de/).

Writing an expose is a great way to align your understanding of the thesis topic with your supervisors and is a good basis for discussing the expectations of your thesis.

The expose is also a good chance to put your academic writing to the test, so take the tips in the [main README](../README.md#a-few-tips-for-writing-your-thesis) file into account. The expose should not exceed the page limit of two pages.

[Template options](../README.md#template-options) (minus the report cover layout options) and usage are the same as for the thesis template class.

> [!NOTE]
> The expose uses the same BibTeX file as the thesis template, located at the root path `refs.bib`.

## Optional sections

The content of the expose depends on the understanding you already have of the topic you are working on. Focus on a good description of the problem first before progressing. Once you have described the approach well, it may make sense to include the optional *outline* and *time schedule* sections in the `expose.tex` document.

## Building the expose

Build the expose by running `make expose` from the repository root, or open TeX files inside `expose/` in VS Code and use the LaTeX Workshop extension.
