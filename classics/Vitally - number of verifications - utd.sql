SELECT
	organizations.stripe_customer_id AS "Stripe_id",
	NOW() AS "Data synced on",
	SUM(CASE WHEN identity_accesses.completed_at >= (NOW() - INTERVAL '24 HOURS') THEN 1 ELSE 0 END) AS "Verification Volume (Past 24h)",
	SUM(CASE WHEN identity_accesses.completed_at BETWEEN (NOW() - INTERVAL '48 HOURS') AND (NOW() - INTERVAL '24 HOURS') THEN 1 ELSE 0 END) AS "Verification Volume (Previous 24h)",
	SUM(CASE WHEN identity_accesses.completed_at >= (NOW() - INTERVAL '7 DAYS') THEN 1 ELSE 0 END) AS "Verification Volume (Past 7d)",
	SUM(CASE WHEN identity_accesses.completed_at BETWEEN (NOW() - INTERVAL '14 DAYS') AND (NOW() - INTERVAL '7 DAYS') THEN 1 ELSE 0 END) AS "Verification Volume (Previous 7d)",
	SUM(CASE WHEN identity_accesses.completed_at >= (NOW() - INTERVAL '30 DAYS') THEN 1 ELSE 0 END) AS "Verification Volume (Past 30d)",
	SUM(CASE WHEN identity_accesses.completed_at BETWEEN (NOW() - INTERVAL '60 DAYS') AND (NOW() - INTERVAL '30 DAYS') THEN 1 ELSE 0 END) AS "Verification Volume (Previous 30d)",
	SUM(CASE WHEN identity_accesses.completed_at >= date_trunc('month', NOW()) THEN 1 ELSE 0 END) AS "Verification Volume (MTD)",
	SUM(CASE WHEN identity_accesses.completed_at >= date_trunc('year', NOW()) THEN 1 ELSE 0 END) AS "Verification Volume (YTD)",
	COUNT (DISTINCT identity_accesses.id) AS "Verification Volume (Total)"
FROM
	identity_accesses
	LEFT JOIN projects ON identity_accesses.project_id = projects.id
	LEFT JOIN organizations ON projects.organization_id = organizations.id
WHERE
	identity_accesses.status NOT IN(0, 1)
GROUP BY
	organizations.stripe_customer_id
ORDER BY
    "Verification Volume (Past 30d)" DESC;
