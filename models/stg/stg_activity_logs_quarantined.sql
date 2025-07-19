{{ config(
    materialized='table',
    schema='STG',
    tags=['stg', 'quarantined', 'activity_logs']
) }}

WITH 
flattened AS (
    SELECT
        *
    FROM {{ ref('stg_activity_logs_flattened') }}
),
quarantine_seed AS (
    SELECT
        *
    FROM {{ ref('quarantine_seed') }}
),

/* -- Select null company_id to quarantine the data
   -- Redact PII Data */

quarantined_logs AS (
    SELECT *
    FROM flattened
    WHERE company_id IS NULL
       OR company_id IN (SELECT company_id FROM quarantine_seed)
)

-- Final result
SELECT *
FROM quarantined_logs