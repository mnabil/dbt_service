{{ config(
    materialized='table',
    schema='MART',
    tags=['mart', 'total', 'companies', 'android_44']
) }}
-- This model calculates the total number of companies enrolled in the system
-- for the month of March 2025, specifically for those using Android 4.4
SELECT
       COUNT(DISTINCT company_id) AS companies_enrolled_with_android_44
  FROM {{ ref('stg_activity_logs_cleaned') }}
 WHERE DATE_TRUNC('month', date_enrolled) = '2025-03-01'
   AND device_os ILIKE 'Android 4.4%'
