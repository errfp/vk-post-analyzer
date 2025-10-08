/*
@author: Толкунов Александр
@task: Влияние промежутков между постами на количество лайков
*/
SELECT
	CASE
		WHEN interval_hours < 1 THEN 'less than 1 hour'
		WHEN interval_hours >= 1 AND interval_hours < 6 THEN '1-6 hours'
		WHEN interval_hours >= 6 AND interval_hours < 24 THEN '6-24 hours'
		WHEN interval_hours >= 24 AND interval_hours < 72 THEN '1-3 days'
		ELSE 'more than 3 days'
	END as posting_frequency,
	round(avg(likes), 2) as average_likes
FROM
	posts
WHERE
	interval_hours > 0
GROUP by
	posting_frequency
ORDER by
	average_likes DESC;