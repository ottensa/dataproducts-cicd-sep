SELECT c.custkey, c.first_name, c.last_name, c.estimated_income,
       a.products, a.cc_number, a.mortgage_id, 
       cp.customer_segment,
       pp.cc_type
FROM   hive.burst_bank.customer c
JOIN   sqlserver.burst_bank.account a on c.custkey = a.custkey
JOIN   oracle.burst_bank.product_profile pp on a.custkey = pp.custkey
JOIN   sqlserver.burst_bank.customer_profile cp on c.custkey = cp.custkey