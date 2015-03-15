(TeX-add-style-hook
 "methodshw"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("fullpage" "cm")))
   (TeX-run-style-hooks
    "fourier"
    "bm"
    "amssymb"
    "amsfonts"
    "amsmath"
    "latexsym"
    "setspace"
    "fullpage"
    "fancyhdr"
    "hyperref"
    "lastpage"
    "listings")))

