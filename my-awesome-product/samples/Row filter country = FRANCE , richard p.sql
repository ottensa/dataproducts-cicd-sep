select nation,sum(revenue) from 
data_products.federation_sample_product.returned_item_reporting_query
group by 1