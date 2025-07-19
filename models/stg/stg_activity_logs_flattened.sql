{{ config(
    materialized='table',
    schema='STG',
    tags=['stg', 'flatten', 'activity_logs']
) }}

WITH source_data AS (
    SELECT
        *
    FROM {{ ref('raw_activity_logs') }}
),

/* -- Flatten the JSON structure to extract relevant fields
   -- Redact PII Data */

flattened_data AS (
    SELECT 
      flattened.value:company_id::STRING AS company_id,
      md5(flattened.value:admin_first_name::STRING) AS admin_first_name_redacted,
      md5(flattened.value:admin_last_name::STRING) AS admin_last_name_redacted,
      md5(flattened.value:admin_email::STRING) AS admin_email_redacted,
      md5(flattened.value:ip_address::STRING) AS ip_address_redacted,
      flattened.value:country_code::STRING AS country_code,
      flattened.value:country_name::STRING AS country_name,
      flattened.value:date_enrolled::TIMESTAMP_NTZ AS date_enrolled,

      -- Flattened properties array inside each JSON object
      properties.value:device_id::STRING AS device_id,
      properties.value:device_os::STRING AS device_os,
      properties.value:app_bundle_id::STRING AS app_bundle_id,
      properties.value:app_version::STRING AS app_version,
      current_timestamp() AS ingested_at_utc
    FROM source_data,
    LATERAL FLATTEN(input => VALUE) AS flattened,
    LATERAL FLATTEN(input => flattened.value:properties, outer => TRUE) AS properties
)

SELECT * FROM flattened_data