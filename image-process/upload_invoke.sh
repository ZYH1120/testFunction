
COUCHDB_USERNAME=whisk_admin
COUCHDB_IP=172.20.110.51
COUCHDB_PASSWORD=some_passw0rd
COUCHDB_PORT=31859
IMAGE_DATABASE=db_image
COUCHDB_LOGDB=db_imagelog
image_name=test5.jpg

couchdb_url=http://$COUCHDB_USERNAME:$COUCHDB_PASSWORD@$COUCHDB_IP:$COUCHDB_PORT



echo "2. uploading image to be processed"
image=./$image_name
if [ ! -f $image ]; then
    echo "image $image does not exist, quit."
    exit
fi
java -cp ./upload-image.jar org.serverlessbench.UploadImage $image $image_name  $couchdb_url $COUCHDB_USERNAME $COUCHDB_PASSWORD $IMAGE_DATABASE

sleep 6

wsk action invoke imageProcessSequence -i --result --param imageName $image_name

