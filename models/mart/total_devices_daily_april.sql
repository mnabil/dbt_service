{{ config(
    materialized='table',
    schema='MART',
    tags=['mart', 'total', 'devices', 'april_2025']
) }}
-- This model calculates the total number of unique devices enrolled in the system
-- for the month of April 2025, based on the date_enrolled field in the activity logs.
SELECT
       DATE(date_enrolled) AS enrollment_date,
       COUNT(DISTINCT device_id) AS total_devices
  FROM {{ ref('stg_activity_logs_cleaned') }}
 WHERE DATE_TRUNC('month', date_enrolled) = '2025-04-01'
 GROUP BY 1
 ORDER BY 1