-- ID R&D report
SELECT
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM') as "completed_at",
	COUNT(DISTINCT identity_accesses.id) AS "identity_accesss_id"
FROM
	identity_accesses
WHERE
	identity_accesses.status NOT IN(0, 1)
	AND TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') >= '2021-05-01'
	AND TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') < '2022-11-01'
GROUP BY
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM')
ORDER BY
	"completed_at" ASC;