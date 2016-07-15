pkg = reda
cprt = COPYRIGHT

Rpkg: Rd build
	make check
	make INSTALL

Rd:
	Rscript -e "library(methods); roxygen2::roxygenise();"

build:
	R CMD build ../$(pkg)

check: $(pkg)_*.tar.gz
	R CMD check --as-cran $(pkg)_*.tar.gz

INSTALL: $(pkg)_*.tar.gz
	R CMD INSTALL --build $(pkg)_*.tar.gz

## update copyright year in HEADER, R script and date in DESCRIPTION
updateHeader:
	yr=$$(date +"%Y");\
	sed -i "s/Copyright (C) 2015-[0-9]\{4\}/Copyright (C) 2015-$$yr/" $(cprt);\
# add HEADER file if there is no header
	for Rfile in R/*.R; do \
	if ! grep -e 'Copyright (C)' $$Rfile ;\
	then cat $(cprt) $$Rfile > tmp ;\
	mv tmp $$Rfile;\
	fi;\
	yr=$$(date +"%Y");\
	sed -i "s/Copyright (C) 2015-[0-9]*/Copyright (C) 2015-$$yr/" $$Rfile;\
	done;\
	dt=$$(date +"%Y-%m-%d");\
	sed -i "s/Date: [0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}/Date: $$dt/" DESCRIPTION;

clean:
	rm -rf *~ */*~ */*.Rd *.Rhistroy NAMESPACE *.tar.gz *.Rcheck/ .\#*
