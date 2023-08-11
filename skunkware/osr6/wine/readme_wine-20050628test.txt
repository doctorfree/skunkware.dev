Instructions for testing Wine
====================
1. Install Wine 

2. Download and extract wine-20050628test.tar.gz
 $ gunzip wine-20050628test.tar.gz
 $ tar -xf wine-20050628test.tar

3  $cd wine-20050628test

4. Run the testscripts
 $ ./final_testscript_arg.sh
    The Output of "final_testscript_arg.sh" is in "Temptest_arg" file in same directory

 $ ./final_testscript_noarg.sh
    The Output of "final_testscript_noarg.sh" is in "Temptest_noarg" file in same directory

5. Compare it
  You can compare the results of  "Temptest_arg" with the supplied results in "WineTestReport_arg.txt" and "Temptest_noarg" with the supplied results in "WineTestReport_noarg.txt" in same directory.

NOTE:
  1. Don't run these 2 scripts simultaneously in background. Execute them separately one after another
  2. Don't leave it unattended, because some exe's generate GUI so you may have to close those windows to continue running the script forward
  3. "WineTestReport_arg.txt" and "WineTestReport_noarg.txt" contains the log of pre-conducted tests on the test machine. For pre-analysis you can view them 
  4. When "wcmd" test is being executed, it will halt. Just type "exit" and press ENTER to continue further
