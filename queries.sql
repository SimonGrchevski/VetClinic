/*Queries that provide answers to the questions from all projects.*/

                  -- Milestone 1
-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon';
-- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered AND escape_attempts < 3;
-- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name IN('Agumon','Pikachu');
-- List name and escape attempts of animals that weigh more than 10.5kg.
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered;
-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE name != 'Gabumon';
-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT* FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


                  -- Milestone 2
-- How many animals are there?
SELECT count(*) FROM animals;
-- How many animals have never tried to escape?
SELECT count(*) FROM animals WHERE escape_attempts = 0 GROUP BY escape_attempts;
-- Check the names and escape_attempts if the query was correct( extra )
SELECT name, escape_attempts FROM animals WHERE escape_attempts= 0 GROUP BY name,escape_attempts;
-- What is the average weight of animals?
SELECT AVG(weight_kg) AS "Average Weight" from animals;
-- Who escapes the most, neutered or not neutered animals?
select neutered, avg(escape_attempts) as "Avarage Escape Attempts" from animals group by neutered;
-- What is the minimum and maximum weight of each type of animal?
SELECT min(weight_kg), max(weight_kg) from animals;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT avg(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31';