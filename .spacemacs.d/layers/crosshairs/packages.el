(defconst crosshairs-packages
  '(
    (vline :location (recipe
                      :fetcher github
                      :repo "emacsmirror/emacswiki.org"
                      :branch "master"
                      :files ("vline.el")))
    (col-highlight :location (recipe
                              :fetcher github
                              :repo "emacsmirror/emacswiki.org"
                              :branch "master"
                              :files ("col-highlight.el")))
    (hl-line :location (recipe
                        :fetcher github
                        :repo "emacsmirror/emacswiki.org"
                        :branch "master"
                        :files ("hl-line.el")))
    (hl-line+ :location (recipe
                         :fetcher github
                         :repo "emacsmirror/emacswiki.org"
                         :branch "master"
                         :files ("hl-line+.el")))
    (crosshairs :location (recipe
                           :fetcher github
                           :repo "emacsmirror/emacswiki.org"
                           :branch "master"
                           :files ("crosshairs.el")))
    )
  )

(defun crosshairs/init-vline ()
  (use-package vline
    :defer t))

(defun crosshairs/init-col-highlight ()
  (use-package col-highlight
    :defer t))

(defun crosshairs/init-hl-line ()
   (use-package hl-line
    :defer t))

(defun crosshairs/init-hl-line+ ()
  (use-package hl-line+
    :defer t))

(defun crosshairs/init-crosshairs ()
  (use-package crosshairs
    :defer t
    :commands (crosshairs crosshairs-mode crosshairs-flash crosshairs-highlight)
    :init
    (spacemacs|add-toggle crosshairs
      :mode crosshairs-mode
      :documentation "Highlight cursor position with crosshairs."
      :evil-leader "thx")
    )
  )
