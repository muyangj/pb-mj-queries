SELECT
	COUNT(DISTINCT identity_accesses.id) AS "Number of Proof_OF_ADDRESS",
	organizations.id AS "Organization_id",
	organizations.name AS "Organization_name",
	organizations.stripe_customer_id AS "Stripe_id",
	--projects.id AS "Project_id",
	resources.type AS "Resource_type"
	---identity_accesses.status AS "Status"
FROM
	resources
	LEFT JOIN identities ON resources.identity_id = identities.id
	LEFT JOIN identity_accesses ON identities.id = identity_accesses.identity_id
	LEFT JOIN projects ON identity_accesses.project_id = projects.id
	LEFT JOIN organizations ON projects.organization_id = organizations.id
WHERE
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') >= '2022-08-01'
	AND TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') < '2022-09-01'
	AND resources.type = 'PROOF_OF_ADDRESS'
	AND organizations.stripe_customer_id = 'cus_HnBcxQXM2UjZhg'
	--AND organizations.id = '972' -- ramp org.id 972
	--AND projects.id IN (6783, 1962) -- the projects that we are billing, dunno why we do not bill the other two projects.
	--AND identity_accesses.status IN (6) -- only charge the POA of successful verifications
GROUP BY
	organizations.id,
	organizations.name,
	--projects.id,
	resources.type
	--identity_accesses.status
--ORDER BY
	--"Project_id" ASC;