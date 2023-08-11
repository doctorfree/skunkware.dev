Instructions for Packing of Wine
============================
1.Download and extract winepackingscript.tar.gz in a temporary directory
   a. gunzip winepackingscript.tar.gz
   b. tar -xf winepackingscript.tar 

(Note : ~$dist contains the binaries of Wine for packing, update it if not latest)

2. Download and run Metapkg 2.0.3 or later

3. Check "WINEOS" variable value in metapkg.wine file
    for custom package it should be "OSR" and for uw7 it should be "UW7" 

4. Run MakeAll to build the package
    #./MakeAll

(This script calls Clean, MakeCDMT and make. So the MakeCDMT calls the binary of MetaPKG for generation of Custom package for which written a
control script called metapkg.wine which controls the packing and CCS script in the $dist/cntl directory for environment variables settings.)

5. Now for OSR6, your custom package is ready in the directory ~archives/TAPE/VOL*  and
   for uw7, your package is ready in ./wine.pkg