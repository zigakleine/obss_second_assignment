while read line; do
    #echo $line

    linearr=($line) 
    if [ "${linearr[0]}" = "Sum" ]; then
        Nn="${linearr[1]}" # True positive
        Vn="${linearr[2]}" # False positive
        Nv="${linearr[5]}" # False negative
        Vv="${linearr[6]}" # True negative 

        Tp=$Nn
        Fp=$Vn
        Fn=$Nv
        Tn=$Vv

        TpFn=$(($Tp + $Fn))
        TpFp=$(($Tp + $Fp))
        TnFp=$(($Tn + $Fp))

        echo "Se:"
        echo "$Tp/$TpFn" | bc -l
        echo "--------------------"


        echo "+P:"
        echo "$Tp/$TpFp" | bc -l
        echo "--------------------"


        echo "Sp:"
        echo "$Tn/$TnFp" | bc -l
        echo "--------------------"


    fi 

done <results.txt