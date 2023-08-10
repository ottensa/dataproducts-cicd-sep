SELECT * FROM data_products.burst_bank_customer.customer_data
WHERE
  customer_segment = 'diamond'
  AND estimated_income > 200000
  AND cc_type = 'basic'