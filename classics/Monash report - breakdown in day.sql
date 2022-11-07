SELECT
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') AS "IA_completed_at",
	organizations.stripe_customer_id AS "organization_stripe_id",
	projects.name as "project_name",
	projects.slug as "project_slug",
	COUNT(DISTINCT identity_accesses.id) AS "NumberOfVerifications"
FROM
	identity_accesses
	LEFT JOIN projects ON identity_accesses.project_id = projects.id
	LEFT JOIN organizations ON projects.organization_id = organizations.id
WHERE
	identity_accesses.status NOT IN(0, 1)
	AND TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') >= '2022-01-01'
	AND TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') < '2022-11-01'
	AND organizations.stripe_customer_id = 'cus_JqkUvXJz0R37QW'
GROUP BY
	organizations.stripe_customer_id,
	projects.name,
	projects.slug,
	identity_accesses.project_id,
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD')
ORDER BY
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') ASC;