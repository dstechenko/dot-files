;;; init-markdown.el --- Emacs configuration

;; Copyright (C) 2017 Dmytro Stechenko
;; License: http://www.gnu.org/licenses/gpl.html

;;; Commentary:
;;
;; Markdown packages configuration.
;; Includes the following:
;; - markdown-mode
;;

;;; Code:

(use-package markdown-mode
  :commands
  markdown-mode
  gfm-mode

  :mode
  (("README\\.md\\'" . gfm-mode)
   ("\\.md\\'" . markdown-mode)
   ("\\.markdown\\'" . markdown-mode)))

(provide 'init-markdown)

;;; init-markdown.el ends here
