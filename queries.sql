-- Customer Journey SQL Queries

-- 1. Get all customer journey records for home page ordered by user ID
select * from customer_journey
where pagetype = "home"
order by userid ;

-- 2. Get all customer journey records for product page
select * from customer_journey
where pagetype = "product_page" ;

-- 3. Get all customer journey records for cart page
select * from customer_journey
where pagetype = "cart";

-- 4. Get all customer journey records for checkout page
select * from customer_journey
where pagetype = "checkout";

-- 5. Get all customer journey records for confirmation page
select * from customer_journey
where pagetype = "confirmation";

-- 6. To find users who drop off on the product page 
select distinct c_1.userid from (select * from customer_journey
where pagetype = "product_page")  as c_1
left join (select * from customer_journey
where pagetype = "cart")as c_2
on c_1.userid = c_2.userid and c_1.sessionid = c_2.sessionid
where c_2.userid is null  ;

-- 7. To find users who continue to cart page 
select * from (select * from customer_journey
where pagetype = "product_page")  as c_1
left join (select * from customer_journey
where pagetype = "cart")as c_2
on c_1.userid = c_2.userid and c_1.sessionid = c_2.sessionid
where c_2.userid is not null 
order by c_1.userid;

-- 8. To find users who drop off on the home page 
select avg(c_3.timeonpage_seconds) from(select * from customer_journey
where pagetype = "home") as c_3
left join (select * from customer_journey
where pagetype = "product_page") as c_4
on c_3.userid = c_4.userid and c_3.sessionid = c_4.sessionid
where c_4.userid is null;

-- 9. To find users who continue from home to product page
-- Note: Set c_4.userid is not null to find users who continue. The query below checks for null (drop off).
select avg(c_3.timeonpage_seconds) from(select * from customer_journey
where pagetype = "home") as c_3
left join (select * from customer_journey
where pagetype = "product_page") as c_4
on c_3.userid = c_4.userid and c_3.sessionid = c_4.sessionid
where c_4.userid is null;
