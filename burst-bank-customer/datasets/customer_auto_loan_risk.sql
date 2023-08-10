SELECT c.first_name, c.last_name, c.fico,
	   a.auto_loan_id, a.auto_loan_open_date,
	   count(al.delinquent_payment) as num_delinquent_payments
FROM   sqlserver.burst_bank.customer c
JOIN   mysql.burst_bank.account a on c.custkey = a.custkey
JOIN   glue.burst_bank.auto_loan_payment al on al.auto_loan_id = a.auto_loan_id
WHERE  al.delinquent_payment = 'Y'and c.fico < 500
GROUP BY a.auto_loan_id, c.first_name, c.last_name, a.auto_loan_open_date, c.fico
HAVING count(al.delinquent_payment) > 3