;;; config.el --- erlang_ts layer configuration file for Spacemacs.

(defvar erlang_ts-backend 'xref
  "Backend to use for navigation and xref:
Possible values are 'xref (default), 'edts or 'lsp.
When set to 'lsp, ensure the Spacemacs lsp layer is enabled and erlang_ls is installed.")

(defvar erlang_ts-enable-edts t
  "If non-nil, install and enable EDTS integration.")

(defvar erlang_ts-enable-erl-trace t
  "If non-nil, install and enable erl-trace helper commands.")

(defvar erlang_ts-enable-cmpload nil
  "If non-nil, install and enable cmpload helper commands.")

(defvar erlang_ts-rebar3-command "rebar3"
  "Command used to invoke rebar3.")