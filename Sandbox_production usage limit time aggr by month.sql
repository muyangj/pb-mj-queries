SELECT
    COUNT((identity_accesses.id)) as "NumberOfVerifications",
    organizations.id as "OrganizationID",
    organizations.name as "Organization name",
    organizations.stripe_customer_id as "Stripe_id",
    TO_CHAR(identity_accesses.created_at, 'YYYY-MM') as "identity_accesses_created_at",
    CASE
    	WHEN environment_type = 0 THEN 'Sandbox'
    	ELSE 'Production'
    END
FROM
    identity_accesses
    LEFT JOIN projects ON identity_accesses.project_id = projects.id
    LEFT JOIN organizations ON projects.organization_id = organizations.id

WHERE
    identity_accesses.status NOT IN (0, 1)
	and TO_CHAR(identity_accesses.created_at, 'YYYY-MM-DD') >= '2021-01-01'
	and environment_type = 0
GROUP BY
    organizations.id,
    environment_type,
    TO_CHAR(identity_accesses.created_at, 'YYYY-MM')
ORDER BY "NumberOfVerifications" DESC, organizations.id ASC;
--test2