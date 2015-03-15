(TeX-add-style-hook
 "DabbishHW4b"
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
    "hyperref"
    "methodshw"
    "booktabs")
   (TeX-add-symbols
    '("alert" 1))
   (LaTeX-add-labels
    "sec-1"
    "sec-1-1"
    "sec-1-1-1"
    "sec-1-2"
    "MuTau2"
    "sec-1-3"
    "Tau1Tau2"
    "sec-1-4"
    "Tau1Tau2H0"
    "sec-1-4-1"
    "sec-1-4-2"
    "sec-1-5"
    "sec-1-5-1"
    "sec-1-6"
    "sec-1-7"
    "sec-1-8"
    "sec-2"
    "sec-2-1"
    "sec-2-2"
    "sec-2-3"
    "sec-2-4"
    "sec-2-5"
    "sec-2-6"
    "sec-3"
    "sec-3-1"
    "sec-3-2"
    "sec-4")))

