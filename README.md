# dbt_service

This is our dbt service, responsible for ingesting core user activity event logs and delivering key aggregates and analyses.

---

## Connecting to Snowflake

Configure your `~/.dbt/profiles.yaml` to connect using the `dev` profile or any profile of your choice.

---

## Models

- **RAW**: Contains raw JSON records ingested from S3 through a Snowflake stage.
- **STG**: Contains staged data — flattened, quarantined, and cleaned.
- **MART**: Contains aggregations and reports for analysis.

---

## Install Dependencies

Create and activate a virtual environment:

```bash
python3.10 -m venv dbt_venv && source dbt_venv/bin/activate
```
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
