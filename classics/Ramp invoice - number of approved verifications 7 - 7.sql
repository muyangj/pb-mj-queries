SELECT
	COUNT(DISTINCT identity_accesses.id) as "Number of Approved Verifications",
	organizations.id AS "Organization_id",
	organizations.name AS "Organization_name",
	organizations.stripe_customer_id AS "Stripe_id",
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM') AS "IA_completed_at"
	--projects.id AS "Project_id",
	--identity_accesses.status as "Status"
FROM
    identity_accesses
    LEFT JOIN aml_profiles ON identity_accesses.identity_id = aml_profiles.identity_id
    LEFT JOIN projects ON identity_accesses.project_id = projects.id
    LEFT JOIN organizations on projects.organization_id = organizations.id
WHERE
	organizations.stripe_customer_id = 'cus_HnBcxQXM2UjZhg'
    --organizations.id = '972' -- Ramp org_id is 972
    --AND identity_accesses.project_id IN (1962, 6783) -- IDs are for the following Slugs same order ramp-0a5fd2a7, ramp-e8c15113,
    AND identity_accesses.status IN (6) -- status 6 means it is approved
    -- DEFINE TIMEFRAME WITH ISO
    AND TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') >= '2023-01-01' -- GOES BY UTC TIME
    AND TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') < '2023-02-01' -- GOES BY UTC TIME
GROUP BY
	organizations.id,
	organizations.name,
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM')
	--projects.id,
	--identity_accesses.status
--ORDER BY
	--"IA_created_at" ASC;