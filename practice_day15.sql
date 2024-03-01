--- bai 1
select extract(year from transaction_date) as year, product_id,
spend as curr_yeaar_spend,
lag(spend) over(partition by product_id) as prev_year_spend,
round(100.0*(spend-lag(spend) over(partition by product_id))/lag(spend) over(partition by product_id),2) as yoy_rate
FROM user_transactions;
--- bai 2
SELECT distinct card_name,
first_value(issued_amount) over (partition by card_name order by issue_year,issue_month) as issued_amount
FROM monthly_cards_issued
order by issued_amount DESC
---bai 3
with cte1 as 
(
select *, 
rank() over(partition by user_id order by transaction_date desc) as ranking
from transactions
),
cte2 as(
SELECT user_id, count(transaction_date) as num
from transactions
group by user_id)
select a.user_id, a.spend, a.transaction_date
from cte1 as a
join cte2 as b on a.user_id=b.user_id
where b.num >=3 and a.ranking =1
--- bai 4
with cte as
(select transaction_date, user_id, product_id,
rank () over(partition by user_id order by transaction_date desc) as rankk
from user_transactions)
select transaction_date, user_id,
count(product_id)
from cte
where rankk=1
group by transaction_date, user_id
order by transaction_date 
---bai 5
em chua lam dc a
---bai 6
with cte as
(SELECT 
    transaction_id,
    merchant_id,
    credit_card_id,
    amount,
    transaction_timestamp,
    LAG(transaction_timestamp) OVER (PARTITION BY merchant_id, credit_card_id, amount ORDER BY transaction_timestamp) AS prv_transactiontime,
    EXTRACT(HOUR FROM (transaction_timestamp - LAG(transaction_timestamp) OVER (PARTITION BY merchant_id, credit_card_id, amount ORDER BY transaction_timestamp))) * 60 +
    EXTRACT(MINUTE FROM (transaction_timestamp - LAG(transaction_timestamp) OVER (PARTITION BY merchant_id, credit_card_id, amount ORDER BY transaction_timestamp))) AS time_between_transaction
FROM 
    transactions)
select count(merchant_id) as payment_count
from cte
where time_between_transaction<=10
--- bai 7
with ranking_cte as(
SELECT category,product,
sum(spend) as total_spending,
rank() over( 
partition by category 
order by sum(spend) desc) as rank
from product_spend
where extract(year from transaction_date)=2022
group by category,product)
select category, product, total_spending
from ranking_cte
where rank<3
--- bai 8
with cte as
(SELECT a.artist_name,
dense_rank() over (order by count(b.song_id) desc) as artist_ranking
FROM artists as a
join songs as b on a.artist_id=b.artist_id
join global_song_rank as c on c.song_id=b.song_id
where c.rank<=10
group by a.artist_name)
select artist_name, artist_ranking
from cte 
where artist_ranking<=5
order by artist_ranking, artist_name asc

