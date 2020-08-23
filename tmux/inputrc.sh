# make kj remappable to Escape
set editing-mode vi

# vi settings
$if mode=vi
  set keymap vi-insert
  "kj": vi-movement-mode # remap escape
$endif
