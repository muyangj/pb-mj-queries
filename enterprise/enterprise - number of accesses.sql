SELECT
	COUNT(DISTINCT accesses.id) AS "number of verifications",
	organization_profiles.name AS "organization_name",
	organizations.id AS "organization_id",
	TO_CHAR(accesses.updated_at, 'YYYY-MM') AS "trust_build_updated_at",
	analytics_trust_builds.status AS "trust_build_status",
	projects.environment AS "project_type"
FROM
	accesses
	LEFT JOIN targets ON targets.id = accesses.target_id
	LEFT JOIN analytics_trust_builds ON analytics_trust_builds.target_id = targets.id
	LEFT JOIN projects ON projects.id = targets.project_id
	LEFT JOIN organizations ON projects.organization_id = organizations.id
	LEFT JOIN organization_profiles on organizations.profile_id = organization_profiles.id
WHERE
	accesses.updated_at >= '2022-10-01'
	AND accesses.updated_at < '2022-12-01'
	AND organization_profiles.name NOT LIKE 'passbase'
	AND organization_profiles.name NOT LIKE 'Passbase'
	AND organization_profiles.name NOT LIKE 'pb'
	AND organization_profiles.name NOT LIKE 'Marc' 
GROUP BY
	TO_CHAR(accesses.updated_at, 'YYYY-MM'),
	analytics_trust_builds.status,
	organization_profiles.name,
	organizations.id,
	projects.environment
ORDER BY
	4