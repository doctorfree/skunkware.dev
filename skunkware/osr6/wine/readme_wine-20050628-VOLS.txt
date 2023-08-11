Instructions for installing Wine20050628 custom package
===============================================
1. Download and extract wine-20050628-VOLS.tar file in a temporary directory.
    tar -xf wine-20050628-VOLS.tar
2. Execute the command "custom" on shell prompt.
3. Select "Install New" from the Software menu.
4. Select "host" from which you want to install a package the press "Continue".
5. Select "media" from which you want to install a package then press "Continue".
6. Enter the full path to the directory containing the image and press "OK".
7. To run "Wine" type any of the the following command
    $ wine
     or
    $ wine program [arguments] (program is a windows executable file present in the current path)

Note: Check PATH environment variable (i.e. echo $PATH so that /usr/local/bin is there) before you run "wine" otherwise logoff and login as root again. 

Pl. check that LD_LIBRARY_PATH & PATH variables contains wine paths. If not then pl. set it manually as below

LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:/usr/local/lib/wine
export LD_LIBRARY_PATH
PATH=$PATH:/usr/local/bin
export PATH