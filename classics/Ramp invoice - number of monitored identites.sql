SELECT 
	COUNT(DISTINCT monitored_identities.id) AS "number of monitored_identities",
	--TO_CHAR(identity_accesses.created_at, 'YYYY-MM') AS "identity created at",
	organizations.name AS "organization name",
	-- projects.id AS "project id",
	organizations.stripe_customer_id AS "Stripe_id"
FROM
	monitored_identities
	LEFT JOIN identity_accesses ON monitored_identities.identity_access_id = identity_accesses.id
	LEFT JOIN projects ON identity_accesses.project_id = projects.id
	LEFT JOIN organizations ON projects.organization_id = organizations.id
WHERE
	monitored_identities.monitored = TRUE
	--AND organizations.id = '972'
	--AND identity_accesses.project_id IN(1962, 6783)
	AND organizations.stripe_customer_id = 'cus_HnBcxQXM2UjZhg'
	AND identity_accesses.status IN(6)
	AND identity_accesses.completed_at >= '2022-01-01'
	AND identity_accesses.completed_at < '2022-09-01'
GROUP BY
	--TO_CHAR(identity_accesses.created_at,'YYYY-MM'),
	organizations.name,
	organizations.stripe_customer_id
ORDER BY
	2