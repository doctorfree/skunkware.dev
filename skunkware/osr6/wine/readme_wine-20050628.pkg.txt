Instructions for installing Wine20050628 binary package
===============================================
1. Download wine-20050628.pkg file in a temporary directory.
2. Add package using pkgadd command
   pkgadd -d /downloaded_dir_path/wine-20050628.pkg 
3. Select "All" on package selection prompt, this will install wine package 
4. To run "Wine" type any of the the following command
    $ wine
     or
    $ wine program [arguments] (program is a windows executable file present in the current path)

Note: Check PATH envornment variable (i.e. echo $PATH so that /usr/local/bin is there) before you run "wine" otherwise logoff and login as root again. 

Pl. check that LD_LIBRARY_PATH & PATH variables contains wine paths. If not then pl. set it manually as below

LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:/usr/local/lib/wine
export LD_LIBRARY_PATH
PATH=$PATH:/usr/local/bin
export PATH