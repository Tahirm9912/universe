psql --username=freecodecamp --dbname=postgres
CREATE DATABASE universe;
\c universe

CREATE TABLE galaxy (galaxy_id SERIAL PRIMARY KEY, name VARCHAR(50) UNIQUE NOT NULL, galaxy_types TEXT NOT NULL, distance_from_earth NUMERIC, has_life BOOLEAN NOT NULL, age_in_millions_of_years INT NOT NULL);

CREATE TABLE star (star_id SERIAL PRIMARY KEY, name VARCHAR(50) UNIQUE NOT NULL, galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id), temperature INT NOT NULL, is_spherical BOOLEAN NOT NULL, mass NUMERIC);

CREATE TABLE planet (planet_id SERIAL PRIMARY KEY, name VARCHAR(50) UNIQUE NOT NULL, star_id INT NOT NULL REFERENCES star(star_id), planet_types TEXT NOT NULL, has_life BOOLEAN NOT NULL, distance_from_star NUMERIC);

CREATE TABLE moon (moon_id SERIAL PRIMARY KEY, name VARCHAR(50) UNIQUE NOT NULL, planet_id INT NOT NULL REFERENCES planet(planet_id), radius INT NOT NULL, is_spherical BOOLEAN NOT NULL, description TEXT);

CREATE TABLE galaxy_types (galaxy_types_id SERIAL PRIMARY KEY, name VARCHAR(50) UNIQUE NOT NULL, description TEXT NOT NULL);

INSERT INTO galaxy (name, galaxy_types, distance_from_earth, has_life, age_in_millions_of_years) VALUES ('Milky Way','Spiral',0,TRUE,13600),('Andromeda','Spiral',2537000,FALSE,10000),('Triangulum','Spiral',2730000,FALSE,12000),('Whirlpool','Spiral',23000000,FALSE,9000),('Sombrero','Spiral',29350000,FALSE,13000),('Large Magellanic Cloud','Irregular',163000,FALSE,11000);

INSERT INTO star (name, galaxy_id, temperature, is_spherical, mass) VALUES ('Sun',1,5778,TRUE,1),('Sirius',2,9940,TRUE,2.063),('Proxima Centauri',3,3042,TRUE,0.122),('Betelgeuse',4,3500,TRUE,16.5),('Vega',5,9602,TRUE,2.1),('Rigel',6,11000,TRUE,21);

INSERT INTO planet (name, star_id, planet_types, has_life, distance_from_star) VALUES ('Mercury',1,'Terrestrial',FALSE,0.39),('Venus',1,'Terrestrial',FALSE,0.72),('Earth',1,'Terrestrial',TRUE,1),('Mars',1,'Terrestrial',FALSE,1.52),('Jupiter',1,'Gas Giant',FALSE,5.2),('Saturn',1,'Gas Giant',FALSE,9.58),('Uranus',1,'Ice Giant',FALSE,19.2),('Neptune',1,'Ice Giant',FALSE,30.05),('Proxima b',3,'Terrestrial',FALSE,0.05),('Planet X',2,'Unknown',FALSE,10),('Planet Y',4,'Gas Giant',FALSE,20),('Planet Z',5,'Terrestrial',FALSE,2);

INSERT INTO moon (name, planet_id, radius, is_spherical, description) VALUES ('Moon',3,1737,TRUE,'Earth natural satellite'),('Phobos',4,11,FALSE,'Inner moon of Mars'),('Deimos',4,6,FALSE,'Outer moon of Mars'),('Io',5,1821,TRUE,'Volcanically active moon'),('Europa',5,1560,TRUE,'Icy moon'),('Ganymede',5,2634,TRUE,'Largest moon in the Solar System'),('Callisto',5,2410,TRUE,'Heavily cratered moon'),('Titan',6,2575,TRUE,'Moon with a thick atmosphere'),('Rhea',6,764,TRUE,'Moon of Saturn'),('Enceladus',6,252,TRUE,'Icy moon'),('Mimas',6,198,TRUE,'Small moon of Saturn'),('Iapetus',6,735,TRUE,'Two-toned moon'),('Dione',6,561,TRUE,'Moon of Saturn'),('Tethys',6,531,TRUE,'Moon of Saturn'),('Titania',7,789,TRUE,'Moon of Uranus'),('Oberon',7,761,TRUE,'Moon of Uranus'),('Ariel',7,579,TRUE,'Moon of Uranus'),('Umbriel',7,585,TRUE,'Moon of Uranus'),('Triton',8,1353,TRUE,'Moon of Neptune'),('Proteus',8,210,FALSE,'Moon of Neptune');

INSERT INTO galaxy_types (name, description) VALUES ('Spiral','A galaxy with spiral arms'),('Elliptical','An oval-shaped galaxy'),('Irregular','A galaxy without a regular shape');

\dt

SELECT 'galaxy' AS table_name, COUNT(*) FROM galaxy
UNION ALL SELECT 'star', COUNT(*) FROM star
UNION ALL SELECT 'planet', COUNT(*) FROM planet
UNION ALL SELECT 'moon', COUNT(*) FROM moon
UNION ALL SELECT 'galaxy_types', COUNT(*) FROM galaxy_types;
