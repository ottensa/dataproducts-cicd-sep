SELECT
  c.custkey
, c.state
, c.estimated_income
, cp.customer_segment
, cp.risk_appetite
, a.cc_number
, pp.cc_type
FROM
  (((sqlserver.burst_bank.customer c
INNER JOIN mysql.burst_bank.customer_profile cp ON (c.custkey = cp.custkey))
INNER JOIN glue.burst_bank.account a ON (c.custkey = a.custkey))
INNER JOIN glue.burst_bank.product_profile pp ON (a.custkey = pp.custkey))
WHERE ((c.country = 'US') AND (NOT (c.state IN ('AA', 'AE', 'AP'))))