# Makefile para compilar examenes LaTeX

LATEX ?= pdflatex
LATEXFLAGS ?= -interaction=nonstopmode -halt-on-error

# Archivo por defecto
MAIN ?= ejemplo-examen-jz

# Todos los .tex del directorio actual
TEX_FILES := $(wildcard *.tex)
PDF_FILES := $(TEX_FILES:.tex=.pdf)

.PHONY: all ejemplo examen clean distclean help

all: $(MAIN).pdf

ejemplo: ejemplo-examen-jz.pdf

examen: RG-2026-1-ExamenFinal.pdf

# Compilacion generica por patron
%.pdf: %.tex
	$(LATEX) $(LATEXFLAGS) $<

# Limpia archivos auxiliares comunes de LaTeX
clean:
	rm -f *.aux *.log *.out *.toc *.lof *.lot *.fls *.fdb_latexmk *.synctex.gz

# Limpieza total: tambien elimina PDFs generados
distclean: clean
	rm -f $(PDF_FILES)

help:
	@echo "Objetivos disponibles:"
	@echo "  make            # compila $(MAIN).tex"
	@echo "  make all        # igual que make"
	@echo "  make ejemplo    # compila ejemplo-examen-jz.tex"
	@echo "  make examen     # compila RG-2026-1-ExamenFinal.tex"
	@echo "  make <nombre>.pdf  # compila cualquier <nombre>.tex"
	@echo "  make clean      # elimina auxiliares"
	@echo "  make distclean  # elimina auxiliares y PDFs"
