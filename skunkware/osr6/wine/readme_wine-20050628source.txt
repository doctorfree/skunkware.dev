Instructions for building Wine20050628 source on uw7 
=============================================
1. Setup a UW7 system with below dependencies
   1. UpdateSet (Base Operating System Upgrade CD : CD 2)
   2. SCOx package
   3. UDK package
   4. OSTools
   5. Maintenance pack 2 (MP2)
   6. GWXLIBS.pkg

2. Download and extract wine-20050628-source.tar.gz file in a temporary directory called "dir_name".
 $ gunzip wine-20050628source.tar.gz 
 $ tar -xf wine-20050628source.tar 

3. #cd "dir_name"

4. run buildWine script
    #./buildWine.sh

If you get any parser error in between which crash building then check and correct library names in ./include/config.h file for incomplete quotes