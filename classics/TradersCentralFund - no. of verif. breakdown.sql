SELECT 
	DISTINCT identity_accesses.id AS "ia_id",
	identity_accesses.completed_at AS "ia_completed_at",
	projects.id as "proj_id"
FROM
	identity_accesses
	LEFT JOIN projects ON identity_accesses.project_id = projects.id
	LEFT JOIN organizations ON projects.organization_id = organizations.id
WHERE
	identity_accesses.status NOT IN(0, 1)
	AND TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') >= '2022-09-01'
	AND TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') < '2022-10-01'
	--AND identity_accesses.project_id = AND
	AND organizations.stripe_customer_id = 'cus_K0hk49Ujbb0moX'