{{ config(
    materialized='table',
    schema='MART',
    tags=['mart', 'total', 'devices', 'eu_na']
) }}
-- This model calculates the total number of devices enrolled in the system
-- specifically in the European Union and North America regions.
-- It counts distinct device IDs based on the country name in the activity logs.
SELECT
       COUNT(DISTINCT device_id) AS devices_in_eu_and_na
  FROM {{ ref('stg_activity_logs_cleaned') }}
 WHERE lower(country_name) IN (
       -- EU countries
       'france', 'germany', 'italy', 'spain', 'netherlands', 'sweden', 'poland',
       'belgium', 'austria', 'denmark', 'finland', 'ireland', 'portugal',
       -- North America
       'united states', 'canada', 'mexico'
)