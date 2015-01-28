(TeX-add-style-hook
 "hw8omr"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "11pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8") ("fontenc" "T1")))
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art11"
    "inputenc"
    "fontenc"
    "fixltx2e"
    "graphicx"
    "longtable"
    "float"
    "wrapfig"
    "soul"
    "textcomp"
    "marvosym"
    "wasysym"
    "latexsym"
    "amssymb"
    "hyperref")
   (TeX-add-symbols
    '("alert" 1))
   (LaTeX-add-labels
    "sec-1"
    "sec-1-1"
    "sec-1-2"
    "fig:one"
    "sec-2"
    "sec-2-1"
    "sec-3"
    "sec-3-1"
    "sec-3-2"
    "fig:prob2a"
    "sec-3-3"
    "sec-3-3-1"
    "sec-4")))

