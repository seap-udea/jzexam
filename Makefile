# Makefile for compiling LaTeX exams with jzexam
# Author: Jorge I. Zuluaga (C) 2026-present
# Repository: https://github.com/seap-udea/jzexam

LATEX ?= pdflatex
LATEXFLAGS ?= -interaction=nonstopmode -halt-on-error

# Default file to compile
MAIN ?= jztemplate

# All .tex files in the current directory
TEX_FILES := $(wildcard *.tex)
PDF_FILES := $(TEX_FILES:.tex=.pdf)

.PHONY: all template clean distclean help

all: $(MAIN).pdf

template: jztemplate.pdf

# Generic pattern rule: compile any .tex to .pdf
%.pdf: %.tex
	$(LATEX) $(LATEXFLAGS) $<

# Remove common LaTeX auxiliary files
clean:
	rm -f *.aux *.log *.out *.toc *.lof *.lot *.fls *.fdb_latexmk *.synctex.gz

# Full clean: also remove generated PDFs
distclean: clean
	rm -f $(PDF_FILES)

help:
	@echo "Available targets:"
	@echo "  make              # compile $(MAIN).tex"
	@echo "  make all          # same as make"
	@echo "  make template     # compile jztemplate.tex"
	@echo "  make <name>.pdf   # compile any <name>.tex"
	@echo "  make clean        # remove auxiliary files"
	@echo "  make distclean    # remove auxiliary files and PDFs"
