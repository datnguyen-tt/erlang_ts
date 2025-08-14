;;; keybindings.el --- erlang_ts layer key bindings

(spacemacs/declare-prefix-for-mode 'erlang-mode "mg" "goto")
(spacemacs/declare-prefix-for-mode 'erlang-mode "mb" "build")
(spacemacs/declare-prefix-for-mode 'erlang-mode "mt" "trace")
(spacemacs/declare-prefix-for-mode 'erlang-mode "mc" "cmpload")

(spacemacs/set-leader-keys-for-major-mode 'erlang-mode
  "g d" 'erlang_ts/goto-definition
  "g b" 'erlang_ts/goto-back
  "b c" 'erlang_ts/rebar3-compile
  "b t" 'erlang_ts/rebar3-eunit
  "b d" 'erlang_ts/rebar3-dialyzer
  "t i" 'erlang_ts/erl-trace-insert
  "t e" 'erlang_ts/erl-trace-run-cmd
  "t r" 'erlang_ts/erl-trace-store)

(with-eval-after-load 'evil
  (with-eval-after-load 'erlang
    (evil-define-key 'normal erlang-mode-map
      (kbd "M-.") 'erlang_ts/goto-definition
      (kbd "M-,") 'erlang_ts/goto-back)))