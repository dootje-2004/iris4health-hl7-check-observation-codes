# This script is meant to be called from Dockerfile as user irisowner.

echo "\nRunning ${0} as `whoami`\n"

# Rename expired certificate file (prevents unhealthy container state).
mv /usr/irissys/dev/CAcerts/AllCA.cer /usr/irissys/dev/CAcerts/AllCA.cer.renamed

# Start the container.
iris start $ISC_PACKAGE_INSTANCENAME

# Call COS script.
iris session $ISC_PACKAGE_INSTANCENAME < $SRC_DIR/init.cos

# Shut down and clean up, so iris-main can start up cleanly.
iris stop $ISC_PACKAGE_INSTANCENAME quietly
rm -f $ISC_PACKAGE_INSTALLDIR/mgr/journal.log
rm -f $ISC_PACKAGE_INSTALLDIR/mgr/IRIS.WIJ
rm -f $ISC_PACKAGE_INSTALLDIR/mgr/iris.ids
rm -f $ISC_PACKAGE_INSTALLDIR/mgr/alerts.log
rm -f $ISC_PACKAGE_INSTALLDIR/mgr/journal/*
: > $ISC_PACKAGE_INSTALLDIR/mgr/messages.log
