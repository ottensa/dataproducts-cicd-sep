SELECT c.first_name, c.last_name, c.estimated_income,
       a.products, a.cc_number, a.mortgage_id, 
       cp.customer_segment
FROM   sqlserver.burst_bank.customer c
JOIN   oracle.burst_bank.account a on c.custkey = a.custkey
JOIN   mongodb.burst_bank_large.customer_profile cp on c.custkey = cp.custkey