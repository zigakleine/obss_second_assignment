
## Script for running C program and evaluation of the algorithm.
##########

rm eval1.txt
rm eval2.txt


RECORDS="100 101 102 103 104 105 106 108 112 113 114 115 116 117 119 121 122 123 200 201 202 203 205 208 209 210 212 213 215 217 219 220 221 222 223 228 230 231 233 234"

# Compile detector
#gcc -o myDetector -O myDetector.c -lm -lwfdb

# For all record files run detector
for f in $RECORDS
do

   echo $f

   cp "../detections/"$f".asc" .
   cp "../mitdb/"$f".fatr" .  
   cp "../mitdb/"$f".hea" .

   wrann -r $f -a qrs < $f".asc"
   bxb -r $f -a fatr qrs -l eval1.txt eval2.txt

   rm -v "./"$f".asc"  
   rm -v "./"$f".fatr"  
   rm -v "./"$f".hea"  
   rm -v "./"$f".qrs"  


done

 
# Calculate aggregate statistics
sumstats eval1.txt eval2.txt >results.txt


# dat - signal recordings from the database
# atr - reference annotations from the database
# qrs - annotations of implemented algorithm
# results.txt - final statistics for reporting

# If your implementation is in Matalab, then comment out compiling and running
# the C program and just use the part for evaluation (bxb and sumstats).

# Other explanations of how to run programs and convert records and annotation 
# files are described on the web-classrom under certain laboratory sessions.
