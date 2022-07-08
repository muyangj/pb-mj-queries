SELECT
	COUNT(DISTINCT identity_accesses.id) as "Number of Approved Verifications",
	organizations.id AS "Organization_id",
	organizations.name AS "Organization_name",
	organizations.stripe_customer_id AS "Stripe_id",
	projects.id AS "Project_id",
	identity_accesses.status as "Status"
FROM
    identity_accesses
    LEFT JOIN aml_profiles ON identity_accesses.identity_id = aml_profiles.identity_id
    LEFT JOIN projects ON identity_accesses.project_id = projects.id
    LEFT JOIN organizations on projects.organization_id = organizations.id
WHERE
    -- IDs are for the following Slugs same order ramp-0a5fd2a7, ramp-e8c15113,
    organizations.id = '972'
    AND identity_accesses.project_id IN (1962, 6783) 
    AND identity_accesses.status IN (6)
    -- DEFINE TIMEFRAME WITH ISO
    AND TO_CHAR(identity_accesses.created_at, 'YYYY-MM-DD') >= '2022-05-07' -- GOES BY UTC TIME
    AND TO_CHAR(identity_accesses.created_at, 'YYYY-MM-DD') < '2022-06-07' -- GOES BY UTC TIME
GROUP BY
	organizations.id,
	organizations.name,
	projects.id,
	identity_accesses.status
ORDER BY
	"Project_id" ASC;