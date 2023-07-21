%!/bin/bash
if test -f "main.tex"; then
	pdflatex main.tex
else
	exit 1
fi

biber main

pdflatex main.tex

if test -f "main.pdf"; then
	ps2pdf14 -dPDFSETTINGS=/prepress main.pdf main_online.pdf
else
	exit 1
fi

cp mitthesis_offline.cls mitthesis.cls

pdflatex main.tex
ps2pdf14 -dPDFSETTINGS=/prepress main.pdf main_offline.pdf

cp mitthesis_online.cls mitthesis.cls

echo "Deleting auxiliary files..."
find . -name "*.aux" -type f -delete
find . -name "*.toc" -type f -delete
find . -name "*.out" -type f -delete
find . -name "*.log" -type f -delete
find . -name "*.synctex.gz" -type f -delete
find . -name "*.bbl" -type f -delete
find . -name "*.bcf" -type f -delete
find . -name "*.blg" -type f -delete
find . -name "*.lof" -type f -delete
find . -name "*.lot" -type f -delete
find . -name "*.run.xml" -type f -delete
rm main.pdf
echo "Done."
