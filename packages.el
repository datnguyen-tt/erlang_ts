;;; packages.el --- erlang_ts layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2021 Sylvain Benner & Contributors
;;
;; Author: datttn <datttn.work@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

(defconst erlang_ts-packages
  '(
    (company :toggle (configuration-layer/layer-used-p 'auto-completion))
    (flycheck :toggle (configuration-layer/layer-used-p 'syntax-checking))
    (erlang :location elpa)
    (edts :toggle erlang_ts-enable-edts
          :location (recipe :fetcher github :repo "sebastiw/edts"))
    (erl-trace :toggle erlang_ts-enable-erl-trace
               :location (recipe
                          :fetcher github
                          :repo "datttnwork7247/erl-trace"
                          :files ("*")))
    (cmpload :toggle erlang_ts-enable-cmpload
             :location (recipe
                        :fetcher github
                        :repo "datttnwork7247/cmpload"
                        :files ("*")))
    )
  "List of all packages to install and/or initialize for this layer.")

(defun erlang_ts/post-init-company ()
  ;; backend specific
  (add-hook 'erlang-mode-local-vars-hook #'erlang_ts//setup-company))

(defun erlang_ts/post-init-flycheck ()
  (add-hook 'erlang-mode-hook #'flycheck-mode))

(defun erlang_ts/init-erlang ()
  (use-package erlang
    :defer t
    ;; Erlang mode is not derived from prog-mode
    :hook
    ((erlang-mode . erlang_ts//maybe-run-prog-hooks)
     (erlang-mode-local-vars . erlang_ts//setup-backend))
    :init
    (setq erlang-compile-extra-opts '(debug_info))
    :config
    (require 'erlang-start)))

(defun erlang_ts/init-edts ()
  (use-package edts
    :defer t
    :commands (edts-mode edts-find-source-under-point edts-find-source-unwind)))

(defun erlang_ts/init-erl-trace ()
  (use-package erl-trace
    :defer t
    :commands (erl-trace-insert erl-trace-run-cmd erl-trace-store)))

(defun erlang_ts/init-cmpload ()
  (use-package cmpload
    :defer t
    :commands (cmpload-load cmpload-reload cmpload-compile)))
