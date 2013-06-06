;; Cobra mode

;; Load python-mode if available, otherwise use builtin emacs python package
(when (not(require 'python-mode nil t))
  (require 'python))

(add-to-list 'auto-mode-alist '("\\.cobra\\'" . cobra-mode))

(defvar cobra-font-lock-keywords
  `(

    (,(regexp-opt '("vari" "as" "require" "ensure" "body" "test" "use" "catch" "ref" "shared" "cue"
                    "get" "set" "throw" "as" "using" "namespace" "of" "stop" "out" "branch" "on"
                    "pro" "inherits" "protected" "final" "override" "public" "constant" "invariant"
                    "implies" "var" "success" "enum" "interface" "implements" "<>" "result" "old"
                    ) 'words)
     1 font-lock-keyword-face)

    (,(regexp-opt '("String" "nil" "decimal" "number" "dynamic") 'words)
     1 font-lock-builtin-face)

    )
  "Additional font lock keywords for Cobra mode.")

(define-derived-mode cobra-mode python-mode "Cobra"
  "Major mode for Cobra development, derived from Python mode."
  (setcar font-lock-defaults
          (append python-font-lock-keywords cobra-font-lock-keywords))
)

(provide 'cobra-mode)
