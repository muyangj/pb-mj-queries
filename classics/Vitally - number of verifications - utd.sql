SELECT
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') AS "IA_completed_at",	
	organizations.stripe_customer_id AS "Stripe_id",
	COUNT(DISTINCT identity_accesses.id) AS "Number of Verifications"
FROM
	identity_accesses
	LEFT JOIN projects ON identity_accesses.project_id = projects.id
	LEFT JOIN organizations ON projects.organization_id = organizations.id
WHERE
	identity_accesses.status NOT IN(0, 1)
	AND TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') >= '2022-01-01'
	AND identity_accesses.completed_at < CURRENT_DATE
GROUP BY
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD'),
	organizations.stripe_customer_id
ORDER BY
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') ASC;