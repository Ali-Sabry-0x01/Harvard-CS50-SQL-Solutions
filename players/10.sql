SELECT first_name, last_name, birth_year AS "Year of Birth"
FROM players
WHERE birth_year >= 2000
ORDER BY birth_year DESC;
