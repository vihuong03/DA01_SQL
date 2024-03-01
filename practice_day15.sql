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
