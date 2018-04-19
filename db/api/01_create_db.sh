##
# Create the cshr database

export PGPASSWORD=${1}
export ENV=${2}
export DB_USER=postgresqladmin@rpg-${ENV}-db-candidate-interface-db

export DB_HOST=rpg-${ENV}-db-candidate-interface-db.postgres.database.azure.com

psql -U ${DB_USER} -p ${DB_PASS} -h ${DB_HOST} -d postgres < create_db.sql 