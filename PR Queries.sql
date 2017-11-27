/*List of Players by Most set wins*/

SELECT primary_nm, attended_num, wins AS Set_Wins, losses AS Set_Losses, elo, team AS Team, characters as Characters, mu, sigma, DATE_FORMAT(last_match, '%Y-%m-%d') AS Last_Match, decay_months AS Decay_Months
FROM player
Order By wins desc;

/*List of Players by Most set wins (top 10)*/

SELECT primary_nm, attended_num, wins AS Set_Wins, losses AS Set_Losses, elo, team AS Team, characters as Characters, mu, sigma, DATE_FORMAT(last_match, '%Y-%m-%d') AS Last_Match, decay_months AS Decay_Months
FROM player
Order By wins desc
LIMIT 10;

/*List of Players by Least set Losses*/

SELECT primary_nm, attended_num, wins AS Set_Wins, losses AS Set_Losses, elo, team AS Team, characters as Characters, mu, sigma, DATE_FORMAT(last_match, '%Y-%m-%d') AS Last_Match, decay_months AS Decay_Months
FROM player
Order By losses;

/*List of Players by Least set Losses (top 10)*/

SELECT primary_nm, attended_num, wins AS Set_Wins, losses AS Set_Losses, elo, team AS Team, characters as Characters, mu, sigma, DATE_FORMAT(last_match, '%Y-%m-%d') AS Last_Match, decay_months AS Decay_Months
FROM player
Order By losses
LIMIT 10;

/*List of Players by W/L Ratio, avoids divide by 0*/

SELECT primary_nm, attended_num, wins AS Set_Wins, losses AS Set_Losses, elo, team AS Team, characters as Characters, mu, sigma, DATE_FORMAT(last_match, '%Y-%m-%d') AS Last_Match, decay_months AS Decay_Months
FROM player
Where losses > 0
Order By wins/losses desc;

/*List of Players by W/L Ratio, avoids divide by 0 (top 10)*/

SELECT primary_nm, attended_num, wins AS Set_Wins, losses AS Set_Losses, elo, team AS Team, characters as Characters, mu, sigma, DATE_FORMAT(last_match, '%Y-%m-%d') AS Last_Match, decay_months AS Decay_Months
FROM player
Where losses > 0
Order By wins/losses desc
LIMIT 10;

/*A nice display of tournament data, can be further specified by any of the columns (for example specified tournament names can give all sets for that tounament, specfied rounds 
can give you data like who won grand finals, and specified players can give you ever set a player played at any tournament)*/

SELECT s.tournament_nm AS Tournament, s.round AS Round, p.primary_nm AS Player_1, p2.primary_nm AS Player_2, p3.primary_nm AS Winner
FROM set_data s
JOIN player p
	ON p.id = s.player1
JOIN player p2
	ON p2.id = s.player2
JOIN player p3
	ON p3.id = s.winner;
    
/* List of tournaments + the tournament winner, WHERE clause to be changed based on the input data of the parser */

SELECT t.nm as Tournament_Name, date_format(t.date, '%Y-%m-%d') as Date, t.entrants_num as Number_of_Entrants, p.primary_nm AS Winner
FROM TOURNAMENT t
JOIN set_data s
	ON s.tournament_id = t.id
JOIN player p
	ON s.winner = p.id
WHERE s.round = "GF2" OR s.round = "GFs" OR s.round = "GF";


/*Notes

TRIGGER:
- wins, losses, elo, sigma, mu, and last_match of both players need automatically be updated whenever a set is added, but that goes without saying.
- elo should be instantiated to 1000 on creation of a new player so that calculations can be performed
- decay_months of the involved players can be regularly updated using the last_match column and subtracting the current sysdate by their last match and returning the month of that subtraction.
- wins in head-to-head table need simply be incremented by 1 for the winner of each set using the player_id's to locate their head-to-head tuple/entry/whatever you address a row of a table as.
	*Make sure order of the IDs in a row does NOT matter (a key of 1,2 should be the same as 2,1 for head to head purposes)
    *^^^This can easily be solved using the OR keyword as well as AND in the WHERE clause
*/ 

SELECT *
FROM player;

SELECT *
FROM region;

SELECT *
FROM set_data;

SELECT *
FROM tournament;

SELECT winner
	FROM set_data
	WHERE id IN (SELECT MAX(id)
					FROM set_data);

