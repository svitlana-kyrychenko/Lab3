PRODUCT_ID='01'
CUSTOMER_ID='01'
RATING=5
N = 2

SELECT review_id, review_headline, review_body, review_date, star_rating FROM review_product WHERE product_id = PRODUCT_ID;
SELECT review_id, review_headline, review_body, review_date, star_rating FROM review_by_product WHERE product_id = PRODUCT_ID AND star_rating = RATING;
SELECT review_id, review_headline, review_body, review_date, star_rating FROM review_customer WHERE customer_id = CUSTOMER_ID;
SELECT customer_id FROM review_customer_product WHERE product_id = PRODUCT_ID AND number_rated = N;
SELECT COUNT(*) AS number_of_positive_rating FROM review_customer_rating WHERE customer_id = CUSTOMER_ID AND star_rating IN (4, 5);
