#!/bin/bash
java -Xmx2g -jar osm2po-core-5.2.43-signed.jar cmd=tjspg prefix=australia tileSize=x https://download.geofabrik.de/australia-oceania/australia-latest.osm.pbf postp.0.class=de.cm.osm2po.plugins.postp.PgRoutingWriter postp.1.class = de.cm.osm2po.plugins.postp.PgVertexWriter
