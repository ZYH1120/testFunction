DIR=$(pwd)


wsk -i action update  alu   $DIR/cpu/alu.py
wsk -i action update  hellopy $DIR/cpu/hello.py


#note: need  change the couchdb config at the begin of the deploy_2.sh
cd $DIR/image-process/src
sh deploy_2.sh


#load image(need change the couchdb config at the begin of the begin of the upload_invoke.sh )
cd $DIR/image-process
sh ~/func/image-process/upload_invoke.sh

