SELECT
	TO_CHAR(trust_builder_trust_builds.updated_at, 'YYYY-MM') AS "trust_build_updated_at",
	organization_profiles.name AS "organization_name",
	organizations.id AS "organization_id",
	organizations.profile_id AS "organization_profile_id",
	COUNT(DISTINCT trust_builder_trust_builds.id) AS "number_of_trust_builds"
	--(trust_assessments."result" ->> 'state') AS "State"
FROM
	trust_builder_trust_builds
	LEFT JOIN targets ON targets.id = trust_builder_trust_builds.target_id
	--LEFT JOIN accesses ON accesses.target_id = targets.id
	--LEFT JOIN trust_assessments ON accesses.id = trust_assessments.access_id
	LEFT JOIN projects ON projects.id = targets.project_id
	LEFT JOIN organizations ON projects.organization_id = organizations.id
	LEFT JOIN organization_profiles ON organizations.profile_id = organization_profiles.id
	
WHERE	
	organizations.id NOT IN (
	'37224886-12ca-418c-9a83-71ec45e82ca1', -- organization_profiles.name = 'passbase.com'
	'72d0fc51-e792-4b41-aa82-b6785bef9018', -- organization_profiles.name = 'Marc Morant PB'
	'379c13fb-32e5-432a-a39b-f80a31650972', -- organization_profiles.name = 'Passbase Labs'
	'0dd206db-6436-4338-83c5-fc028d18864b', -- organization_profiles.name = 'Passbase Labs'
	'6489dee1-5cd5-4015-a324-358ae5b99751', -- organization_profiles.name = 'passbase'
	'657ab6d2-dac2-4409-b48a-4001b6531c74', -- organization_profiles.name = 'passbase'
	'a1f8deb9-075f-4ca3-a787-be0cc0781f54', -- organization_profiles.name = 'Passbase'
	'e68c0d0d-cad5-465d-b4fd-9ad87c1b3a57', -- organization_profiles.name = 'Passbase'
	'0e920dab-309d-4454-b719-23b36453396e', -- organization_profiles.name = 'Passbase'
	'a2e1468f-a945-4ecc-9e20-4dc1a0a83eb9', -- organization_profiles.name = 'Passbase'
	'60c8caae-5530-41d6-9052-a965153eba76', -- organization_profiles.name = 'Passbase'
	'c663d24c-a96a-4ed7-875f-916ae14dc1a6', -- organization_profiles.name = 'Passbase'
	'b909abe5-7573-443d-a7c4-7fbc7c6b3c54', -- organization_profiles.name = 'Passbase'
	'771b8576-626b-4fe4-927b-4bfe6bf0c758', -- organization_profiles.name = 'Passbase'
	'85cbc5d2-fcaf-43b6-947c-3499af44ccef', -- organization_profiles.name = 'Passbase'
	'fbd5e73a-2f5e-4340-905e-0bc2d433fb79', -- organization_profiles.name = 'Passbase's
	'17c0d7dc-5508-4694-b8b7-d3f553347a23' -- organization_profiles.name = 'YZ Test'
		)
	AND trust_builder_trust_builds.updated_at >= '2022-12-01'
	AND trust_builder_trust_builds.updated_at < '2023-01-01'
	AND trust_builder_trust_builds.completed = 't'
GROUP BY
	TO_CHAR(trust_builder_trust_builds.updated_at, 'YYYY-MM'),
	organization_profiles.name,
	organizations.id,
	organizations.profile_id
	--trust_assessments."result" ->> 'state'
/*ORDER BY
	"trust_build_updated_at" DESC,
	"number_of_trust_builds" DESC,
	"organization_name" ASC;*/
