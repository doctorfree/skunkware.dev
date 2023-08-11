Comparative analysis  of wine on OSR6 with linux version
========================================
Download and extract wine-20050628buglistosr6.tar.gz in a temporary directory.
 $ gunzip wine-20050628buglistosr6.tar.gz 
 $ tar -xf wine-20050628buglistosr6.tar

It extracts 
1) winebuglist.xls : contains test result of all tests on OSR6
2) uw7user32_testexe_win.txt : contains test result of "user32_test.exe win" on OSR6 (refered inside the xls sheet)
3) linuxuser32_testexe_win.txt : contains test result of "user32_test.exe win" on linux  (refered inside the xls sheet)
4) linuxuser32_testexe_msg.txt: contains test result of "user32_test.exe msg" on linux  (refered inside the xls sheet)

The Main Report is in the winetestreport.xls The other files contain test data which were not contained in the Excel Sheet.  
     
The test resullts show that out of 175 tests executed wem got below output
     115 tests   -  OK      < No Bugs >
     25 tests   -  Unknown < Unknown Bugs > - 4 duplicate
     35 tests   -  Known   < Known Bugs >

The known bugs exist in Linux as well as in SCO, the unknown bugs exist only in SCO or they are not working as in Linux.

The Unknown bugs are of greater priority. They are to be solved first. The known bugs are such that some facilities are not provided, so they might have to be added in the current infrastructure.