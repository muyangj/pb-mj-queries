SELECT
	COUNT(identity_accesses.id) AS "Number of Sandbox verifications",
	organizations.id AS "OrganizationID",
	organizations.name AS "Organization name",
	organizations.stripe_customer_id AS "Stripe_id",
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM') AS "identity_accesses_created_at",
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
	AND TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') >= '2022-01-01'
	AND TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') < '2022-08-01'
	--AND environment_type = 0
	--AND organizations.stripe_customer_id = 'cus_IPYE1aSjnrAQ1H'
GROUP BY
	organizations.id,
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM'),
	environment_type
ORDER BY
	--"Number of Sandbox verifications" DESC,
	"identity_accesses_created_at" DESC;
