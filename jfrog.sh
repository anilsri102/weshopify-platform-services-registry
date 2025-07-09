#http://13.202.5.141:8082/artifactory/libs-snapshot-local/com/durgasoft/weshopify-platform-services-registry/

ARTIFACT_SERVER_URL=http://13.202.5.141:8082/artifactory
ARTIFACT_REPO_NAME=libs-snapshot-local
ARTIFACT_LOC=com/durgasoft/weshopify-platform-services-registry
ARTIFACT_VERSION=0.0.1-SNAPSHOT
#http://13.202.5.141:8082/artifactory/libs-snapshot-local/com/durgasoft/weshopify-platform-services-registry/0.0.1-SNAPSHOT
ARTIFACT_REPO_URL=$ARTIFACT_SERVER_URL/$ARTIFACT_REPO_NAME/$ARTIFACT_LOC/$ARTIFACT_VERSION
ARTIFACT_META_XML=maven-metadata.xml

#http://13.202.5.141:8082/artifactory/libs-snapshot-local/com/durgasoft/weshopify-platform-services-registry/0.0.1-SNAPSHOT/maven-metadata.xml

ARTIFACT_META_XML_URL=$ARTIFACT_REPO_URL/$ARTIFACT_META_XML


ARTIFACTORY_USER=admin
ARTIFACTORY_PASSWORD=Admin@123
ARTIFACTORY_NAME=weshopify-service-registry
ARTIFACTORY_ARTIFACT_NAME=weshopify-platform-services-registry

ARTIFACTORY_VERSION_WITHTIME_STAMP=$(curl -u $ARTIFACTORY_USER:$ARTIFACTORY_PASSWORD $ARTIFACT_META_XML_URL |grep '<value>' | head -1 | sed "s/.*<value>\([^<]*\)<\/value>.*/\1/")

#http://13.202.5.141:8082/artifactory
#libs-snapshot-local
#com/durgasoft/weshopify-platform-services-registry
#0.0.1-SNAPSHOT
#weshopify-platform-services-registry-
#0.0.1-20250709.111214-19.jar

FINAL_ARTIFACT_URL=$ARTIFACT_REPO_URL/$ARTIFACTORY_ARTIFACT_NAME-$ARTIFACTORY_VERSION_WITHTIME_STAMP.jar
echo 'FINAL_ARTIFACT_URL' $FINAL_ARTIFACT_URL

wget --user=$ARTIFACTORY_USER --password=$ARTIFACTORY_PASSWORD $FINAL_ARTIFACT_URL
echo 'FINAL_ARTIFACT_DOWNLOADED' $FINAL_ARTIFACT_URL
cp $ARTIFACTORY_ARTIFACT_NAME-$ARTIFACTORY_VERSION_WITHTIME_STAMP.jar ./app-dir/target/$ARTIFACTORY_NAME.jar
rm $ARTIFACTORY_ARTIFACT_NAME-*.jar