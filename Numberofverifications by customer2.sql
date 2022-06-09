SELECT
	COUNT((identity_accesses.id)) AS "NumberOfVerifications",
	organizations.id AS "OrganizationID",
	TO_CHAR(identity_accesses.created_at, 'YYYY-MM-DD') AS "identity_accesses_created_at"
FROM
	identity_accesses
	LEFT JOIN projects ON identity_accesses.project_id = projects.id
	LEFT JOIN organizations ON projects.organization_id = organizations.id
WHERE
	TO_CHAR(identity_accesses.created_at, 'YYYY-MM-DD') >= '2022-05-01'
	AND TO_CHAR(identity_accesses.created_at, 'YYYY-MM-DD') < '2022-06-01'
GROUP BY
	organizations.id,
	TO_CHAR(identity_accesses.created_at, 'YYYY-MM-DD')
ORDER BY
	"NumberOfVerifications" DESC;
