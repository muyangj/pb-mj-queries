-- Microblink usage from resources
SELECT
	count(DISTINCT resources.id) AS "number of resources",
	resources.type AS "type",
	TO_CHAR(resources.updated_at, 'YYYY-MM') AS "updated_at"
FROM
	resources
	LEFT JOIN identities ON resources.identity_id = identities.id
	LEFT JOIN identity_accesses ON identities.id = identity_accesses.identity_id
WHERE
	TO_CHAR(resources.updated_at, 'YYYY-MM-DD') >= '2021-07-21'
	AND TO_CHAR(resources.updated_at, 'YYYY-MM-DD') < '2022-07-21'
	AND identity_accesses.status NOT IN(0, 1) -- this line does not work here, though it should have.
	AND resources.type <> 'SELFIE_VIDEO'
	AND resources.type <> 'COVID_VACCINATION_CARD'
	AND resources.type <> 'PROOF_OF_ADDRESS'
	AND resources.type <> 'HEALTH_INSURANCE_CARD'
GROUP BY
	resources.type,
	TO_CHAR(resources.updated_at, 'YYYY-MM')
ORDER BY
	"updated_at" DESC;