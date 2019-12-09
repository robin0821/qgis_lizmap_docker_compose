#! /bin/sh

# java -Xmx1g -jar osm2po-core-5.2.43-signed.jar prefix=hh tileSize=x https://download.geofabrik.de/australia-oceania/australia-latest.osm.pbf postp.0.class=de.cm.osm2po.plugins.postp.PgRoutingWriter

java -Xmx8g -jar osm2po-core-5.2.43-signed.jar prefix=venus tileSize=x cmd=tjspg https://download.geofabrik.de/australia-oceania/australia-latest.osm.pbf
