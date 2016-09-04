# Output packages
apm list --installed --bare > packages.list

# Install packages
apm install `cat packages.list`

or

apm install --packages-file packages.list

