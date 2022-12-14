SELECT
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') AS "IA_completed_at",
	COUNT(DISTINCT identity_accesses.id) as "Number of Approved Verifications",
	organizations.id AS "Organization_id",
	organizations.name AS "Organization_name",
	organizations.stripe_customer_id AS "Stripe_id"
	--DATE_PART('week', identity_accesses.completed_at) AS "IA_completed_at_iso_week",
	--DATE_PART('dow', identity_accesses.completed_at) AS "IA_completed_at_weekday",
	--projects.id AS "Project_id",
	--identity_accesses.status as "Status"
FROM
    identity_accesses
    LEFT JOIN aml_profiles ON identity_accesses.identity_id = aml_profiles.identity_id
    LEFT JOIN projects ON identity_accesses.project_id = projects.id
    LEFT JOIN organizations on projects.organization_id = organizations.id
WHERE
	organizations.stripe_customer_id = 'cus_FZ817KnjHRVel1'
    --organizations.id = '972' -- Ramp org_id is 972
    --AND identity_accesses.project_id IN (1962, 6783) -- IDs are for the following Slugs same order ramp-0a5fd2a7, ramp-e8c15113,
    AND identity_accesses.status IN (6, 7) -- status 6 means it is approved
    -- DEFINE TIMEFRAME WITH ISO
    AND TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') >= '2022-01-01' -- GOES BY UTC TIME
    AND TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') < '2022-12-14' -- GOES BY UTC TIME
GROUP BY
	organizations.id,
	organizations.name,
	--DATE_PART('week', identity_accesses.completed_at),
	--DATE_PART('dow', identity_accesses.completed_at),
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD')
	--projects.id,
	--identity_accesses.status
ORDER BY
	5