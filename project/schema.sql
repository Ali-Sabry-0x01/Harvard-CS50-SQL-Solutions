-- Represents players in the football team
CREATE TABLE players (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    jersey_number INTEGER NOT NULL,
    position TEXT NOT NULL CHECK (position IN ('Goalkeeper', 'Defender', 'Midfielder', 'Forward'))
);

-- Represents the tournaments the team participates in
CREATE TABLE tournaments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    season TEXT NOT NULL
);

-- Represents individual matches played by the team
CREATE TABLE matches (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tournament_id INTEGER NOT NULL,
    opponent TEXT NOT NULL,
    match_date DATE NOT NULL,
    team_goals INTEGER DEFAULT 0,
    opponent_goals INTEGER DEFAULT 0,
    result TEXT NOT NULL CHECK (result IN ('Win', 'Draw', 'Loss')),
    FOREIGN KEY (tournament_id) REFERENCES tournaments(id)
);

-- Represents specific events during a match (Goals, Cards, Assists)
CREATE TABLE match_events (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    match_id INTEGER NOT NULL,
    player_id INTEGER NOT NULL,
    event_type TEXT NOT NULL CHECK (event_type IN ('Goal', 'Assist', 'Yellow Card', 'Red Card')),
    minute INTEGER NOT NULL CHECK (minute <= 120),
    FOREIGN KEY (match_id) REFERENCES matches(id),
    FOREIGN KEY (player_id) REFERENCES players(id)
);

-- Create an index to speed up finding matches by their date
CREATE INDEX idx_match_date ON matches(match_date);

-- Create a view to easily find the top goalscorers
CREATE VIEW top_scorers AS
SELECT players.first_name, players.last_name, COUNT(match_events.id) AS total_goals
FROM players
JOIN match_events ON players.id = match_events.player_id
WHERE match_events.event_type = 'Goal'
GROUP BY players.id
ORDER BY total_goals DESC;
