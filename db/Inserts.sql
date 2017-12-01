/*UPDATE player
SET elo = 1000
WHERE id <= 250;

*/

INSERT INTO region(id, nm)
VALUES(1, "Tristate");

INSERT INTO tournament(id, nm, date, entrants_num, region_id)
VALUES(1, "The Break", sysdate(), 50, 1);

INSERT INTO tournament(id, nm, date, entrants_num, region_id)
VALUES(2, "Wii Bare Bears", sysdate(), 70, 1);

INSERT INTO tournament(id, nm, date, entrants_num, region_id)
VALUES(3, "Xeno", '2007-12-30', 90, 1);

INSERT INTO set_data(id, sk_id, tournament_id, player1, player2, round, tournament_nm, winner, description)
VALUES(1, 1, 1, 1, 2, "WFs", "The Break", 1, "Bodied");

INSERT INTO set_data(id, sk_id, tournament_id, player1, player2, round, tournament_nm, winner, description)
VALUES(2, 2, 1, 2, 3, "LFs", "The Break", 3, "PWNED");

INSERT INTO set_data(id, sk_id, tournament_id, player1, player2, round, tournament_nm, winner, description)
VALUES(3, 3, 1, 1, 3, "GF1", "The Break", 3, "Reset");

INSERT INTO set_data(id, sk_id, tournament_id, player1, player2, round, tournament_nm, winner, description)
VALUES(4, 4, 1, 1, 3, "GF2", "The Break", 1, "Stolen");

INSERT INTO set_data(id, sk_id, tournament_id, player1, player2, round, tournament_nm, winner, description)
VALUES(5, 5, 2, 1, 3, "GF", "Wii Bare Bairs", 1, "Robbed");

INSERT INTO set_data(id, sk_id, tournament_id, player1, player2, round, tournament_nm, winner, description)
VALUES(6, 6, 3, 3, 1, "GFs", "Xeno", 3, "Jank");

INSERT INTO set_data(id, sk_id, tournament_id, player1, player2, round, tournament_nm, winner, description)
VALUES(7, 7, 3, 2, 3, "LFs", "Xeno", 3, "Wow");

INSERT INTO set_data(id, sk_id, tournament_id, player1, player2, round, tournament_nm, winner, description)
VALUES(8, 8, 2, 1, 2, "LFs", "Wii Bare Bairs", 1, "lmao");

INSERT INTO set_data(id, sk_id, tournament_id, player1, player2, round, tournament_nm, winner, description)
VALUES(9, 9, 2, 2, 3, "LQFs", "Wii Bare Bairs", 2, "lol");

INSERT INTO set_data(id, sk_id, tournament_id, player1, player2, round, tournament_nm, winner, description)
VALUES(10, 10, 3, 3, 1, "WQFs", "Xeno", 3, "rofl"); 