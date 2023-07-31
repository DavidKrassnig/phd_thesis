%!/bin/bash
if test -f "main_digital.tex"; then
	pdflatex main_digital.tex
else
	exit 1
fi

biber main_digital

pdflatex main_digital.tex

if test -f "main_digital.pdf"; then
	ps2pdf14 -dPDFSETTINGS=/prepress main_digital.pdf main_online.pdf
else
	exit 1
fi

if test -f "main_online.pdf"; then
	rm main_digital.pdf
    mv main_online.pdf main_digital.pdf
else
	exit 1
fi


if test -f "main_print.tex"; then
	pdflatex main_print.tex
else
	exit 1
fi

biber main_print
pdflatex main_print.tex
if test -f "main_digital.pdf"; then
	ps2pdf14 -dPDFSETTINGS=/prepress main_print.pdf main_offline.pdf
else
	exit 1
fi
if test -f "main_offline.pdf"; then
	rm main_print.pdf
    mv main_offline.pdf main_print.pdf
else
	exit 1
fi

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
echo "Done."
