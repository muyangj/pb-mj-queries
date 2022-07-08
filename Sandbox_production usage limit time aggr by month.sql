SELECT
	COUNT((identity_accesses.id)) AS "Number of Sandbox verifications",
	organizations.id AS "OrganizationID",
	organizations.name AS "Organization name",
	organizations.stripe_customer_id AS "Stripe_id",
	TO_CHAR(identity_accesses.created_at, 'YYYY') AS "identity_accesses_created_at",
	CASE WHEN environment_type = 0 THEN
		'Sandbox'
	ELSE
		'Production'
	END AS "Plan_type"
FROM
	identity_accesses
	LEFT JOIN projects ON identity_accesses.project_id = projects.id
	LEFT JOIN organizations ON projects.organization_id = organizations.id
WHERE
	identity_accesses.status NOT IN(0, 1)
	AND TO_CHAR(identity_accesses.created_at, 'YYYY-MM-DD') >= '2022-04-01'
	AND TO_CHAR(identity_accesses.created_at, 'YYYY-MM-DD') < '2022-07-01'
	AND environment_type = 0
GROUP BY
	organizations.id,
	TO_CHAR(identity_accesses.created_at, 'YYYY'),
	environment_type
ORDER BY
	"Number of Sandbox verifications" DESC,
	"identity_accesses_created_at" DESC;
