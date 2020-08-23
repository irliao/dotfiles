# sshrc
https://github.com/Russell91/sshrc

## ~/.sshrc.d
Files in here will be copied to /tmp in server after login but referenced through $SSHHOME/.sshrc.d.

***WARN:*** Putting too much data in ~/.sshrc.d will slow down your login times. 
            If the folder contents are > 64kB, the server may block your sshrc attempts.


