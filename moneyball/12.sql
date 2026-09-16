SELECT first_name, last_name
FROM players
WHERE id IN (
    SELECT players.id
    FROM players
    JOIN salaries ON players.id = salaries.player_id
    JOIN performances ON players.id = performances.player_id AND salaries.year = performances.year
    WHERE salaries.year = 2001 AND performances.H > 0
    ORDER BY (salaries.salary / performances.H) ASC, players.first_name ASC, players.last_name ASC
    LIMIT 10
)
AND id IN (
    SELECT players.id
    FROM players
    JOIN salaries ON players.id = salaries.player_id
    JOIN performances ON players.id = performances.player_id AND salaries.year = performances.year
    WHERE salaries.year = 2001 AND performances.RBI > 0
    ORDER BY (salaries.salary / performances.RBI) ASC, players.first_name ASC, players.last_name ASC
    LIMIT 10
)
ORDER BY id ASC;
