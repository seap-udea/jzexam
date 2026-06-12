# jzexam — LaTeX Exam Package

**Author:** Jorge I. Zuluaga (C) 2026–present  
**Repository:** [https://github.com/seap-udea/jzexam](https://github.com/seap-udea/jzexam)  
**License:** GNU GPL v3

---

`jzexam` is a LaTeX package for typesetting academic exams. It provides a structured set of environments and commands for composing exams with problems, sub-questions, multiple-choice questions, answer keys, a formula sheet, and a fully customizable student header — all from a single `.sty` file.

---

## About

`jzexam` grew out of more than 20 years of hands-on experience writing LaTeX exams for university-level physics and astronomy courses. Over those two decades the author accumulated a set of recurring patterns — structured problem lists, togglable answer keys, multi-column choice layouts, per-page student headers — that were repeatedly copy-pasted across documents. `jzexam` formalises those patterns into a clean, reusable package.

The package was designed and coded with the assistance of AI agents using [Cursor](https://www.cursor.com/) and the **Claude Sonnet 4.6** model. Every feature was driven by real classroom needs, tested against actual exams, and refined through direct human review and iteration. The result is a tool that reflects both decades of pedagogical practice and modern AI-assisted software craftsmanship.

---

## Table of Contents

- [About](#about)
- [Installation](#installation)
  - [Local / command-line](#local--command-line)
  - [Overleaf](#overleaf)
- [Quick Start](#quick-start)
- [Package Options](#package-options)
- [Commands and Environments Reference](#commands-and-environments-reference)
  - [Exam Header](#exam-header)
  - [Header Fields](#header-fields)
  - [Problems](#problems)
  - [Questions](#questions)
  - [Multiple-Choice Questions](#multiple-choice-questions)
  - [Solutions and Answers](#solutions-and-answers)
  - [Formula Sheet](#formula-sheet)
  - [Page Breaks](#page-breaks)
  - [Visibility Controls](#visibility-controls)
- [Makefile Usage](#makefile-usage)
- [Template](#template)
- [Compiling Locally](#compiling-locally)
  - [macOS](#macos)
  - [Linux](#linux)
  - [Windows](#windows)

---

## Installation

All packages required by `jzexam` are part of a standard TeX Live or MiKTeX installation, so no extra package installation is needed beyond placing `jzexam.sty` where LaTeX can find it.

**Required LaTeX packages** (automatically loaded by `jzexam`):

| Package | Purpose |
|---------|---------|
| `xparse` | Extended command/environment definitions |
| `environ` | Body-capturing environments (`\NewEnviron`) |
| `enumitem` | Fine-grained list customization |
| `tabularx` | Flexible-width table columns |
| `multicol` | Multi-column layout for answer choices |
| `xcolor` | Colored text (used for solutions) |
| `fancyhdr` | Custom page headers and footers |
| `geometry` | Page margins (default 2.5 cm all around) |

### Local / command-line

Copy `jzexam.sty` into the same directory as your `.tex` file, or place it in a directory on your TeX search path (e.g., `~/texmf/tex/latex/jzexam/`).

### Overleaf

[Overleaf](https://www.overleaf.com) does not support custom package installation, but `jzexam` works out of the box because it is a single self-contained `.sty` file.

**Steps:**

1. Open (or create) your project in Overleaf.
2. Click **New File** (the **+** button in the file tree on the left).
3. Upload `jzexam.sty` from your local machine — place it at the **root** of the project (same level as your main `.tex` file).
4. In your `.tex` file, load the package as usual:

```latex
\usepackage[answers]{jzexam}   % answer-key version
% or
\usepackage[noanswers]{jzexam} % student version
```

5. Click **Recompile**. Overleaf will find `jzexam.sty` automatically because it searches the project root first.

**Using the template directly:**

The easiest way to get started on Overleaf is to upload both `jzexam.sty` and `jztemplate.tex` to a new project and compile `jztemplate.tex`. This gives you a working 3-page exam with all features demonstrated.

> **Tip — two-version workflow on Overleaf:** Duplicate the project (Menu → Copy Project) to keep one copy for the student version (`noanswers`) and one for the answer key (`answers`). Toggle the option in `\usepackage[...]{jzexam}` in each copy and compile separately.

---

## Quick Start

```latex
\documentclass[11pt]{article}

% Show answers (solution key mode)
\usepackage[answers]{jzexam}
% To hide answers (student version):
% \usepackage[noanswers]{jzexam}

\examinfo
  {Exam Title}
  {Department / Course / Semester}

\begin{document}
\makeexamheader

\begin{examproblems}

\begin{problem}{First Problem}[30]
Problem statement here.
\begin{questions}
  \question Derive an expression for X.
  \begin{solution}
    Solution text here (shown only in answer-key mode).
  \end{solution}
\end{questions}
\end{problem}

\end{examproblems}
\end{document}
```

---

## Package Options

Load the package with one of the following options:

| Option | Effect |
|--------|--------|
| `answers` | Shows all `solution` environments and correct-choice marks |
| `noanswers` | Hides all solutions and correct-choice marks (default) |

```latex
\usepackage[answers]{jzexam}    % answer-key / instructor version
\usepackage[noanswers]{jzexam}  % student version (default)
```

You can also toggle answer visibility anywhere in the document body:

```latex
\showanswers   % enable solution display from this point on
\hideanswers   % disable solution display from this point on
```

---

## Commands and Environments Reference

### Exam Header

#### `\examinfo{title}{subtitle}`

Sets the exam title and subtitle (shown at the top of the first page and repeated on continuation pages).

```latex
\examinfo
  {Final Exam – Special Relativity}
  {Department of Physics – University X\\Course: General Topic\\Semester 2026-1}
```

The subtitle may contain `\\` line breaks.

#### `\makeexamheader`

Renders the exam header block at the current position in the document. Typically placed immediately after `\begin{document}`.

```latex
\begin{document}
\makeexamheader
```

The header block contains:
- **Bold large title** (from `\examinfo`)
- **Subtitle** (from `\examinfo`)
- **Student fill-in fields** (defined with `\setexamheaderfields`)
- **Horizontal rule** (can be suppressed with `\hideinitialhruler`)

#### `\examtitle{text}` / `\examsubtitle{text}`

Alternative individual setters for the title and subtitle.

#### `\hideinitialhruler` / `\showinitialhruler`

Toggle the horizontal rule that appears at the bottom of the header block.

```latex
\hideinitialhruler   % remove the rule
\showinitialhruler   % restore the rule (default)
```

---

### Header Fields

The header block contains fill-in fields for student information. By default a single field labelled *Cedula* is shown. Use `\setexamheaderfields` to replace it with any set of custom fields.

#### `\setexamheaderfields{field definitions}`

Defines the set of fields displayed in the student header. Fields are composed with `\examfield`.

```latex
\setexamheaderfields{%
  \examfield[0.5]{Name}%       50% of line width
  \examfield{ID number}%       auto width (fills rest of line)
  \examfield{Programme}%       full new row, auto width
}
```

#### `\examfield[fraction]{label}`

Renders a single fill-in field.

- **`fraction`** (optional, 0–1): fraction of `\linewidth` to use.  
  If omitted, the field auto-sizes to share the remaining space with other auto-width fields on the same row.
- **`label`**: the text label printed in bold before the fill rule.

Fields are automatically arranged in rows. When the cumulative width of fields on the current row reaches `\linewidth`, a new row begins automatically.

```latex
\examfield[0.5]{Name}      % occupies 50% of the line
\examfield[0.5]{ID}        % occupies the other 50%, completing the row
\examfield{Programme}      % auto-width on a new row
```

#### `\resetexamheaderfields`

Reverts to the default single-field behaviour (shows only *Cedula*).

#### `\setstudentidlabel{text}`

Changes the label used for the default single field.

```latex
\setstudentidlabel{Student ID}
```

---

### Problems

#### Environment `examproblems`

Wraps all problems in a numbered list. All `problem` environments must be placed inside `examproblems`.

```latex
\begin{examproblems}
  \begin{problem}{...}[pts] ... \end{problem}
  \begin{problem}{...}[pts] ... \end{problem}
\end{examproblems}
```

#### Environment `problem{title}[points]`

Defines a single exam problem.

| Argument | Required | Description |
|----------|----------|-------------|
| `title` | yes | Problem title (displayed bold, large) |
| `points` | no | Point value; displayed as `(N pt)` after the title |

```latex
\begin{problem}{Relativistic Mechanics}[30]
State the context of the problem here.
\begin{questions}
  ...
\end{questions}
\end{problem}
```

Problems are auto-numbered by the `problem` counter.

---

### Questions

#### Environment `questions`

Wraps sub-questions within a problem. Labels are alphabetic: a), b), c), …

```latex
\begin{questions}
  \question First sub-question.
  \question Second sub-question.
\end{questions}
```

#### `\question`

Starts a new sub-question item inside a `questions` environment.

#### `\questionsection{title}`

Inserts a bold section heading as a question item — useful for grouping sub-questions under named subsections.

```latex
\questionsection{Conceptual questions}
Describe the difference between invariant and observer-dependent quantities.
```

#### `\hidequestion`

Suppresses the immediately following question (and its `solution`) from the output, without needing to comment out the code. Useful for quickly disabling a question during editing.

```latex
\hidequestion
\question This question will not appear in the PDF.
\begin{solution}
  Neither will this solution.
\end{solution}
```

---

### Multiple-Choice Questions

#### `\singlechoicequestion{text}`

Starts a question item pre-labelled with the single-choice tag (default: *Single Choice*).

```latex
\singlechoicequestion{For a free particle, the conserved quantity associated with time symmetry is:}
```

#### `\multiplechoicequestion{text}`

Same as above but labelled with the multiple-choice tag (default: *Multiple Choice*).

#### Environment `choices[n]`

Lays out answer choices in `n` columns (default: 2) using `multicol`.

```latex
\begin{choices}[2]
  \choice{The total angular momentum.}
  \correctchoice{The total energy.}
  \choice{The effective electric charge.}
  \choice{The local scalar curvature.}
\end{choices}
```

#### `\choice{text}`

An incorrect answer option.

#### `\correctchoice{text}`

A correct answer option. When answers are shown, appends the correct mark (default: `*`) in red.

#### `\setsinglechoicelabel{text}` / `\setmultiplechoicelabel{text}`

Override the default labels for single- and multiple-choice questions.

```latex
\setsinglechoicelabel{Single Answer}
\setmultiplechoicelabel{Multiple Answers}
```

#### `\setcorrectmark{symbol}`

Changes the marker appended to correct choices when answers are shown.

```latex
\setcorrectmark{\checkmark}
```

---

### Solutions and Answers

#### Environment `solution`

Wraps a full solution block. Rendered only when answers are enabled.

```latex
\begin{solution}
  This is the full worked solution. Shown in red only in answer-key mode.
\end{solution}
```

Output: bold **Solution:** heading followed by the body text in red.

#### `\answer{text}`

Inline version of a solution fragment. Renders `text` in red only when answers are enabled.

```latex
The conserved quantity is the total energy\answer{ (Noether's theorem)}.
```

---

### Formula Sheet

#### Environment `formulasheet`

Generates a centered, framed formula sheet on a new page at the end of the exam. The content is placed inside a box wrapped in `\fbox`.

```latex
\begin{formulasheet}
  \item Euler–Lagrange equations: $\frac{d}{dt}\!\left(\frac{\partial L}{\partial \dot{q}_i}\right) - \frac{\partial L}{\partial q_i} = 0$
  \item Lorentz transformations (1D): $x' = \gamma(x - vt)$
\end{formulasheet}
```

Each formula is an `\item` in an `itemize` list with generous vertical spacing.

---

### Page Breaks

#### `\problempage[option]`

Inserts a page break before a problem. An optional argument controls the behaviour:

| Call | Effect |
|------|--------|
| `\problempage` | Plain page break (no header) |
| `\problempage[header]` | Page break followed by a compact re-printed exam header |

The `[header]` variant is ignored before the very first problem item to avoid list-state errors.

```latex
\problempage[header]
\begin{problem}{Second Problem}[40]
  ...
\end{problem}
```

---

### Visibility Controls

#### `\hideproblem`

Suppresses the immediately following `problem` environment from the output.

```latex
\hideproblem
\begin{problem}{Draft Problem}[10]
  This will not appear.
\end{problem}
```

#### `\hidequestion`

(See [Questions](#questions) above.)

---

## Makefile Usage

The included `Makefile` automates PDF compilation with `pdflatex`.

```bash
make               # compile the default target (jztemplate.tex)
make all           # same as make
make <name>.pdf    # compile any <name>.tex in the current directory
make clean         # remove LaTeX auxiliary files (*.aux, *.log, etc.)
make distclean     # remove auxiliary files AND generated PDFs
make help          # print available targets
```

Override the LaTeX engine or flags:

```bash
make LATEX=lualatex MAIN=my-exam
```

---

## Template

The file `jztemplate.tex` is a ready-to-use template that demonstrates all features of the package:

- Exam header with customized student fields
- Two open-ended problems with `questions` and `solution` environments
- A problem with `\singlechoicequestion` / `\multiplechoicequestion` and `choices`
- A problem using `\questionsection` for subsections
- A `formulasheet` at the end
- Use of `\hidequestion` and `\problempage[header]`

Compile with:

```bash
pdflatex jztemplate.tex
```

---

## Compiling Locally

`jzexam` requires a standard LaTeX distribution. The recommended engine is `pdflatex`, but `lualatex` and `xelatex` also work. The sections below cover installation and compilation for each major platform.

---

### macOS

**1. Install MacTeX**

Download and install [MacTeX](https://www.tug.org/mactex/) (≈ 5 GB, includes TeX Live and GUI tools):

```bash
# With Homebrew (recommended):
brew install --cask mactex-no-gui   # headless, ~1 GB
# or
brew install --cask mactex          # full suite with TeXShop, BibDesk, etc.
```

Alternatively, download the installer directly from [tug.org/mactex](https://www.tug.org/mactex/).

**2. Verify the installation**

Open a new terminal and run:

```bash
pdflatex --version
```

**3. Compile an exam**

```bash
# Using the Makefile (recommended):
cd /path/to/your/exam
make                    # compiles jztemplate.tex → jztemplate.pdf
make MAIN=my-exam       # compiles my-exam.tex → my-exam.pdf

# Or directly with pdflatex:
pdflatex jztemplate.tex
```

**4. GUI editors**

[TeXShop](https://pages.uoregon.edu/koch/texshop/) (included with MacTeX) and [VS Code](https://code.visualstudio.com/) with the [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop) extension are popular choices on macOS.

---

### Linux

**1. Install TeX Live**

```bash
# Debian / Ubuntu
sudo apt install texlive-full        # complete installation (~5 GB)
# Minimal + required packages only:
sudo apt install texlive-latex-extra texlive-fonts-recommended

# Fedora / RHEL
sudo dnf install texlive-scheme-full

# Arch Linux
sudo pacman -S texlive-most
```

> For the most up-to-date TeX Live, you can also install via the [upstream installer](https://www.tug.org/texlive/acquire-netinstall.html) instead of your distro's package manager.

**2. Verify the installation**

```bash
pdflatex --version
```

**3. Compile an exam**

```bash
cd /path/to/your/exam
make                    # uses the included Makefile
# or
pdflatex jztemplate.tex
```

For automatic recompilation on save, [latexmk](https://ctan.org/pkg/latexmk) (included with TeX Live) is useful:

```bash
latexmk -pdf -pvc jztemplate.tex    # watch mode: recompiles on every save
```

**4. GUI editors**

[Texmaker](https://www.xm1math.net/texmaker/), [TeXstudio](https://www.texstudio.org/), and VS Code with LaTeX Workshop are widely used on Linux.

---

### Windows

**1. Install MiKTeX or TeX Live**

- **MiKTeX** (recommended for Windows): download from [miktex.org](https://miktex.org/download). MiKTeX installs missing packages on-the-fly the first time you compile, so you can start with a minimal setup.
- **TeX Live for Windows**: download from [tug.org/texlive](https://www.tug.org/texlive/windows.html) and run the network installer.

**2. Verify the installation**

Open **Command Prompt** or **PowerShell** and run:

```powershell
pdflatex --version
```

**3. Compile an exam**

```powershell
cd C:\path\to\your\exam

# With pdflatex directly:
pdflatex jztemplate.tex

# With the Makefile (requires GNU Make, e.g. via Git for Windows or Chocolatey):
make
```

> **Note on `make` on Windows:** The `Makefile` requires GNU Make. Install it via [Git for Windows](https://gitforwindows.org/) (includes a bash shell with `make`) or with [Chocolatey](https://chocolatey.org/): `choco install make`.

**4. GUI editors**

[TeXstudio](https://www.texstudio.org/) and [TeXworks](https://www.tug.org/texworks/) (bundled with MiKTeX) are the most common choices on Windows. VS Code with LaTeX Workshop also works well.

---

## License

`jzexam` — LaTeX Exam Package  
Copyright (C) 2026–present Jorge I. Zuluaga

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

See the [LICENSE](LICENSE) file for full terms.
