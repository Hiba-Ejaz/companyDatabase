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

    CREATE TABLE public.team
(
    team_id serial,
    "team-name" character varying(15),
    PRIMARY KEY (team_id)
);

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