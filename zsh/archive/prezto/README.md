Recommendations
===================

zsh
Login files in order:

Order File  When? Recommended usage
1.  /etc/zshenv always  Should be empty.
2.  ~/.zshenv always  Hardly used
3.  /etc/zprofile login shell 
4.  ~/.zprofile login shell For environment variables
5.  /etc/zshrc  interactive 
6.  ~/.zshrc  interactive For aliases and options
7.  /etc/zlogin login shell 
8.  ~/.zlogin login shell For running external commands (msgs, biff, fortune, clear)


Execution Times
===================

/etc/zshenv
Always run for every zsh.
~/.zshenv
Usually run for every zsh (see below).
/etc/zprofile
Run for login shells.
~/.zprofile
Run for login shells.
/etc/zshrc
Run for interactive shells.
~/.zshrc
Run for interactive shells.
/etc/zlogin
Run for login shells.
~/.zlogin
Run for login shells.


Startup Files
===================

There are five startup files that zsh will read commands from:

$ZDOTDIR/.zshenv
$ZDOTDIR/.zprofile
$ZDOTDIR/.zshrc
$ZDOTDIR/.zlogin
$ZDOTDIR/.zlogout
If ZDOTDIR is not set, then the value of HOME is used; this is the usual case.

`.zshenv' is sourced on all invocations of the shell, unless the -f option is set. It should contain commands to set the command search path, plus other important environment variables. `.zshenv' should not contain commands that produce output or assume the shell is attached to a tty.

`.zshrc' is sourced in interactive shells. It should contain commands to set up aliases, functions, options, key bindings, etc.

`.zlogin' is sourced in login shells. It should contain commands that should be executed only in login shells. `.zlogout' is sourced when login shells exit. `.zprofile' is similar to `.zlogin', except that it is sourced before `.zshrc'. `.zprofile' is meant as an alternative to `.zlogin' for ksh fans; the two are not intended to be used together, although this could certainly be done if desired. `.zlogin' is not the place for alias definitions, options, environment variable settings, etc.; as a general rule, it should not change the shell environment at all. Rather, it should be used to set the terminal type and run a series of external commands (fortune, msgs, etc).


Configuration Files
===================

Zsh has several system-wide and user-local configuration files.

Prezto has one user-local configuration file.

System-wide configuration files are installation-dependent but are installed
in */etc* by default.

User-local configuration files have the same name as their global counterparts
but are prefixed with a dot (hidden). Zsh looks for these files in the path
stored in the `$ZDOTDIR` environmental variable. However, if said variable is
not defined, Zsh will use the user's home directory.

File Descriptions
-----------------

The configuration files are read in the following order:

  01. /etc/zshenv
  02. ~/.zshenv
  03. /etc/zprofile
  04. ~/.zprofile
  05. /etc/zshrc
  06. ~/.zshrc
  07. ~/.zpreztorc
  08. /etc/zlogin
  09. ~/.zlogin
  10. ~/.zlogout
  11. /etc/zlogout

### zshenv

This file is sourced by all instances of Zsh, and thus, it should be kept as
small as possible and should only define environment variables.

### zprofile

This file is similar to zlogin, but it is sourced before zshrc. It was added
for [KornShell][1] fans. See the description of zlogin below for what it may
contain.

zprofile and zlogin are not meant to be used concurrently but can be done so.

### zshrc

This file is sourced by interactive shells. It should define aliases,
functions, shell options, and key bindings.

### zpreztorc

This file configures Prezto.

### zlogin

This file is sourced by login shells after zshrc, and thus, it should contain
commands that need to execute at login. It is usually used for messages such as
[fortune][2], [msgs][3], or for the creation of files.

This is not the file to define aliases, functions, shell options, and key
bindings. It should not change the shell environment.

### zlogout

This file is sourced by login shells during logout. It should be used for
displaying messages and the deletion of files.
