SELECT c.custkey, c.first_name, c.last_name, c.country, c.estimated_income, --S3
       a.products, a.cc_number, a.mortgage_id, --Snowflake
       cp.customer_segment, --SQLServer
       pp.cc_type --SQLServer
FROM   glue.burst_bank.customer c
JOIN   snowflake_distributed.burst_bank.account a on c.custkey = a.custkey
JOIN   sqlserver.burst_bank_large.product_profile pp on a.custkey = pp.custkey
JOIN   sqlserver.burst_bank.customer_profile cp on c.custkey = cp.custkey