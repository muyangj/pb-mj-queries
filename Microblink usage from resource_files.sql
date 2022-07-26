-- Microblink usage from resources_files
SELECT
	count(DISTINCT resource_files.id) AS "number of resource files",
	resource_files.mime_type AS "mime_type",
	resource_files.page AS "pages",
	resource_files.status AS "status",
	TO_CHAR(resource_files.updated_at, 'YYYY-MM') AS "updated_at"
FROM
	resource_files
WHERE
	TO_CHAR(resource_files.updated_at, 'YYYY-MM-DD') >= '2021-07-21'
	AND TO_CHAR(resource_files.updated_at, 'YYYY-MM-DD') < '2022-07-22'
GROUP BY
	resource_files.mime_type,
	resource_files.status,
	resource_files.page,
	TO_CHAR(resource_files.updated_at, 'YYYY-MM')
ORDER BY
	"updated_at" DESC;

-- 1. the result shows that there are only 2 mime_types, NULL or video/mp4. Does it mean that we stopped writing image/png as mime_type?
-- 2. the result shows that there are files which has 3 pages. I checked a bit, usually they are proof of address. Do we scan proof of address?