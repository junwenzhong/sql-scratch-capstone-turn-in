Select * from survey limit 2;
Select Count(*) from survey;
Select count(distinct user_id) from survey;

Select distinct question from survey;
Select question, count(user_id) as responses from survey group by question;

Select * from quiz limit 5;
Select * from home_try_on limit 5;
Select * from purchase limit 5;

SELECT Distinct q.user_id, 
	CASE
  	WHEN h.user_id IS NOT NULL
  		THEN 'TRUE' 
    	ELSE 'FALSE'
    END AS 'is_home_try_on',
  h.number_of_pairs,
	CASE
  	WHEN p.user_id IS NOT NULL
    THEN 'TRUE'
    ELSE 'FALSE'
    END AS 'is_purchase'
FROM quiz AS q
LEFT JOIN home_try_on AS h ON q.user_id = h.user_id
LEFT JOIN purchase AS p ON q.user_id = p.user_id 
LIMIT 10;

SELECT Distinct q.user_id, h.user_id IS NOT NULL
  	AS 'is_home_try_on', h.number_of_pairs, p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz AS q
LEFT JOIN home_try_on AS h ON q.user_id = h.user_id
LEFT JOIN purchase AS p ON q.user_id = p.user_id LIMIT 10;


WITH Funnel AS (
SELECT Distinct q.user_id, h.user_id IS NOT NULL
  	AS 'is_home_try_on', h.number_of_pairs, p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz AS q
LEFT JOIN home_try_on AS h ON q.user_id = h.user_id
LEFT JOIN purchase AS p ON q.user_id = p.user_id)

SELECT COUNT(*) as 'num_quiz', 
	SUM(is_home_try_on) as 'num_try_on', 
  SUM(is_purchase) as 'num_purchase',
  1.0*sum(is_home_try_on)/count(user_id) as 'quiz_to_tryon', 
  1.0*sum(is_purchase)/sum(is_home_try_on) as 'tryon_to_purchase' 
FROM Funnel;


WITH AB_Test AS (
  SELECT Distinct h.user_id,
    h.number_of_pairs, 
    CASE
      WHEN p.user_id IS NOT NULL
      THEN 'TRUE'
      ELSE 'FALSE'
      END AS 'is_purchase'
  FROM home_try_on AS h
  LEFT JOIN purchase AS p 
  ON h.user_id = p.user_id)
  
SELECT is_purchase, 
	COUNT(DISTINCT CASE WHEN number_of_pairs = '3 pairs' THEN user_id END) AS '3_pairs',
  	COUNT(DISTINCT CASE WHEN number_of_pairs = '5 pairs' THEN user_id END) AS '5_pairs'
FROM AB_Test 
Group by is_purchase;

Select * from quiz limit 10;
Select Style, count(user_id) from quiz group by 1 order by 2 desc;
Select fit, count(user_id) from quiz group by 1 order by 2 desc;
Select shape, count(user_id) from quiz group by 1 order by 2 desc;
Select color, count(user_id) from quiz group by 1 order by 2 desc;


Select Style, count(user_id) from purchase group by 1 order by 2 desc;
Select model_name, count(user_id) from purchase group by 1 order by 2 desc;
Select color, count(user_id) from purchase group by 1 order by 2 desc;
Select avg(price) from purchase;

