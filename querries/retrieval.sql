--Retrieve the team names and their corresponding project count.
SELECT team.team_name, COUNT(team_project.project_id) AS project_count
FROM team, team_project where team.team_id = team_project.team_id GROUP BY team.team_name;
--Retrieve the projects managed by the managers whose first name starts with "J" or "D".
SELECT DISTINCT project.name AS project_name
FROM project
JOIN team_project ON project.project_id = team_project.project_id
JOIN employee e ON e.team_id = team_project.team_id
JOIN employee manager ON manager.manager_id = e.employee_id
WHERE manager.first_name LIKE 'J%' OR manager.first_name LIKE 'D%';
