SELECT
  c.custkey,
  c.name,
  sum(l.extendedprice * (1 - l.discount)) AS revenue,
  c.acctbal,
  n.name nation,
  c.address,
  c.phone,
  c.comment
FROM
  glue.benchmark_tpch.sf1_lineitem AS l,
  gcp_kafka.tpch.orders AS o,
  postgresql.benchmark_tpch.sf1_customer AS c,
  postgresql.benchmark_tpch.sf1_nation AS n
WHERE
  c.custkey = cast(json_extract(o._message, '$.customerKey') as bigint)
  AND l.orderkey = cast(json_extract(o._message, '$.orderKey') as bigint)
  AND json_value(o._message, 'lax $.orderDate' RETURNING date) >= DATE '1993-10-01'
  AND json_value(o._message, 'lax $.orderDate' RETURNING date) < DATE '1993-10-01' + INTERVAL '3' MONTH
  AND l.returnflag = 'R'
  AND c.nationkey = n.nationkey
GROUP BY
  c.custkey,
  c.name,
  c.acctbal,
  c.phone,
  n.name,
  c.address,
  c.comment
ORDER BY
  revenue DESC