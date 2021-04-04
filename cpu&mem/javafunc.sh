for loop in   220 230 240 250 260 270  300  
do
       wsk -i action update javafunc_$loop  javafunc-1.0-SNAPSHOT.jar --main Hello --docker openwhisk/java8action -m $loop
done

