SELECT
	COUNT((identity_accesses.id)) as "Number of Approved Verifications",
	--TO_CHAR(identity_accesses.created_at, 'YYYY-MM-DD') as "IA.derived_CREATED_AT",
	identity_accesses.project_id,
    CASE
        WHEN (identity_accesses.status = 0) THEN 'CREATED'
        WHEN (identity_accesses.status = 1) THEN 'PROCESSING'
        WHEN (identity_accesses.status = 5) THEN 'PENDING'
        WHEN (identity_accesses.status = 6) THEN 'APPROVED'
        WHEN (identity_accesses.status = 7) THEN 'DECLINED'
        ELSE 'ERROR'
    END AS "IA.mapped_STATUS"
FROM
    identity_accesses
    LEFT JOIN aml_profiles ON identity_accesses.identity_id = aml_profiles.identity_id
WHERE
    -- IDs are for the following Slugs same order ramp-0a5fd2a7, ramp-e8c15113,
    identity_accesses.project_id IN (1962, 6783) 
    AND identity_accesses.status IN (6)
    -- DEFINE TIMEFRAME WITH ISO
    AND TO_CHAR(identity_accesses.created_at, 'YYYY-MM-DD') >= '2022-05-07' -- GOES BY UTC TIME -- I want to make the date dynamic to the latest billing cycle, but not efficient with multiple cast()
    AND TO_CHAR(identity_accesses.created_at, 'YYYY-MM-DD') < '2022-06-07' -- GOES BY UTC TIME
GROUP BY
	identity_accesses.project_id,
	identity_accesses.status
ORDER BY
	2