EXPORT = export PYTHONPATH=$(PWD)
MIG_NAME = "tmp to delete"
include .env
db:
	psql -c "DROP DATABASE IF EXISTS harmony_product"
	#psql -c "DROP ROLE IF EXISTS flanb"
	#psql -c "CREATE USER flanb WITH SUPERUSER PASSWORD 'fb0109##'"
	psql -c "CREATE DATABASE harmony_product OWNER flanb"

db_test:
	psql -c "DROP DATABASE IF EXISTS harmony_product_test"
	psql -c "CREATE DATABASE harmony_product_test OWNER flanb"

migration:
	$(EXPORT) && pipenv run alembic revision --autogenerate -m $(MIG_NAME)

upgrade:
	$(EXPORT) && pipenv run alembic upgrade head

downgrade:
	$(EXPORT) && pipenv run alembic downgrade -1

shell:
	$(EXPORT) && pipenv run python

checks:
	$(EXPORT) && pipenv run sh scripts/checks.sh

tests:
	$(EXPORT) && pipenv run sh scripts/test.sh

dev-db-sync:
	echo $(DEV_DB_HOST)
	echo $(DEV_DB_PW)
	echo $(DEV_DB_USER)
	echo $(POSTGRES_DB)
	PGPASSWORD=$(DEV_DB_PW) pg_dump -C -h $(DEV_DB_HOST) -U $(DEV_DB_USER) $(POSTGRES_DB) | psql -h localhost -U $(POSTGRES_USER) $(POSTGRES_DB)

stage-db-sync:
	echo $(STAGE_DB_HOST)
	echo $(STAGE_DB_PW)
	echo $(STAGE_DB_USER)
	echo $(POSTGRES_DB)
	PGPASSWORD=$(STAGE_DB_PW) pg_dump -C -h $(STAGE_DB_HOST) -U $(STAGE_DB_USER) $(POSTGRES_DB) | psql -h localhost -U $(POSTGRES_USER) $(POSTGRES_DB)

local-db-reset:
	psql -h localhost -p $(POSTGRES_PORT) -U $(POSTGRES_USER) $(POSTGRES_DB) -t -c "select 'drop table \"' || tablename || '\" cascade;' from pg_tables where schemaname='public'" | psql -h localhost -p $(POSTGRES_PORT) -U $(POSTGRES_USER) $(POSTGRES_DB)


cov-report:
	pipenv run pytest --cov-config=.coveragerc --cov-report=xml --cov=app app/tests -s
