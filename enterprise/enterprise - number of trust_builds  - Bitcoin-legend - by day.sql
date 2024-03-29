SELECT
	TO_CHAR(trust_builder_trust_builds.updated_at, 'YYYY-MM-DD') AS "trust_build_updated_at",
	COUNT(DISTINCT trust_builder_trust_builds.id) AS "number_of_trust_builds",
	organization_profiles.name AS "organization_name",
	organizations.id AS "organization_id"
FROM
	trust_builder_trust_builds
	LEFT JOIN targets ON targets.id = trust_builder_trust_builds.target_id
	LEFT JOIN projects ON projects.id = targets.project_id
	LEFT JOIN organizations ON projects.organization_id = organizations.id
	LEFT JOIN organization_profiles ON organizations.profile_id = organization_profiles.id
WHERE
	organizations.id = '7f60b84d-9ee7-43da-9a5f-bfb4081fb10e' -- organiztions.id = Bitcoin Ledgend
	AND trust_builder_trust_builds.updated_at >= '2023-01-01'
	AND trust_builder_trust_builds.updated_at < '2023-02-01'
	AND trust_builder_trust_builds.completed = 't'
GROUP BY
	TO_CHAR(trust_builder_trust_builds.updated_at, 'YYYY-MM-DD'),
	organization_profiles.name,
	organizations.id
ORDER BY
	"trust_build_updated_at" ASC;