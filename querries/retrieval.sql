--Retrieve the team names and their corresponding project count.
SELECT team.team_name, COUNT(team_project.project_id) AS project_count
FROM team, team_project where team.team_id = team_project.team_id GROUP BY team.team_name;
