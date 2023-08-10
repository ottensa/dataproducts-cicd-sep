SELECT
    ps.supplycost as co2_cost,
    s.name SupplierName,
    n.name Nation,
    p.partkey,
    p.mfgr,
    s.address,
    s.phone,
    s.comment
FROM sqlserver.esg.part p, postgresql.esg.supplier s, postgresql.esg.partsupp ps, glue.demo_schema.nation n, glue.demo_schema.region r
WHERE ((p.partkey = ps.partkey) 
AND (s.suppkey = ps.suppkey)
AND (p.type LIKE '%BRASS')
AND (s.nationkey = n.nationkey)
AND (n.regionkey = r.regionkey)
AND (r.name = 'EUROPE') 
AND (ps.supplycost = (
    SELECT MIN(ps.supplycost)
    FROM postgresql.esg.partsupp ps, postgresql.esg.supplier s, glue.demo_schema.nation n, glue.demo_schema.region r
    WHERE ((p.partkey = ps.partkey) AND (s.suppkey = ps.suppkey) AND (s.nationkey = n.nationkey) AND (n.regionkey = r.regionkey) AND (r.name = 'EUROPE'))
    )
))
ORDER BY ps.supplycost DESC, n.name ASC, s.name ASC, p.partkey ASC