SELECT
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') AS "IA_completed_at",	
	COUNT(DISTINCT identity_accesses.id) AS "Number of Verifications"
FROM
	identity_accesses
WHERE
	identity_accesses.status NOT IN(0, 1)
	AND TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') >= '2022-01-01'
	AND TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') < '2022-11-08'
GROUP BY
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD')
ORDER BY
	TO_CHAR(identity_accesses.completed_at, 'YYYY-MM-DD') ASC;