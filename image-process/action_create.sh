wsk action update extractImageMetadata extract-image-metadata.jar --main org.serverlessbench.ExtractImageMetadata --docker dplsming/java8action-imagemagic -i
wsk action update transformMetadata transform-metadata.jar --main org.serverlessbench.TransformMetadata --docker openwhisk/java8action -i
wsk action update handler handler.jar --main org.serverlessbench.Handler --docker openwhisk/java8action -i
wsk action update thumbnail thumbnail.jar --main org.serverlessbench.Thumbnail --docker dplsming/java8action-imagemagic -i
wsk action update storeImageMetadata  store-image-metadata.jar --main org.serverlessbench.StoreImageMetadata --docker openwhisk/java8action -i

wsk action update imageProcessSequence --sequence extractImageMetadata,transformMetadata,handler,thumbnail,storeImageMetadata -i
