SELECT DISTINCT teams.name FROM teams JOIN performances
ON teams.id = performances.team_id
JOIN players ON players.id = performances.player_id
WHERE players.first_name LIKE 'Satchel' AND players.last_name LIKE 'paige';

