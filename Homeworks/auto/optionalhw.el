(TeX-add-style-hook
 "optionalhw"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("fullpage" "cm")))
   (TeX-run-style-hooks
    "amssymb"
    "amsfonts"
    "amsmath"
    "latexsym"
    "setspace"
    "amsthm"
    "fullpage"
    "fancyhdr"
    "hyperref"
    "lastpage"
    "listings")))

