SELECT c.first_name, c.last_name, c.estimated_income, 
       a.products, a.cc_number, a.mortgage_id, 
       cp.customer_segment
FROM glue.burst_bank.customer c
INNER JOIN snowflake_jdbc.burst_bank.account a ON c.custkey = a.custkey
INNER JOIN oracle.burst_bank_large.customer_profile cp ON c.custkey = cp.custkey
WHERE c.state <> 'OK'
AND a.mortgage_id IS NOT NULL