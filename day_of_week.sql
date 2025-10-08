/*
@author: Толкунов Александр
@task: Влияние дня недели публикации на количество лайков
*/
SELECT
	CASE strftime('%w', date)
		WHEN '0' THEN 'mon'
		WHEN '1' THEN 'tue'
		WHEN '2' THEN 'wen'
		WHEN '3' THEN 'thu'
		WHEN '4' THEN 'fri'
		WHEN '5' THEN 'sat'
		WHEN '6' THEN 'sun'
	END as day_of_week,
	round(avg(likes), 2) as average_likes
FROM
	posts
GROUP by 
	day_of_week
ORDER by 
	average_likes DESC;