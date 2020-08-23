# Grep

# Ag with ignore file
ag -p ~/.ignore

# Rg with additional ignore file
rg --ignore-file ~/.ignore

# Ack with config file
ack --ackrc=~/.ackrc

# Count number of lines matched
some_grep_command | wc -l

