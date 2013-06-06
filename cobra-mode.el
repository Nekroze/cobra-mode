;; Cobra mode

;; Load python-mode if available, otherwise use builtin emacs python package
(when (not(require 'python-mode nil t))
  (require 'python))

(add-to-list 'auto-mode-alist '("\\.cobra\\'" . cobra-mode))


(defun cobra-compile ()
  "Compile the file via Cobra."
  (interactive)
  (let ((cy-buffer (current-buffer)))
    (with-current-buffer
        (compile compile-command)
      (set (make-local-variable 'cobra-buffer) cy-buffer)
      (add-to-list (make-local-variable 'compilation-finish-functions)
                   'cobra-compilation-finish)))
  )

(defun cobra-compilation-finish (buffer how)
  "Called when Cobra compilation finishes."
  ;; XXX could annotate source here
  )

(defvar cobra-mode-map
  (let ((map (make-sparse-keymap)))
    ;; Will inherit from `python-mode-map' thanks to define-derived-mode.
    (define-key map "\C-c\C-c" 'cobra-compile)
    map)
  "Keymap used in `cobra-mode'.")

(defvar cobra-font-lock-keywords
  `(;; new keywords in Cobra language
    (,(regexp-opt '("as" "require" "ensure" "body" "test" "using" "namespace"
                    "get" "set" "throw") 'words)
     1 font-lock-keyword-face)
    ;; C and Python types (highlight as builtins)
    (,(regexp-opt '("String") 'words)
     1 font-lock-builtin-face)
    )
  "Additional font lock keywords for Cobra mode.")

(define-derived-mode cobra-mode python-mode "Cobra"
  "Major mode for Cobra development, derived from Python mode.

\\{cobra-mode-map}"
  (setcar font-lock-defaults
          (append python-font-lock-keywords cobra-font-lock-keywords))
  (set (make-local-variable 'compile-command)
       (concat "cobra -c " buffer-file-name))
  (add-to-list (make-local-variable 'compilation-finish-functions)
               'cobra-compilation-finish)
)

(provide 'cobra-mode)
