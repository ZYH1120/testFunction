for loop in 220 230 240 250 260 270 280 290 300 
do
    wsk action delete  extractImageMetadata$loop  -i   #  extract-image-metadata/target/extract-image-metadata.jar --main org.serverlessbench.ExtractImageMetadata --docker dplsming/java8action-imagemagic -i \
 
    wsk action delete transformMetadata$loop  -i   #  transform-metadata/target/transform-metadata.jar --main org.serverlessbench.TransformMetadata --docker openwhisk/java8action -i  -m $loop

    wsk action delete  handler$loop    -i     # handler/target/handler.jar --main org.serverlessbench.Handler --docker openwhisk/java8action -i \

    wsk action delete  thumbnail$loop -i   # thumbnail/target/thumbnail.jar --main org.serverlessbench.Thumbnail --docker openwhisk/java8action -i \

    wsk action delete storeImageMetadata$loop   -i

    wsk action delete  imageProcessSequence$loop    -i
done

