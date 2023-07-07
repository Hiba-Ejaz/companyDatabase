-- Create a function track_working_hours(employee_id, project_id, total_hours) 
-- to insert data into the hour_tracking table to track the working hours for each employee on specific projects. Make sure that data need to be 
-- validated before the insertion. Test this function
CREATE OR REPLACE FUNCTION track_working_hours(EMPLOYEE_ID INTEGER
, PROJECT_ID INTEGER, TOTAL_HOURS DECIMAL)
RETURNS VOID AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM employee WHERE employee.employee_id = track_working_hours.EMPLOYEE_ID) THEN
        RAISE EXCEPTION 'Invalid employee_id';
		END IF;
	 IF NOT EXISTS (SELECT 1 FROM project WHERE project.project_id  =track_working_hours.PROJECT_ID
	) then raise exception 'Invalid project_id';
    END IF;
        INSERT INTO hour_tracking (employee_id, project_id,total_hours) VALUES (EMPLOYEE_ID, PROJECT_ID,TOTAL_HOURS);  
END;
$$ LANGUAGE plpgsql;
SELECT track_working_hours(20, 7, 40.5);
SELECT track_working_hours(23, 7, 32.25);
SELECT track_working_hours(12, 7, 22.75);


-- Create a function create_project_with_teams to create a project
-- and assign teams to that project simultaneously. Test this function
CREATE FUNCTION CREATE_PROJECT_WITH_TEAMS(PROJECT_NAME 
VARCHAR, CLIENT VARCHAR, START_DATE DATE, DEADLINE 
DATE, TEAM INTEGER[]) RETURNS VOID AS 
	$$ DECLARE project_id integer;
	team_id integer;
	BEGIN
	insert into
	    projects (
	        name,
	        client,
	        start_date,
	        deadline
	    )
	values (
	        PROJECT_NAME,
	        CLIENT,
	        START_DATE,
	        DEADLINE
	    ) RETURNING project_id into project_id;
	FOREACH team_id in ARRAY teams
	loop
	insert into
	    team_project (team_id, project_id)
	values (team_id, project_id);
	end loop;
END; 

$$ LANGUAGE plpgsql;

SELECT create_project_with_teams(
    'New Project',
    'Client XYZ',
    '2023-07-01',
    '2023-12-31',
    ARRAY[1, 2, 3]
);