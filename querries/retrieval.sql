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
--"Retrieve all the employees (both directly and indirectly) working under Andrew Martin"
Select e.first_name from employee e join employee m on m.employee_id=e.manager_id WHERE m.first_name = 'Andrew' AND m.last_name = 'Martin';
--Retrieve all the employees (both directly and indirectly) working under Robert Brown
Select e.first_name from employee e join employee m on m.employee_id=e.manager_id WHERE m.first_name = 'Robert' AND m.last_name = 'Brown';
-- Retrieve the average hourly salary for each title.
Select  avg(hourly_salary),t.name from employee e join title t on e.title_id=t.title_id group by t.name order by avg(e.hourly_salary);