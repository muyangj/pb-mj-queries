SELECT
	COUNT(DISTINCT identity_accesses.id) AS "Number of Verifications",
	organizations.stripe_customer_id AS "Stripe_id",
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM') AS "IA_completed_at"
FROM
	identity_accesses
	LEFT JOIN projects ON identity_accesses.project_id = projects.id
	LEFT JOIN organizations ON projects.organization_id = organizations.id
WHERE
	identity_accesses.status NOT IN(0, 1)
	AND TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') >= '2022-12-01'
	AND TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') < '2022-01-01'
	AND organizations.stripe_customer_id = 'cus_KEs4EE1dM5eMIT'
GROUP BY
	organizations.stripe_customer_id,
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM')
ORDER BY
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM') ASC;