SELECT
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM') as "IA created at",
	organizations.stripe_customer_id AS "Stripe_id",
	organization_profiles.name as "org_name",
	COUNT(DISTINCT aml_profiles.id) AS "Number of Watchlist"
FROM
	aml_profiles
	LEFT JOIN identities ON aml_profiles.identity_id = identities.id
	LEFT JOIN identity_accesses ON identities.id = identity_accesses.identity_id
	LEFT JOIN projects ON identity_accesses.project_id = projects.id
	LEFT JOIN organizations ON projects.organization_id = organizations.id
	LEFT JOIN organization_profiles on organization_profiles.organization_id = organizations.id
WHERE
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') >= '2022-01-01'
	AND TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') < '2022-11-01'
	AND organizations.stripe_customer_id = 'cus_KPzWRKcKWuhPfl'
GROUP BY
	organization_profiles.name,
	organizations.stripe_customer_id,
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM')
ORDER BY 
	"Number of Watchlist" DESC;