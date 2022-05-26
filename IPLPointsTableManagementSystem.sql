CREATE TABLE Team_Name(
	TeamID int NOT NULL,
	TeamName varchar(255) NOT NULL,
	TotalMatches int NOT NULL,
	Points int NOT NULL,
	
	PRIMARY KEY(TeamID)
);
INSERT INTO Team_Name (TeamID, TeamName,TotalMatches,Points)
VALUES (1,'GT',14,20),
	 (2,'RR',14,18),
	 (3,'LSG',14,18),
	 (4,'RCB',14,16),
	 (5,'DC',14,14),
	 (6,'PBKS',14,14),
	 (7,'KKR',14,12),
	 (8,'SRH',14,12),
	 (9,'CSK',14,8),
	 (10,'MI',14,8);
SELECT * FROM Team_Name 




CREATE TABLE Team_Matches(
	TeamID int NOT NULL,
	MatchID int NOT NULL,
	IsWin int NOT NULL
);
INSERT INTO Team_Matches (TeamID,MatchID,IsWin)
VALUES (1,1,0),(1,2,1),(1,3,1),(1,4,0),(1,5,0),
		(2,1,1),(2,2,1),(2,3,0),(2,4,1),(2,5,0),
		(3,1,1),(3,2,0),(3,3,0),(3,4,1),(3,5,1),
		(4,1,1),(4,2,0),(4,3,1),(4,4,1),(4,5,0),
		(5,1,0),(5,2,1),(5,3,1),(5,4,0),(5,5,1),
		(6,1,1),(6,2,0),(6,3,1),(6,4,0),(6,5,1),
		(7,1,0),(7,2,1),(7,3,1),(7,4,0),(7,5,1),
		(8,1,0),(8,2,1),(8,3,0),(8,4,0),(8,5,0),
		(9,1,0),(9,2,0),(9,3,0),(9,4,1),(9,5,0),
		(10,1,1),(10,2,0),(10,3,1),(10,4,0),(10,5,1);
SELECT * FROM Team_Matches




CREATE TABLE #AvgDetailss (TeamID int,Average VARCHAR(25)) 
insert into #AvgDetailss
 select TeamID, CAST(Points AS FLOAT)/TotalMatches AS Average from Team_Name

 select * from #AvgDetailss
UPDATE c
SET c.Average = a.Average
   FROM Team_Name c inner join  #AvgDetailss a on c.TeamID = a.TeamID 




declare @ConsecutiveNumber INT=2, @IsWin BIT=0

 ;with Result1 as  
 (
	SELECT  DISTINCT tn.TeamName,Table1.TeamId ,IsWin,   COUNT(Table1.TEAMID) OVER (PARTITION BY Table1.TEAMID,A-B,ISWIN) AS C_Result,tn.Average FROM 
	(
		SELECT TeamId,MatchID,IsWin,ROW_NUMBER() OVER (PARTITION BY TeamID ORDER BY MatchID) AS A, 
		ROW_NUMBER() OVER (PARTITION BY TeamID,ISWIN ORDER BY MatchID) AS B
		FROM Team_Matches 
	) AS Table1  inner join Team_Name TN on Table1.TeamID=TN.TeamID

)
SELECT * FROM Result1 WHERE C_Result>=@ConsecutiveNumber AND IsWin=@IsWin 


