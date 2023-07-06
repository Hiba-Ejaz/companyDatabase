-- Database: companyDatabase

-- DROP DATABASE IF EXISTS "companyDatabase";

CREATE DATABASE "companyDatabase"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- Table: public.team

-- DROP TABLE IF EXISTS public.team;

CREATE TABLE IF NOT EXISTS public.team
(
    team_id integer NOT NULL DEFAULT nextval('team_team_id_seq'::regclass),
    "team-name" character varying(15) COLLATE pg_catalog."default",
    location character varying(20) COLLATE pg_catalog."default",
    CONSTRAINT team_pkey PRIMARY KEY (team_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.team
    OWNER to postgres;

CREATE TABLE public.project
(
    project_id serial,
    name character varying(15),
    client character varying,
    start_date date,
    deadline date,
    PRIMARY KEY (project_id)
);

CREATE TABLE IF NOT EXISTS public.team_project
(
    team_id integer NOT NULL,
    project_id integer NOT NULL,
    CONSTRAINT team_project_pkey PRIMARY KEY (team_id, project_id),
    CONSTRAINT project_id FOREIGN KEY (project_id)
        REFERENCES public.project (project_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT team_id FOREIGN KEY (team_id)
        REFERENCES public.team (team_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)

-- Table: public.employee

-- DROP TABLE IF EXISTS public.employee;

CREATE TABLE IF NOT EXISTS public.employee
(
    employee_id integer NOT NULL DEFAULT nextval('employee_employee_id_seq'::regclass),
    first_name character varying(15) COLLATE pg_catalog."default" NOT NULL,
    last_name character varying(15) COLLATE pg_catalog."default" NOT NULL,
    hire_date date NOT NULL,
    hourly_salary numeric(10,2) NOT NULL,
    title_id integer,
    manager_id integer,
    team_id integer,
    CONSTRAINT employee_pkey PRIMARY KEY (employee_id),
    CONSTRAINT manager_id FOREIGN KEY (manager_id)
        REFERENCES public.employee (employee_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT team_id FOREIGN KEY (team_id)
        REFERENCES public.team (team_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT title_id FOREIGN KEY (title_id)
        REFERENCES public.title (title_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)
-- Constraint: manager_id

-- ALTER TABLE IF EXISTS public.employee DROP CONSTRAINT IF EXISTS manager_id;

ALTER TABLE IF EXISTS public.employee
    ADD CONSTRAINT manager_id FOREIGN KEY (manager_id)
    REFERENCES public.employee (employee_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;
CREATE INDEX IF NOT EXISTS fki_manager_id
    ON public.employee(manager_id);

-- Table: public.hour_tracking

-- DROP TABLE IF EXISTS public.hour_tracking;

CREATE TABLE IF NOT EXISTS public.hour_tracking
(
    employee_id integer NOT NULL,
    project_id integer,
    total_hours integer,
    CONSTRAINT hour_tracking_pkey PRIMARY KEY (employee_id),
    CONSTRAINT employee_id FOREIGN KEY (employee_id)
        REFERENCES public.employee (employee_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT project_id FOREIGN KEY (project_id)
        REFERENCES public.project (project_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT total_hours CHECK (total_hours > 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.hour_tracking
    OWNER to postgres;


-- i had to use this command everytime before adding record when i give serial data type , it starts randomly sometimes like from 15 
 ALTER SEQUENCE project_project_id_seq RESTART WITH 1;

