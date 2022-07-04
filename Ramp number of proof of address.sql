SELECT
	COUNT((identity_accesses)) AS "NumberofProof_OF_ADDRESS",
	organizations.id AS "Organizations_id",
	organizations.name AS "Organizations_name",
	resources.type as "Resources_type"
	-- FROM
	-- 	identity_accesses
	-- 	LEFT JOIN identities ON identity_accesses.identity_id = identities.id
	-- 	LEFT JOIN projects ON identity_accesses.project_id = projects.id
	-- 	LEFT JOIN organization ON projects.id = orgazations.id
	-- 	LEFT JOIN resources.identity_id ON identities.id
FROM
	resources
	LEFT JOIN identities ON resources.identity_id = identities.id
	LEFT JOIN identity_accesses ON identities.id = identity_accesses.identity_id
	LEFT JOIN projects ON identity_accesses.project_id = projects.id
	LEFT JOIN organizations ON projects.organization_id = organizations.id
WHERE
	TO_CHAR (identity_accesses.created_at, 'YYYY-MM-DD') >= '2022-06-01'
	AND TO_CHAR (identity_accesses.created_at, 'YYYY-MM-DD') < '2022-07-01'
	AND resources.type = 'PROOF_OF_ADDRESS'
	AND organizations.id = '972'
GROUP BY
	organizations.id,
	organizations.name,
	resources.type