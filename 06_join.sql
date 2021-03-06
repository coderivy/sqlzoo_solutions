--1. show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'
SELECT matchid, player
FROM goal 
WHERE teamid = 'GER'

/* 2. Notice in the that the column matchid in the goal table corresponds to the id column in the game table. We can look up information about game 1012 by finding that row in the game table.
Show id, stadium, team1, team2 for just game 1012 */
SELECT id,stadium,team1,team2
 FROM game
WHERE id = 1012

/*
3. The FROM clause says to merge data from the goal table with that from the game table. The ON says how to figure out which rows in game go with which rows in goal - the matchid from goal must match id from game. (If we wanted to be more clear/specific we could say 
ON (game.id=goal.matchid)
The code below shows the player (from the goal) and stadium name (from the game table) for every goal scored.
Modify it to show the player, teamid, stadium and mdate for every German goal.
*/
SELECT player, teamid, stadium, mdate
  FROM game 
JOIN goal ON (id=matchid)
WHERE teamid = 'GER'

/*
4. use the same JOIN as in the previous question.
Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
*/
SELECT  team1, team2, player
FROM game
JOIN goal ON (id=matchid)
WHERE player LIKE 'Mario%'

/*
5. The table eteam gives details of every national team including the coach. You can JOIN goal to eteam using the phrase goal JOIN eteam on teamid=id
Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
*/
SELECT player, teamid,coach, gtime
  FROM goal 
JOIN eteam on teamid=id
 WHERE gtime<=10

 /*
 6. To JOIN game with eteam you could use either
game JOIN eteam ON (team1=eteam.id) or game JOIN eteam ON (team2=eteam.id)
Notice that because id is a column name in both game and eteam you must specify eteam.id instead of just id
List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
 */
 SELECT mdate, teamname
FROM game 
JOIN eteam ON (team1=eteam.id)
WHERE coach = 'Fernando Santos' 

/*
7. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
*/
SELECT player
FROM goal
JOIN game ON matchId = id
WHERE stadium = 'National Stadium, Warsaw'

/*
8. Select goals scored only by non-German players in matches where GER was the id of either team1 or team2.
You can use teamid!='GER' to prevent listing German players.
You can use DISTINCT to stop players being listed twice.
*/
SELECT DISTINCT player
  FROM game 
JOIN goal ON matchid = id 
WHERE (team1 = 'GER' OR team2 = 'GER')
AND teamid <> 'GER'

/*
9.Show teamname and the total number of goals scored.
COUNT and GROUP BY
You should COUNT(*) in the SELECT line and GROUP BY teamname
*/
SELECT teamname, COUNT(matchId)
  FROM eteam JOIN goal ON id=teamid
GROUP BY teamname

/*
10. Show the stadium and the number of goals scored in each stadium.
*/
SELECT stadium, COUNT(matchId)
FROM game
JOIN goal ON id = matchid
GROUP BY stadium

/*
11. For every match involving 'POL', show the matchid, date and the number of goals scored.
*/
SELECT matchid,mdate, team1, team2,teamid
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL')

 /*
 12. For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
 */
SELECT matchId, mdate, COUNT(matchID)
FROM goal 
JOIN game ON matchId = id
WHERE teamId = 'GER'
GROUP BY matchId, mdate

/*
13. List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.
Notice in the query given every goal is listed. If it was a team1 goal then a 1 appears in score1, otherwise there is a 0. You could SUM this column to get a count of the goals scored by team1. Sort your result by mdate, matchid, team1 and team2.
*/
SELECT mdate, 
team1, SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END)  t1_score, 
team2, SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) t2_score
FROM game LEFT JOIN goal on id=matchid
GROUP BY mdate, matchid, team1, team2
ORDER BY mdate, matchid, team1, team2