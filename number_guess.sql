-- Fresh database schema for the Number Guessing Game.
-- Restore with: psql -U postgres < number_guess.sql
-- This creates an empty database; it does not contain existing player data.

\connect postgres

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8';
ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

CREATE TABLE public.users (
  user_id SERIAL PRIMARY KEY,
  username VARCHAR(22) UNIQUE NOT NULL,
  games_played INTEGER NOT NULL DEFAULT 0,
  best_game INTEGER
);

ALTER TABLE public.users OWNER TO freecodecamp;
ALTER SEQUENCE public.users_user_id_seq OWNER TO freecodecamp;
