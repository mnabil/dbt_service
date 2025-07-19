# dbt_service
Our dbt service which will extract our core data event logs ingesting our core user activity event logs and will deliver the following aggregates and analyses

# connecting to snowflake
configure your `~/.dbt/profiles.yaml` to connect to snowflake `dev` profile or profile our your choice

# models

RAW : contains Raw JSON records ingested data from S3 through a snowflake Stage

STG : contains our Staged data, flattened, quarantined & cleaned

MART : containing our aggregations & reports for analyis


# install dependencies

 in your working directory `python3.10 -m venv dbt_venv && soruce dbt_venv/bin/activate` and `pip install --pre dbt-core dbt-snowflake`

 `dbt deps` install package dependencies for dbt itself

# dbt docs
 `dbt docs generate`

# generate our docs
 `dbt docs serve`

# seed dbt with our filtered data
 `dbt seed`

# compile models
 `dbt compile`

# run our and reflect into our snowflake data warehouse
 `dbt run`

# test models
 `dbt test`

# check source freshness
`dbt source freshness`
 Check if our data is updated daily depending on freshness criteria defined in our model/schema.yml

# to clean our environment if we want to start a run a clean run
 `dbt clean`


Best,
Mahmoud
