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
-- Retrieve the employees who have a higher hourly salary than their respective team's average hourly salary.
SELECT e.first_name, e.hourly_salary , AVG_OF_TEAM_SALARY AS INDV_SALARY
FROM employee e
JOIN (
    SELECT t.team_id, AVG(e.hourly_salary) AS AVG_OF_TEAM_SALARY
    FROM employee e
    JOIN team t ON e.team_id = t.team_id
    GROUP BY t.team_id
) AS team_avg ON e.team_id = team_avg.team_id
WHERE e.hourly_salary > team_avg.AVG_OF_TEAM_SALARY;
--Retrieve the projects that have more than 3 teams assigned to them.
select p.name,p.project_id from project p 
join team_project tp on p.project_id=tp.project_id 
group by p.name,p.project_id
HAVING count(tp.team_id) > 3;
--Retrieve the total hourly salary expense for each team.
select t.team_id,sum(e.hourly_salary) from employee e
join team t on t.team_id=e.team_id
group by t.team_id;




