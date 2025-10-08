/*
@author: Толкунов Александр
@task: Влияние времени суток публикации на количество лайков
*/
SELECT
    CASE
        WHEN CAST(strftime('%H', date) AS INTEGER) BETWEEN 5 AND 11 THEN 'morning (05:00-11:59)'
        WHEN CAST(strftime('%H', date) AS INTEGER) BETWEEN 12 AND 17 THEN 'day (12:00-17:59)'
        WHEN CAST(strftime('%H', date) AS INTEGER) BETWEEN 18 AND 23 THEN 'evening (18:00-23:59)'
        ELSE 'night (00:00-04:59)'
    END as time_of_day,
    round(avg(likes), 2) as average_likes
FROM
    posts
GROUP by
    time_of_day
ORDER by
    average_likes DESC;