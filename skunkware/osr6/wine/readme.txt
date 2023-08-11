Hello Alia,

uploaded below files ( \\Surya\project_sco\WINE\Old Versions\V.0.3 )

Wine Source
=========
wine-20050628source.tar.gz - buildable wine source for UW7
wine-20050628source.tar.gz.checksum - checksum of wine-20050628source.tar.gz
readme wine-20050628source.txt - Instructions to build wine source on UW7

Wine Package
==========
winepackingscript.tar.gz - package script for wine
winepackingscript.tar.gz.checksum- checksum of  winepackingscript.tar.gz
readme winepackingscript.txt  - Instructions for installing wine package on UW7

wine-20050628.pkg - UW7 package for wine
wine-20050628.pkg.checksum - checksum of  wine-20050628.pkg
readme wine-20050628.pkg.txt - Instructions for installing wine package on UW7

wine-20050628-VOLS.tar- OSR6 custom package for wine
wine-20050628-VOLS.tar.checksum - checksum of  wine-20050628-VOLS.tar
readme wine-20050628-VOLS.txt - Instructions for installing wine custom package on OSR6

Test Suites
=======
wine-20050628test.tar.gz - Testing scripts for wine on UW7/OSR6
wine-20050628test.tar.gz.checksum - checksum of  wine-20050628test.tar.gz
readme wine-20050628test.txt - Instructions to run test scripts

InstallationReport.txt - Installation status of IE6, WinZip8, FireFox 1.0.6, Trayo with wine
IE6InstallationSteps.txt - Installation instruction for IE6 (refered by InstallationReport.txt)

Comparative Analysis  with Linux version 
============================
wine-20050628buglistuw7.tar.gz - latest buglist for wine-20050628 on UW7
wine-20050628buglistuw7.tar.gz.checksum - checksum of wine-20050628buglistuw7.tar.gz
readmebuglistuw7.txt  - Summary of buglist on UW7

wine-20050628buglistosr6.tar.gz - latest buglist for wine-20050628 on OSR6
wine-20050628buglistosr6.tar.gz.checksum - checksum of wine-20050628buglistosr6.tar.gz
readmebuglistosr6.txt  - Summary of buglist on OSR6

If we compare uw7 and osr6 results then we get below analysis

Test                                               OSR6        UW7
-------------------------------------------------------
winmm_test.exe  mixer                   Failure     Success
crypt32_test.exe  protectdata         Success   Failure 
kernel32_test.exe  time                   Success   Failure 

Document Release Notes 
=================
Release Notes _wine_UW7.htm : Release notes for wine on UW7
Release Notes _wine_OSR6.htm : Release notes for wine on OSR6
