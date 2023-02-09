SELECT
	COUNT(DISTINCT aml_profiles.id) AS "Number of Watchlist",
	--organizations.id AS "OrganizationID",
	--organizations.name AS "OrganizationName",
	--organizations.stripe_customer_id AS "Stripe_id",
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM') as "IA created at"
FROM
	aml_profiles
	LEFT JOIN identities ON aml_profiles.identity_id = identities.id
	LEFT JOIN identity_accesses ON identities.id = identity_accesses.identity_id
	LEFT JOIN projects ON identity_accesses.project_id = projects.id
	LEFT JOIN organizations ON projects.organization_id = organizations.id
WHERE
	--identity_accesses.status in (6)
	--AND 
	organizations.stripe_customer_id = 'cus_HnBcxQXM2UjZhg' 
	AND TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') >= '2022-01-01'
	AND TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') < '2022-12-01'
GROUP BY
	--organizations.id,
	--organizations.name,
	--organizations.stripe_customer_id
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM')
ORDER BY 2