CREATE SCHEMA ecommerce;

Use ecommerce;

----- Q3. Run SQL command to see the structure of table ------

DESC users_data;
SELECT * FROM users_data;
SELECT COUNT(*) FROM users_data;

----- Q4. Run SQL command to select first 100 rows of the database ------

SELECT * FROM users_data LIMIT 100;

----- Q5. How many distinct values exist in table for field country and language ------
SELECT DISTINCT country FROM users_data;
SELECT DISTINCT language FROM users_data;
SELECT count(distinct country) CountDistinctCountry,
count(DISTINCT language ) CountDistinctLanguage FROM users_data ;

-----  Q6. Check whether male users are having maximum followers or female users ------

SELECT COUNT(*) FROM users_data GROUP BY gender = "F" UNION SELECT COUNT(*) FROM users_data GROUP BY gender = "M";

-- Female Users has the more number of followers than male with the count of 1217 for female and 325 for male. --

----- Q7. Calculate the total users those
----- a) Uses Profile Picture in their Profile

SELECT COUNT(*) FROM users_data WHERE hasProfilePicture = "True";

----- b) Uses Application for Ecommerce platform

SELECT COUNT(*) FROM users_data WHERE hasAnyApp = "True";

----- c) Uses Android app

SELECT COUNT(*) FROM users_data WHERE hasAndroidApp = "True";

----- d)Uses ios app ------

SELECT COUNT(*) FROM users_data WHERE hasIosApp = "True";

----- Q8. Calculate the total number of buyers for each country and sort the result in descending order of total number of buyers. (Hint: consider only those users having at least 1 product bought.) -----

SELECT country, COUNT(productsBought) FROM users_data WHERE productsBought >= 1 ORDER BY COUNT(productsBought) DESC; 

----- Q9. Calculate the total number of sellers for each country and sort the result in ascending order of total number of sellers. (Hint: consider only those users having at least 1 product sold.) -----

SELECT country, COUNT(productsSold) FROM users_data WHERE productsSold >= 1 ORDER BY COUNT(productsSold) DESC; 

----- Q10. Display name of top 10 countries having maximum products pass rate. -----

SELECT Country, MAX(productsPassRate) FROM users_data GROUP BY country ORDER BY MAX(productsPassRate) DESC Limit 10; 

----- Q11. Calculate the number of users on an ecommerce platform for different language choices. ------

SELECT language, COUNT(*) FROM users_data GROUP BY language;

----- Q12. Check the choice of female users about putting the product in a wishlist or to like socially on an ecommerce platform. (Hint: use UNION to answer this question.) ------

SELECT COUNT(productsWished) FROM users_data WHERE gender = "F" AND socialProductsLiked>0 AND productsWished=0;

----- Q13. Check the choice of male users about being seller or buyer. (Hint: use UNION to solve this question.) ------

SELECT productsSold FROM users_data WHERE gender = "M" UNION SELECT productsBought FROM users_data WHERE gender = "M";

----- Q14. Which country is having maximum number of buyers? ------

SELECT Max(productsBought) MAX_Buyers, country FROM users_data;

----- Q15. List the name of 10 countries having zero number of sellers. ------

SELECT country FROM users_data WHERE productsSold = 0 LIMIT 10;

----- Q16. Display record of top 110 users who have used ecommerce platform recently. ------

SELECT * FROM users_data ORDER BY daysSinceLastLogin LIMIT 110 ;

----- Q17. Calculate the number of female users those who have not logged in since last 100 days. ------

SELECT COUNT(*) FROM users_data WHERE gender = "F" AND daysSinceLastLogin < 100; 

----- Q18. Display the number of female users of each country at ecommerce platform. ------

SELECT country, COUNT(gender = "F") Female FROM users_data GROUP BY country;

----- Q19. Display the number of male users of each country at ecommerce platform. ------

SELECT country, COUNT(gender = "M") Male FROM users_data GROUP BY country;

----- Q20. Calculate the average number of products sold and bought on ecommerce platform by male users for each country. ------

SELECT AVG(productsSold), AVG(productsBought), gender = "M", country FROM users_data GROUP BY country ;

