-- TradersFundCenter
SELECT
	COUNT(DISTINCT identity_accesses.id) AS "NumberOfVerifications",
	--TO_CHAR(identity_accesses.created_at, 'YYYY-MM') as "created_at",
	identity_accesses.status as "Status"
FROM
	identity_accesses
WHERE
	identity_accesses.status NOT IN(0, 1)
	AND TO_CHAR(identity_accesses.created_at, 'YYYY-MM-DD') >= '2022-05-23'
	AND TO_CHAR(identity_accesses.created_at, 'YYYY-MM-DD') < '2022-06-23'
	AND identity_accesses.project_id = 7872
GROUP BY
	--TO_CHAR(identity_accesses.created_at, 'YYYY-MM'),
	identity_accesses.status
--ORDER BY
--	"created_at" DESC;