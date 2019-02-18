
source /env-data.sh

# This script will setup the necessary folder for database

# test if DATADIR is existent
if [[ ! -d ${DATADIR} ]]; then
	echo "Creating Postgres data at ${DATADIR}"
	mkdir -p ${DATADIR}
fi
