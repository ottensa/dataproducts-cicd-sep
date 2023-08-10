select 
    acc.custkey,
    acc.acctkey,
    acc.products,
    cust.first_name,
    cust.last_name,
    cust.street,
    cust.city,
    cust.state,
    cust.postcode,
    custp.career,
    custp.professional_status,
    custp.risk_appetite,
    custp.customer_segment
from "sqlserver"."burst_bank"."customer" cust
left join "glue"."burst_bank"."account" acc
    on acc.custkey = cust.custkey
left join "snowflake_distributed"."burst_bank"."customer_profile" custp
    on acc.custkey = custp.custkey