SELECT COUNT(a.id)
FROM
    accesses AS a
    INNER JOIN trust_assessments AS ta ON (
        ta.id = (
            SELECT
                ta2.id
            FROM
                trust_assessments AS ta2
            WHERE
                ta2.access_id = a.id
            order by
                ta2.created_at desc
            limit
                1
        )
    )
WHERE
    ta.result ->> 'state' = 'VALID'
    --AND a.created_at >= $ 1 :: timestamptz
   -- AND a.created_at <= $ 2 :: timestamptz
    AND a.target_id in (
        SELECT
            t.id
        FROM
            organizations AS o
            INNER JOIN projects AS p ON p.organization_id = o.id
            INNER JOIN targets AS t ON t.project_id = p.id --
       -- WHERE
          --  o.id = $ 3 :: uuid
    );