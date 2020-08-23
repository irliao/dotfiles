# Be 8 bit clean.
set meta-flag on
set input-meta on
set output-meta on

# Always show all TAB completion possibilities.
set show-all-if-ambiguous on
set show-all-if-unmodified on

# When there are multiple possibilities during TAB completion, show '...'
# instead of the prefix. This makes the possibilities more readable.
set completion-prefix-display-length 2

# Do not bell on TAB completion.
set bell-style none

# Do not add already completed text during TAB completion.
set skip-completed-text on

# Enable vi-like motion.
set editing-mode vi

# Make the Home and End keys work as expected.
"\e[1~": beginning-of-line
"\e[4~": end-of-line
"\eOH": beginning-of-line
"\eOF": end-of-line

# Enable text objects in the vi mode.
# Based on https://github.com/minos-org/bash-minos-settings/blob/master/etc.inputrc
$if mode=vi
set keymap vi-command
"daw": "lbdw"
"yaw": "lbyw"
"caw": "lbcw"
"daW": "lBdW"
"yaW": "lByW"
"caW": "lBcW"
"diw": "lbdw"
"yiw": "lbyw"
"ciw": "lbcw"
"diW": "lBdW"
"yiW": "lByW"
"ciW": "lBcW"
"da\"": "lF\"df\""
"di\"": "lF\"lmtf\"d`t"
"ci\"": "di\"i"
"ca\"": "da\"i"
"da'": "lF'df'"
"di'": "lF'lmtf'd`t"
"ci'": "di'i"
"ca'": "da'i"
"da`": "lF\`df\`"
"di`": "lF\`lmtf\`d`t"
"ci`": "di`i"
"ca`": "da`i"
"da(": "lF(df)"
"di(": "lF(lmtf)d`t"
"ci(": "di(i"
"ca(": "da(i"
"da)": "lF(df)"
"di)": "lF(lmtf)d`t"
"ci)": "di(i"
"ca)": "da(i"
"da{": "lF{df}"
"di{": "lF{lmtf}d`t"
"ci{": "di{i"
"ca{": "da{i"
"da}": "lF{df}"
"di}": "lF{lmtf}d`t"
"ci}": "di}i"
"ca}": "da}i"
"da[": "lF[df]"
"di[": "lF[lmtf]d`t"
"ci[": "di[i"
"ca[": "da[i"
"da]": "lF[df]"
"di]": "lF[lmtf]d`t"
"ci]": "di]i"
"ca]": "da]i"
"da<": "lF<df>"
"di<": "lF<lmtf>d`t"
"ci<": "di<i"
"ca<": "da<i"
"da>": "lF<df>"
"di>": "lF<lmtf>d`t"
"ci>": "di>i"
"ca>": "da>i"
$endif
