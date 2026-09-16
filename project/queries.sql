-- Add a new player to the team
INSERT INTO players (first_name, last_name, jersey_number, position)
VALUES ('Emam', 'Ashour', 22, 'Midfielder');

-- Add a new tournament
INSERT INTO tournaments (name, season)
VALUES ('Egyptian Premier League', '2023/2024');

-- Record a new match result
INSERT INTO matches (tournament_id, opponent, match_date, team_goals, opponent_goals, result)
VALUES (1, 'Zamalek', '2024-04-15', 2, 1, 'Win');

-- Log a goal event for a specific player in a match
INSERT INTO match_events (match_id, player_id, event_type, minute)
VALUES (1, 1, 'Goal', 82);

-- Find all matches played in a specific tournament
SELECT opponent, match_date, result
FROM matches
WHERE tournament_id = (SELECT id FROM tournaments WHERE name = 'Egyptian Premier League');

-- View the top scorers using the created View
SELECT * FROM top_scorers LIMIT 5;

-- Update a player's jersey number
UPDATE players SET jersey_number = 10 WHERE first_name = 'Emam' AND last_name = 'Ashour';

-- Delete a match event if added by mistake
DELETE FROM match_events WHERE id = 1;
