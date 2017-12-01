DELIMITER //

CREATE 
	TRIGGER `players_after_inserting_sets` AFTER INSERT 
	ON `set_data` 
	FOR EACH ROW BEGIN
    
    #Need to add if statements accounting for whether the players/head-to-heads exist or not
    
		DECLARE v_winner_id INTEGER;
        DECLARE v_loser_id INTEGER;
        DECLARE v_winner_elo INTEGER;
        DECLARE v_new_winner_elo INTEGER;
        DECLARE v_loser_elo INTEGER;
        DECLARE v_new_loser_elo INTEGER;
        DECLARE v_p_id INTEGER;
        DECLARE v_p2_id INTEGER;
        DECLARE v_h2h_1 INTEGER;
        DECLARE v_h2h_2 INTEGER;
		DECLARE v_old_wins INTEGER;
        DECLARE v_old_losses INTEGER;
        DECLARE v_winner_expected DOUBLE;
        DECLARE v_loser_expected DOUBLE;
        DECLARE v_date DATE;
        DECLARE v_new_decay INTEGER;
        
        SELECT winner
			INTO v_winner_id
		FROM set_data
		WHERE id IN (SELECT MAX(id)
						FROM set_data);
        
        SELECT player1
			INTO v_p_id
		FROM set_data
		WHERE id IN (SELECT MAX(id)
						FROM set_data);
        
        SELECT player2
			INTO v_p2_id
		FROM set_data
		WHERE id IN (SELECT MAX(id)
						FROM set_data);
        
        SELECT t.date
			INTO v_date
		FROM tournament t
			JOIN set_data s
				ON s.tournament_id = t.id
		WHERE s.id IN (SELECT MAX(id)
						FROM set_data);
        
        IF v_p_id = v_winner_id THEN
			SELECT p.wins, p.elo
				INTO v_old_wins, v_winner_elo
			FROM player p
				JOIN set_data s
					ON p.id = s.player1
		WHERE s.id IN (SELECT MAX(id)
						FROM set_data);
        ELSE
			SELECT p.losses, p.elo, p.id
				INTO v_old_losses, v_loser_elo, v_loser_id
			FROM player p
				JOIN set_data s
					ON p.id = s.player1
			WHERE s.id IN (SELECT MAX(id)
						FROM set_data);
		END IF;
        
        IF v_p2_id = v_winner_id THEN
			SELECT p2.wins, p2.elo
				INTO v_old_wins, v_winner_elo
			FROM player p2
				JOIN set_data s
					ON p2.id = s.player2
			WHERE s.id IN (SELECT MAX(id)
						FROM set_data);
        ELSE
			SELECT p2.losses, p2.elo, p2.id
				INTO v_old_losses, v_loser_elo, v_loser_id
			FROM player p2
				JOIN set_data s
					ON p2.id = s.player2
			WHERE s.id IN (SELECT MAX(id)
						FROM set_data);
		END IF;
        
        SET v_winner_expected = 1.0/(1.0 + POWER(10.0, (v_loser_elo - v_winner_elo)/400.0));
        SET v_loser_expected = 1.0/(1.0 + POWER(10.0, (v_winner_elo - v_loser_elo)/400.0));
        
        SET v_new_winner_elo = v_winner_elo + 32.0*(1.0 - v_winner_expected);
        SET v_new_loser_elo = v_loser_elo + 32.0*(0.0 - v_loser_expected);
        
        SET v_new_decay = TIMESTAMPDIFF(MONTH, v_date, SYSDATE());
    
		UPDATE player
		SET wins = wins+1, elo = v_new_winner_elo, last_match = v_date, decay_months = v_new_decay
        WHERE player.id = v_winner_id;
        
        UPDATE player
		SET losses = losses+1, elo = v_new_loser_elo, last_match = v_date, decay_months = v_new_decay
        WHERE player.id = v_loser_id;
        
        IF NOT EXISTS (SELECT id FROM head_to_head WHERE (p1_id = v_winner_id OR p2_id = v_winner_id) AND (p2_id = v_loser_id OR p1_id = v_loser_id)) THEN
        
        INSERT INTO head_to_head(p1_id, p2_id)
        VALUES (v_p_id, v_p2_id);
        
        END IF;
        
        SELECT p1_id
			INTO v_h2h_1
		FROM head_to_head
        WHERE (p1_id = v_p_id OR p1_id = v_p2_id) AND (p2_id = v_p_id OR p2_id = v_p2_id);
        
        SELECT p2_id
			INTO v_h2h_2
		FROM head_to_head
        WHERE (p1_id = v_p_id OR p1_id = v_p2_id) AND (p2_id = v_p_id OR p2_id = v_p2_id); 
        
        IF v_p_id = v_winner_id AND v_p_id = v_h2h_1 THEN 
        
        UPDATE head_to_head
        SET p1_wins = p1_wins+1
        WHERE p1_id = v_winner_id AND p2_id = v_loser_id;
        
        ELSEIF v_p_id = v_winner_id AND v_p_id = v_h2h_2 THEN
        
		UPDATE head_to_head
        SET p2_wins = p2_wins+1
        WHERE p1_id = v_loser_id AND p2_id = v_winner_id;
        
        ELSEIF v_p2_id = v_winner_id AND v_p2_id = v_h2h_1 THEN 
        
        UPDATE head_to_head
        SET p1_wins = p1_wins+1
        WHERE p1_id = v_winner_id AND p2_id = v_loser_id;
        
		ELSEIF v_p2_id = v_winner_id AND v_p2_id = v_h2h_2 THEN
        
		UPDATE head_to_head
        SET p2_wins = p2_wins+1
        WHERE p1_id = v_loser_id AND p2_id = v_winner_id;
        
		END IF;
        
    END; //
    
    DELIMITER ;
    
    /*Notes

TRIGGER:
- wins, losses, elo, sigma, mu, and last_match of both players need automatically be updated whenever a set is added, but that goes without saying.
- elo should be instantiated to 1000 on creation of a new player so that calculations can be performed
- decay_months of the involved players can be regularly updated using the last_match column and subtracting the current sysdate by their last match and returning the month of that subtraction.
- wins in head-to-head table need simply be incremented by 1 for the winner of each set using the player_id's to locate their head-to-head tuple/entry/whatever you address a row of a table as.
	*Make sure order of the IDs in a row does NOT matter (a key of 1,2 should be the same as 2,1 for head to head purposes)
    *^^^This can easily be solved using the OR keyword as well as AND in the WHERE clause
 

	DELIMITER //
    
    #it MATTERS what tables the C# code inserts into, ask David
    
CREATE 
	TRIGGER `players_after_inserting_tournaments` AFTER INSERT 
	ON `tournament`
	FOR EACH ROW BEGIN
        
        DECLARE v_tournament_id INTEGER;
        
        SELECT id
			INTO v_tournament_id
		FROM tournament
		WHERE id IN (SELECT MAX(id)
						FROM tournament);
        
        UPDATE player
        SET attended_num = attended_num+1
        WHERE player.id IN (SELECT *
								FROM set_data
								WHERE tournament_id = v_tournament_id);
    
    END;
    
    DELIMITER ;

	DROP TRIGGER `players_after_inserting_tournaments`;
    
    */
    