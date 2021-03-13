#!/bin/bash
#
# Copyright (c) 2020 Institution of Parallel and Distributed System, Shanghai Jiao Tong University
# ServerlessBench is licensed under the Mulan PSL v1.
# You can use this software according to the terms and conditions of the Mulan PSL v1.
# You may obtain a copy of Mulan PSL v1 at:
#     http://license.coscl.org.cn/MulanPSL
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FIT FOR A PARTICULAR
# PURPOSE.
# See the Mulan PSL v1 for more details.
#

COUCHDB_USERNAME=whisk_admin
COUCHDB_IP=172.20.110.51
COUCHDB_PASSWORD=some_passw0rd
COUCHDB_PORT=31859
IMAGE_DATABASE=db_image
COUCHDB_LOGDB=db_imagelog


couchdb_url=http://$COUCHDB_USERNAME:$COUCHDB_PASSWORD@$COUCHDB_IP:$COUCHDB_PORT

# deploy.sh should be executed in parent dir of src
#ASSET_DIR=$(pwd)/assets
cd src


echo "3. uploading functions to OpenWhisk..."
wsk action update extractImageMetadata extract-image-metadata/target/extract-image-metadata.jar --main org.serverlessbench.ExtractImageMetadata --docker dplsming/java8action-imagemagic -i \
    --param COUCHDB_URL "$couchdb_url" \
    --param COUCHDB_USERNAME "$COUCHDB_USERNAME" \
    --param COUCHDB_PASSWORD "$COUCHDB_PASSWORD" \
    --param COUCHDB_DBNAME "$IMAGE_DATABASE"
 
wsk action update transformMetadata transform-metadata/target/transform-metadata.jar --main org.serverlessbench.TransformMetadata --docker openwhisk/java8action -i

wsk action update handler handler/target/handler.jar --main org.serverlessbench.Handler --docker openwhisk/java8action -i \
    --param COUCHDB_URL "$couchdb_url" \
    --param COUCHDB_USERNAME "$COUCHDB_USERNAME" \
    --param COUCHDB_PASSWORD "$COUCHDB_PASSWORD" \
    --param COUCHDB_LOGDB "$IMAGE_DATABASE_LOG"

wsk action update thumbnail thumbnail/target/thumbnail.jar --main org.serverlessbench.Thumbnail --docker openwhisk/java8action -i \
    --param COUCHDB_URL "$couchdb_url" \
    --param COUCHDB_USERNAME "$COUCHDB_USERNAME" \
    --param COUCHDB_PASSWORD "$COUCHDB_PASSWORD" \
    --param COUCHDB_DBNAME "$IMAGE_DATABASE"

wsk action update storeImageMetadata  store-image-metadata/target/store-image-metadata.jar --main org.serverlessbench.StoreImageMetadata --docker openwhisk/java8action -i \
    --param COUCHDB_URL "$couchdb_url" \
    --param COUCHDB_USERNAME "$COUCHDB_USERNAME" \
    --param COUCHDB_PASSWORD "$COUCHDB_PASSWORD" \
    --param COUCHDB_DBNAME "$IMAGE_DATABASE"

wsk action update imageProcessSequence --sequence extractImageMetadata,transformMetadata,handler,thumbnail,storeImageMetadata -i

