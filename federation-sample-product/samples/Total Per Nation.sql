select nation,sum(revenue) from 
data_products.federation_sample_product.returned_shipments
group by 1
