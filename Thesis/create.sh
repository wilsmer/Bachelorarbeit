#pdflatex -synctex=1 -interaction=nonstopmode Bachelorarbeit.tex

biber Bachelorarbeit
makeglossaries Bachelorarbeit

pdflatex -synctex=1 -interaction=nonstopmode Bachelorarbeit.tex
#pdflatex -synctex=1 -interaction=nonstopmode Bachelorarbeit.tex

