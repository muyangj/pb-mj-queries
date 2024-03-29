SELECT
	COUNT(DISTINCT identity_accesses.id) AS "NumberOfVerifications",
	--organizations.id AS "OrganizationID",
	--organizations.name AS "OrganizationName",
	organizations.stripe_customer_id AS "Stripe_id",
	--identity_accesses.project_id AS "Project_id",
	/*CASE WHEN environment_type = 0 THEN
		'Sandbox'
	ELSE
		'Production'
	END AS "Plan_type",*/
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM') AS "IA_completed_at"
FROM
	identity_accesses
	LEFT JOIN projects ON identity_accesses.project_id = projects.id
	LEFT JOIN organizations ON projects.organization_id = organizations.id
WHERE
	identity_accesses.status NOT IN(0, 1)
	AND TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') >= '2022-12-01'
	AND TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') < '2023-01-01'
	--AND environment_type <> 0
	AND organizations.stripe_customer_id = 'cus_KUqspPaNT4plIk'
	--AND organizations.id IN (6988)
GROUP BY
	--organizations.id,
	--organizations.name,
	--environment_type,
	organizations.stripe_customer_id,
	--identity_accesses.project_id,
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM')
ORDER BY
	--"NumberOfVerifications" DESC;
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM') ASC;