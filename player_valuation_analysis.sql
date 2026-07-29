-- 1. Club Squad Scoring Depth
SELECT 
    club,
    COUNT(player_id) AS total_players,
    SUM(CASE WHEN goals > 0 THEN 1 ELSE 0 END) AS players_who_scored,
    (CAST(SUM(CASE WHEN goals > 0 THEN 1 ELSE 0 END) AS FLOAT) 
        / NULLIF(COUNT(player_id), 0)) * 100 AS percent_scorers
FROM FootballPlayerStats
GROUP BY club
ORDER BY percent_scorers DESC;


-- 2. Player-Appearance Scoring Rate by Nationality
SELECT 
    nationality,
    COUNT(player_id) AS total_players,
    SUM(goals) AS total_goals,
    SUM(matches_played) AS total_matches,
    CAST(SUM(goals) AS FLOAT) / NULLIF(SUM(matches_played), 0) AS goals_per_match
FROM FootballPlayerStats
GROUP BY nationality
ORDER BY goals_per_match DESC;


-- 3. Total Match Appearances by Nation
SELECT 
    nationality,
    SUM(matches_played) AS total_games_by_nation
FROM FootballPlayerStats
GROUP BY nationality
ORDER BY total_games_by_nation DESC;


-- 4. Roster Injury Crisis Level by Nationality
SELECT 
    nationality,
    COUNT(player_id) AS total_players,
    SUM(CASE WHEN injury_prone = 'YES' THEN 1 ELSE 0 END) AS injury_prone_players, 
    (CAST(SUM(CASE WHEN injury_prone = 'YES' THEN 1 ELSE 0 END) AS FLOAT) 
        / NULLIF(COUNT(player_id), 0)) * 100 AS injury_prone_percentages
FROM FootballPlayerStats
GROUP BY nationality
ORDER BY injury_prone_percentages DESC;


-- 5. Systemic Transfer Risk by Club
SELECT 
    club,
    COUNT(player_id) AS total_players,   
    SUM(CASE WHEN transfer_risk_level = 'High' THEN 1 ELSE 0 END) AS high_risk_transfer_players,
    (CAST(SUM(CASE WHEN transfer_risk_level = 'High' THEN 1 ELSE 0 END) AS FLOAT) 
        / NULLIF(COUNT(player_id), 0)) * 100 AS high_risk_transfer_percentage
FROM FootballPlayerStats
GROUP BY club
ORDER BY high_risk_transfer_percentage DESC;
