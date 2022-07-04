SELECT
	COUNT((identity_accesses.id)) AS "NumberOfVerifications",
	organizations.id AS "OrganizationID",
	organizations.name AS "OrganizationName",
	organizations.stripe_customer_id AS "Stripe_id",
	identity_accesses.project_id AS "ProjectId",
	TO_CHAR(identity_accesses.created_at, 'YYYY-MM-DD') AS "identity_accesses_created_at",
CASE 
	WHEN identity_accesses.status = 5 THEN'Pending'
	WHEN identity_accesses.status = 6 THEN 'Approved'
	ELSE 'Rejected'
END AS "Identity_accesses_status",
CASE 
	WHEN environment_type = 0 THEN 'Sandbox'
	ELSE 'Production'
END AS "Plan_type"
FROM
	identity_accesses
	LEFT JOIN projects ON identity_accesses.project_id = projects.id
	LEFT JOIN organizations ON projects.organization_id = organizations.id
WHERE
	identity_accesses.status NOT IN(0, 1)
	AND TO_CHAR(identity_accesses.created_at, 'YYYY-MM-DD') >= '2022-05-01'
	AND TO_CHAR(identity_accesses.created_at, 'YYYY-MM-DD') < '2022-06-01'
GROUP BY
	organizations.id,
	identity_accesses.status,
	environment_type,
	TO_CHAR(identity_accesses.created_at, 'YYYY-MM-DD')
ORDER BY
	"NumberOfVerifications" DESC;
	--"identity_accesses_created_at" ASC;