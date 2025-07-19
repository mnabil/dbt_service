{{ config(
    materialized='table',
    schema='MART',
    tags=['mart', 'total', 'devices', 'oracle_app']
) }}
-- This model calculates the total number of devices enrolled in the system
-- specifically for Oracle applications.
SELECT
       COUNT(DISTINCT device_id) AS total_oracle_devices
  FROM {{ ref('stg_activity_logs_cleaned') }}
 WHERE lower(app_bundle_id) LIKE '%oracle%'
