;;; funcs.el --- erlang_ts layer functions file for Spacemacs.

(defun erlang_ts//maybe-run-prog-hooks ()
  "Run prog-mode hooks for buffers in erlang-mode.
Erlang mode is not derived from prog-mode so we trigger them explicitly."
  (if (fboundp 'spacemacs/run-prog-mode-hooks)
      (spacemacs/run-prog-mode-hooks)
    (run-hooks 'prog-mode-hook)))

(defun erlang_ts//setup-backend ()
  "Setup backend for Erlang according to `erlang_ts-backend'."
  (pcase erlang_ts-backend
    ('lsp (when (and (boundp 'lsp-mode) (fboundp 'lsp-deferred))
            (lsp-deferred)))
    ('edts (when (fboundp 'edts-mode)
             (edts-mode 1)))
    (_ nil)))

(defun erlang_ts//setup-company ()
  "Setup company backend for Erlang buffers."
  (when (or (featurep 'company)
            (configuration-layer/layer-used-p 'auto-completion))
    (let ((setup
           (lambda ()
             (set (make-local-variable 'company-backends)
                  (cond
                   ((eq erlang_ts-backend 'lsp)
                    '(company-capf))
                   (t
                    '(company-dabbrev-code company-files)))))))
      (add-hook 'erlang-mode-hook setup))))

(defun erlang_ts/goto-definition ()
  "Go to definition using the configured backend."
  (interactive)
  (pcase erlang_ts-backend
    ('edts (if (fboundp 'edts-find-source-under-point)
               (edts-find-source-under-point)
             (message "EDTS is not available")))
    ('lsp (cond
           ((fboundp 'lsp-find-definition) (lsp-find-definition))
           ((fboundp 'xref-find-definitions) (call-interactively 'xref-find-definitions))
           (t (message "No definition function available"))))
    (_ (if (fboundp 'xref-find-definitions)
           (call-interactively 'xref-find-definitions)
         (message "xref not available")))))

(defun erlang_ts/goto-back ()
  "Go back from definition, depending on backend."
  (interactive)
  (cond
   ((and (eq erlang_ts-backend 'edts)
         (fboundp 'edts-find-source-unwind))
    (edts-find-source-unwind))
   ((fboundp 'xref-pop-marker-stack)
    (xref-pop-marker-stack))
   (t (message "No pop-back function available"))))

;; erl-trace wrappers (lazy load)
(defun erlang_ts/erl-trace-insert ()
  (interactive)
  (if (require 'erl-trace nil t)
      (call-interactively 'erl-trace-insert)
    (message "erl-trace is not available")))

(defun erlang_ts/erl-trace-run-cmd ()
  (interactive)
  (if (require 'erl-trace nil t)
      (call-interactively 'erl-trace-run-cmd)
    (message "erl-trace is not available")))

(defun erlang_ts/erl-trace-store ()
  (interactive)
  (if (require 'erl-trace nil t)
      (call-interactively 'erl-trace-store)
    (message "erl-trace is not available")))

;; cmpload wrappers (lazy load)
(defun erlang_ts/cmpload-load ()
  (interactive)
  (if (require 'cmpload nil t)
      (call-interactively 'cmpload-load)
    (message "cmpload is not available")))

(defun erlang_ts/cmpload-reload ()
  (interactive)
  (if (require 'cmpload nil t)
      (call-interactively 'cmpload-reload)
    (message "cmpload is not available")))

(defun erlang_ts/cmpload-compile ()
  (interactive)
  (if (require 'cmpload nil t)
      (call-interactively 'cmpload-compile)
    (message "cmpload is not available")))

;; rebar3 helpers
(defun erlang_ts/rebar3-compile ()
  (interactive)
  (compile (format "%s compile" erlang_ts-rebar3-command)))

(defun erlang_ts/rebar3-eunit ()
  (interactive)
  (compile (format "%s eunit" erlang_ts-rebar3-command)))

(defun erlang_ts/rebar3-dialyzer ()
  (interactive)
  (compile (format "%s dialyzer" erlang_ts-rebar3-command)))