create database election_2024;
use election_2024;
drop table eci_data_2024;
select * from eci_data_2024;
##List all candidates from a specific state
SELECT candidate, party, Constituency
FROM eci_data_2024
WHERE State = 'Maharashtra';

SELECT candidate, party, Constituency
FROM eci_data_2024
WHERE State = 'Andhra Pradesh';

SELECT candidate, party, Constituency
FROM eci_data_2024
WHERE State = 'Karnataka';

##Total votes by each party across all states
SELECT party, SUM(`Total Votes`) as total_votes
FROM eci_data_2024
GROUP BY party
ORDER BY total_votes DESC;

##Winning candidate in each constituency
SELECT 
    e.State, 
    e.Constituency, 
    e.candidate, 
    e.party, 
    e.`Total Votes` as total_votes
FROM 
    eci_data_2024 e
JOIN (
    SELECT 
        State, 
        Constituency, 
        MAX(`Total Votes`) as max_votes
    FROM 
        eci_data_2024
    GROUP BY 
        State, 
        Constituency
) as max_votes_table
ON 
    e.State = max_votes_table.State 
    AND e.Constituency = max_votes_table.Constituency 
    AND e.`Total Votes` = max_votes_table.max_votes;

##Total EVM and postal votes for each party
SELECT party, SUM(`EVM Votes`) as total_evm_votes, SUM(`Postal Votes`) as total_postal_votes
FROM eci_data_2024
GROUP BY party;

## State-wise vote distribution
SELECT State, SUM(`Total Votes`) as total_votes
FROM eci_data_2024
GROUP BY State
ORDER BY total_votes DESC;
##Number of constituencies won by each party
WITH WinningCandidates AS (
    SELECT State, Constituency, MAX(`Total Votes`) as max_votes
    FROM eci_data_2024
    GROUP BY State, Constituency
)
SELECT ec.party, COUNT(*) as constituencies_won
FROM eci_data_2024 ec
JOIN WinningCandidates wc
ON ec.State = wc.State AND ec.Constituency = wc.Constituency AND ec.`Total Votes` = wc.max_votes
GROUP BY ec.party
ORDER BY constituencies_won DESC;

##Total votes for a specific candidate across all constituencies
SELECT candidate, SUM(`Total Votes`) as total_votes
FROM eci_data_2024
WHERE candidate = 'Rahul Gandhi'
GROUP BY candidate;

##Constituencies with highest and lowest voter turnout
SELECT State, Constituency, `Total Votes`
FROM eci_data_2024
ORDER BY `Total Votes` DESC
LIMIT 1;

SELECT State, Constituency, `Total Votes`
FROM eci_data_2024
ORDER BY `Total Votes` ASC
LIMIT 1;
##Top 5 Candidates by Total Votes Nationwide
SELECT candidate, party, State, Constituency, `Total Votes`
FROM eci_data_2024
ORDER BY `Total Votes` DESC
LIMIT 5;

## Average Percentage of Votes by Party
SELECT party, AVG(CAST(REPLACE(`% of Votes`, '%', '') AS FLOAT)) as avg_percent_votes
FROM eci_data_2024
GROUP BY party
ORDER BY avg_percent_votes DESC;

## Top 3 Parties by Total Votes Nationwide
SELECT party, SUM(`Total Votes`) as total_votes
FROM eci_data_2024
GROUP BY party
ORDER BY total_votes DESC
LIMIT 3;

## Candidates Receiving More than 50% of Votes
SELECT candidate, party, State, Constituency, `% of Votes`
FROM eci_data_2024
WHERE CAST(REPLACE(`% of Votes`, '%', '') AS FLOAT) > 50
ORDER BY `% of Votes` DESC;


























