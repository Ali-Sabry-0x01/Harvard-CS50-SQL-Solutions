SELECT title, topic FROM episodes WHERE season = 1 AND air_date LIKE '2002-%' AND topic IS NOT NULL;
