SELECT
	COUNT(DISTINCT identity_accesses.id) AS "NumberOfVerifications",
	identity_accesses.project_id as "project_id",
	projects.organization_id as "organization_id",
	TO_CHAR(identity_accesses.created_at, 'YYYY-MM-DD') AS "identity_accesses_created_at"
FROM
	identity_accesses
	LEFT JOIN projects ON identity_accesses.project_id = projects.id
	LEFT JOIN organizations ON projects.organization_id = organizations.id
WHERE
	TO_CHAR(identity_accesses.created_at, 'YYYY-MM-DD') >= '2022-06-01'
	AND TO_CHAR(identity_accesses.created_at, 'YYYY-MM-DD') < '2022-07-01'
GROUP BY
	identity_accesses.project_id,
	projects.organization_id,
	TO_CHAR(identity_accesses.created_at, 'YYYY-MM-DD')
ORDER BY
	"NumberOfVerifications" DESC;
