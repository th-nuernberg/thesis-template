% This is WMAAINF.BST in text format, as of Jan 31, 1988.
% Abteilung f"ur Angewandte Informatik bibliography style
%    alphanumeric labels, aphabetical order,
%    journals not abbreviated,
%    quotes around article titles,
%    much like the "plain" and IEEE family, from which this is adapted.
%
%   History
%   1/31/88 (WM) Original version, by Walter M"ulner,
%                Institute of Statistics and Computer Science, Univ. Vienna,
%                Dept. of Applied Inf. Science
%
%   05/22/89 (WM) something curious happened: our well working
%                Bibstyle wasn't accepted by this hirngespinstig
%                new version of BIBTEX from Oren Patashnig.
%                --> change all postfix notations (ha ha!)
%   DO NOT MAKE ANY!! changes to this style without consulting the author
%
ENTRY
  { address
    author
    booktitle
    chapter
    edition
    editor
    howpublished
    institution
    journal
    key
    month
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    type
    volume
    year
  }
  {}
  {label extra.label sort.label}
 
 
 
INTEGERS { output.state before.all mid.sentence mid.sentenceb
           after.sentence after.block }
 
FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'mid.sentenceb  :=
  #3 'after.sentence  :=
  #4 'after.block :=
}
 
STRINGS { s t }
FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state mid.sentenceb =
        { " " * write$ }
        { output.state after.block =
            { add.period$ write$
              newline$
              "\newblock " write$
            }
            { output.state before.all =
                'write$
                { add.period$ " " * write$ }
              if$
            }
          if$
        }
      if$
    }
  if$
  mid.sentence 'output.state :=
  s
}
 
FUNCTION {output}
{ 's :=
  s "" =
    'skip$
    { s output.nonnull }
  if$
}
 
FUNCTION {output.check}
{ 's :=
  't :=
  s "" =
    { "Warning: the " t * " shouldn't be empty in " * cite$ * top$ }
    { s output.nonnull }
  if$
}
 
FUNCTION {output.bibitem}
{ newline$
 
  "\bibitem[" write$
  label write$
  "]{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}
 
%  FUNCTION {blank.sep}
%  { mid.sentenceb 'output.state :=
%  }
 
FUNCTION {fin.entry}
{ add.period$
  write$
  newline$
}
 
FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
  if$
}
 
FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
        'skip$
        { after.sentence 'output.state := }
      if$
    }
  if$
}
 
FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}
 
FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}
 
FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}
 
FUNCTION {field.or.null}
{ duplicate$
  missing$
    { pop$ "" }
    'skip$
  if$
}
 
FUNCTION {italicize}
{ 's :=
  s "" =
    { "" }
    { "{\itshape " s * "}" * }
  if$
}
 
