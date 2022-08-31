-- ID R&D report
SELECT
	COUNT(DISTINCT identity_accesses.id) AS "identity_accesss_id",
	TO_CHAR(identity_accesses.created_at, 'YYYY-MM') as "created_at"
FROM
	identity_accesses
WHERE
	identity_accesses.status NOT IN(0, 1)
	AND TO_CHAR(identity_accesses.created_at, 'YYYY-MM-DD') >= '2022-01-01'
	AND TO_CHAR(identity_accesses.created_at, 'YYYY-MM-DD') < '2022-09-01'
GROUP BY
	TO_CHAR(identity_accesses.created_at, 'YYYY-MM')
ORDER BY
	"created_at" ASC;