{{ config(
    materialized='table',
    schema='STG',
    tags=['stg', 'cleaned', 'activity_logs']
) }}

/* -- Select not null company_id
             date_enrolled converted to 
             California timezoned  */

WITH 
quarantine_data AS (
    SELECT
        *
    FROM {{ ref('stg_activity_logs_quarantined') }}
),
cleaned_logs AS (
   SELECT  
          company_id,
          admin_first_name_redacted,
          admin_last_name_redacted,
          admin_email_redacted,
          ip_address_redacted,
          country_code,
          country_name,
          CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', date_enrolled) as date_enrolled,
          'America/Los_Angeles' AS date_enrolled_timezone,
          device_id,
          device_os,
          app_bundle_id,
          app_version
     FROM {{ ref('stg_activity_logs_flattened') }}
    WHERE company_id IS NOT NULL
      AND NOT EXISTS (
              SELECT 1
                FROM quarantine_data
               WHERE quarantine_data.company_id = stg_activity_logs_flattened.company_id
        )
)
-- Final cleaned result
SELECT *
FROM cleaned_logs