INTEGERS { nameptr namesleft numnames }
STRINGS {nameresult}
FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  "" 'nameresult :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    {
 
      s nameptr "{f.~}{vv~}{ll}{,~jj}" format.name$ 't :=
 
      nameptr #1 >
        { namesleft #1 >
            { nameresult ", " * t * 'nameresult := }
            { numnames #2 >
                { nameresult "," * 'nameresult := }
                'skip$
              if$
              t "others" = t "et.al." = or t "et. al." = or
                { nameresult " {\itshape et al.}" * 'nameresult := }
                { nameresult " and " * t * 'nameresult := }
              if$
            }
          if$
        }
        { nameresult t * 'nameresult := }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
  nameresult
}
 
FUNCTION {format.authors}
{ author missing$
    { "" }
    { author format.names }
  if$
}
 
FUNCTION {format.editors}
{ editor missing$
    { "" }
    { editor num.names$ #1 >
        { editor format.names ", Eds." * }
        { editor format.names ", Ed." * }
      if$
    }
  if$
}
 
FUNCTION {format.title}
 
{ title missing$
    { "" }
    { "``" title * "''" * }
  if$
 
}
 
FUNCTION {entry.string.max} { #100 }
 
FUNCTION {global.string.max} { #300 }
 
STRINGS {pageresult}
 
FUNCTION {n.dashify}
{ 't :=
  "" 'pageresult :=
    { t "" = not }
    { t #1 #1 substring$ "-" =
        { t #1 #2 substring$ "--" = not
            { pageresult "--" * 'pageresult :=
              t #2 global.string.max substring$ 't :=
            }
            {   { t #1 #1 substring$ "-" = }
                { pageresult "-" * 'pageresult :=
                  t #2 global.string.max substring$ 't :=
                }
              while$
            }
          if$
        }
        { pageresult t #1 #1 substring$ * 'pageresult :=
          t #2 global.string.max substring$ 't :=
        }
      if$
    }
  while$
  pageresult
}
 
FUNCTION {format.date}
{ year missing$
    { month missing$
        { "" }
        { "Warning: there's a month but no year in " cite$ * top$
          month
        }
      if$
    }
    { month missing$
        { year }
        { month " " * year * }
      if$
    }
  if$
}
 
FUNCTION {format.btitle}
{ title field.or.null
  italicize
}
 
FUNCTION {format.bvolume}
{ volume missing$
    { series missing$
        { "" }
        { series italicize }
      if$
    }
    { "Vol.~" volume *
      series missing$
        'skip$
        { " of " * series italicize * }
      if$
    }
  if$
}
 
FUNCTION {format.edition}
{ edition missing$
    { "" }
    { edition "l" change.case$ " Ed." * }
  if$
}
 
INTEGERS {multiresult}
FUNCTION {multi.page.check}
{ 't :=
  #0 'multiresult :=
    { multiresult not
      t "" = not
      and
    }
    { t #1 #1 substring$ "-" =
      t #1 #1 substring$ "," =
      or
        { #1 'multiresult := }
        { t #2 global.string.max substring$ 't := }
      if$
    }
  while$
  multiresult
}
 
FUNCTION {format.pages}
{ pages missing$
    { "" }
    { pages multi.page.check
        { "pp.~" pages n.dashify * }
        { "p.~" pages n.dashify * }
      if$
    }
  if$
}
 
FUNCTION {format.volume}
{ volume missing$
    { "" }
    { "Vol.~" volume * }
  if$
}
 
FUNCTION {format.number}
{ number missing$
    { "" }
    { "No.~" number * }
  if$
}
 
FUNCTION {format.chapter.pages}
{ chapter missing$
    'format.pages
    { "Chap.~" chapter *
      pages missing$
        'skip$
        { ", " * format.pages * }
      if$
    }
  if$
}
 
FUNCTION {format.in.ed.booktitle}
{ booktitle missing$
    { "" }
    { format.editors 't :=
      t "" =
        { "In: " booktitle italicize * }
        { "In: " t * ", " * booktitle italicize * }
      if$
    }
  if$
}
 
FUNCTION {format.tr.number}
{ type missing$
    { "Tech. Rep." }
    { type }
  if$
  number missing$
    'skip$
    { "~" * number * }
  if$
}
 
FUNCTION {article}
{ output.bibitem
  "author" format.authors output.check
  new.block
  "title" format.title output.check
  new.block
  "journal" journal field.or.null italicize output.check
  format.volume output
  format.number output
  format.pages output
  "year" format.date output.check
  new.block
  note field.or.null output
  fin.entry
}
 
FUNCTION {book}
{ output.bibitem
  author missing$
    { "author and editor" format.editors output.check }
    { "author" format.authors output.check }
  if$
  new.block
  "title" format.btitle output.check
  new.block
  format.bvolume output
  "publisher" publisher field.or.null output.check
  address field.or.null output
  format.edition output
  "year" format.date output.check
  new.block
  note field.or.null output
  fin.entry
}
 
FUNCTION {booklet}
{ output.bibitem
  format.authors output
  new.block
  "title" format.btitle output.check
  new.block
  howpublished field.or.null output
  address field.or.null output
  format.date output
  new.block
  note field.or.null output
  fin.entry
}
 
FUNCTION {inbook}
{ output.bibitem
  author missing$
    { "author and editor" format.editors output.check }
    { "author" format.authors output.check }
  if$
  new.block
  "title" format.btitle output.check
  "chapter and pages" format.chapter.pages output.check
  new.block
  format.bvolume output
  "publisher" publisher field.or.null output.check
  address field.or.null output
  format.edition output
  "year" format.date output.check
  new.block
  note field.or.null output
  fin.entry
}
 
FUNCTION {incollection}
{ output.bibitem
  "author" format.authors output.check
  new.block
  "title" format.title output.check
  new.block
  "booktitle" format.in.ed.booktitle output.check
  format.chapter.pages output
  "publisher" publisher field.or.null output.check
  address field.or.null output
  "year" format.date output.check
  new.block
  note field.or.null output
  fin.entry
}
 
FUNCTION {inproceedings}
{ output.bibitem
  "author" format.authors output.check
  new.block
  "title" format.title output.check
  new.block
  "booktitle" format.in.ed.booktitle output.check
  format.pages output
  organization field.or.null output
  publisher field.or.null output
  address field.or.null output
  "year" format.date output.check
  new.block
  note field.or.null output
  fin.entry
}
 
FUNCTION {conference} { inproceedings }
 
FUNCTION {manual}
{ output.bibitem
  format.authors output
  new.block
  "title" format.btitle output.check
  new.block
  organization field.or.null output
  address field.or.null output
  format.edition output
  format.date output
  new.block
  note field.or.null output
  fin.entry
}
 
FUNCTION {mastersthesis}
{ output.bibitem
  "author" format.authors output.check
  new.block
  "title" format.btitle output.check
  new.block
  "Master's thesis" output
  "school" school field.or.null output.check
  address field.or.null output
  "year" format.date output.check
  new.block
  note field.or.null output
  fin.entry
}
 
FUNCTION {misc}
{ output.bibitem
  format.authors output
  new.block
  format.title output
  new.block
  howpublished field.or.null output
  format.date output
  new.block
  note field.or.null output
  fin.entry
}
 
FUNCTION {phdthesis}
{ output.bibitem
  "author" format.authors output.check
  new.block
  "title" format.btitle output.check
  new.block
  "PhD thesis" output
  "school" school field.or.null output.check
  address field.or.null output
  "year" format.date output.check
  new.block
  note field.or.null output
  fin.entry
}
 
FUNCTION {proceedings}
{ output.bibitem
  editor missing$
    { organization missing$
        'skip$
        { organization field.or.null output }
      if$
    }
    { format.editors output }
  if$
  new.block
  "title" format.btitle output.check
  editor missing$
    'skip$
    { organization field.or.null output }
  if$
  publisher field.or.null output
  address field.or.null output
  "year" format.date output.check
  new.block
  note field.or.null output
  fin.entry
}
 
FUNCTION {techreport}
{ output.bibitem
  "author" format.authors output.check
  new.block
  "title" format.title output.check
  new.block
  format.tr.number output
  "institution" institution field.or.null output.check
  address field.or.null output
  "year" format.date output.check
  new.block
  note field.or.null output
  fin.entry
}
 
FUNCTION {unpublished}
{ output.bibitem
  "author" format.authors output.check
  new.block
  "title" format.title output.check
  new.block
  format.date output
  new.block
  "note" note field.or.null output.check
  fin.entry
}
 
FUNCTION {default.type}
{ "Warning: unknown entry: " type$ * " in " * cite$ * top$ }
 
MACRO {jan} {"Jan."}
MACRO {feb} {"Feb."}
MACRO {mar} {"March"}
MACRO {apr} {"Apr."}
MACRO {may} {"May"}
MACRO {jun} {"June"}
MACRO {jul} {"July"}
MACRO {aug} {"Aug."}
MACRO {sep} {"Sep."}
MACRO {oct} {"Oct."}
MACRO {nov} {"Nov."}
MACRO {dec} {"Dec."}
MACRO {acmcs} {"ACM Computing Surveys"}
MACRO {acta} {"Acta Informatica"}
MACRO {cacm} {"Communications ACM"}
MACRO {ibmjrd} {"IBM Journal of Research and Development"}
MACRO {ibmsj} {"IBM Systems Journal"}
MACRO {ieeese} {"IEEE Transactions on Software Engineering"}
MACRO {ieeetc} {"IEEE Transactions on Computers"}
MACRO {ieeetcad}
 {"IEEE Transactions on Computer-Aided Design of Integrated Circuits"}
MACRO {ipl} {"Information Processing Letters"}
MACRO {jacm} {"Journal of the ACM"}
MACRO {jcss} {"Journal of Computer and System Sciences"}
MACRO {scp} {"Science of Computer Programming"}
MACRO {sicomp} {"SIAM Journal on Computing"}
MACRO {tocs} {"ACM Transactions on Computer Systems"}
MACRO {tods} {"ACM Transactions on Database Systems"}
MACRO {tog} {"ACM Transactions on Graphics"}
MACRO {toms} {"ACM Transactions on Mathematical Software"}
MACRO {toois} {"ACM Transactions on Office Information Systems"}
MACRO {toplas} {"ACM Transactions on Programming Languages and Systems"}
MACRO {tcs} {"Theoretical Computer Science"}
 
READ
 
FUNCTION {sortify}
{ purify$
  "l" change.case$
}
 
FUNCTION {format.lab.names}
{ #1 "{ll}" format.name$
  duplicate$ duplicate$ " -> " swap$
  purify$ * * top$
  purify$
  #1 #4 substring$
  % nur erste 4 Zeichen des Namens als Citation-Key
}
 
FUNCTION {calc.label}
{
  author missing$
    { editor missing$
        { key missing$
            { "Warning: need a key to make a label in " cite$ * top$
              title field.or.null purify$ #1 #4 substring$
            }
            { key purify$
              #1 #8 substring$}
          if$
        }
        { editor format.lab.names}
      if$
    }
    { author format.lab.names}
  if$
  year field.or.null purify$ #-1 #2 substring$ 'sort.label :=
  sort.label "" =
    { skip$ }
    { "\," * sort.label * }
  if$
 
  'label
  :=
  label sortify 'sort.label :=
}
 
FUNCTION {sort.format.names}
{ 's :=
  #1 'nameptr :=
  "" 'nameresult :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
      { nameptr #1 >
        { nameresult "   " * 'nameresult := }
        'skip$
      if$
      s nameptr "{vv{ } }{ll{ }}{  ff{ }}{  jj{ }}" format.name$ 't :=
      nameptr numnames = t "others" = t "et.al." = or t "et. al." = or and
        { nameresult "et al" * 'nameresult := }
        { nameresult t sortify * 'nameresult := }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
      }
    while$
  nameresult
}
 
INTEGERS {len}
 
FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.string.max substring$ }
    { s }
  if$
}
 
FUNCTION {sort.format.title}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  #1 global.string.max substring$
  sortify
}
 
FUNCTION {presort}
{
  calc.label
  sort.label
  "    "
  *
  author missing$
    { editor missing$
        { key field.or.null sortify }
        { editor sort.format.names }
      if$
    }
    { author sort.format.names }
  if$
  *
  "    "
  *
  title field.or.null
  sort.format.title
  *
  #1 entry.string.max substring$
  'sort.key$ :=
}
 
ITERATE {presort}
 
SORT
 
STRINGS { longest.label last.sort.label next.extra }
 
INTEGERS { longest.label.width last.extra.num }
 
FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  "" 'last.sort.label :=
  "" 'next.extra :=
  #0 'longest.label.width :=
  #0 'last.extra.num :=
}
 
FUNCTION {forward.pass}
{ last.sort.label sort.label =
    { last.extra.num #1 + 'last.extra.num :=
      last.extra.num int.to.chr$ 'extra.label :=
    }
    { "a" chr.to.int$ 'last.extra.num :=
      "" 'extra.label :=
      sort.label 'last.sort.label :=
    }
  if$
}
 
FUNCTION {reverse.pass}
{ next.extra "b" =
    { "a" 'extra.label := }
    'skip$
  if$
  label extra.label * 'label :=
  label width$ longest.label.width >
    { label 'longest.label :=
      label width$ 'longest.label.width :=
    }
    'skip$
  if$
  extra.label 'next.extra :=
}
 
EXECUTE {initialize.longest.label}
 
ITERATE {forward.pass}
 
REVERSE {reverse.pass}
 
FUNCTION {preamble}
{
  preamble$ duplicate$ empty$
    'pop$
    { write$ newline$ }
  if$
  "\begin{thebibliography}{"  longest.label  * "}" * write$ newline$
}
 
EXECUTE {preamble}
 
EXECUTE {init.state.consts}
 
ITERATE {call.type$}
 
FUNCTION {finish.up} { newline$ "\end{thebibliography}" write$ newline$ }
 
EXECUTE {finish.up}
