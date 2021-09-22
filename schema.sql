/* Database schema to keep the structure of entire database. */

DROP TABLE IF EXISTS animals;

CREATE TABLE animals (
    id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name char(50),
    date_of_birth date,
    escape_attempts int,
    neutered boolean,
    weight_kg decimal,
    species char(50)
);



-- Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that species columns went back to the state before tranasction.

BEGIN;
SELECT * FROM animals;
UPDATE animals SET species = 'unspecified';
SELECT name, species FROM animals;
ROLLBACK;

-- Inside a transaction:
    -- Update the animals table by setting the species column to digimon for all     animals that have a name ending in mon.
BEGIN;
UPDATE animals SET species ='digimon' WHERE name LIKE '%mon';

    -- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals SET species = 'pokemon' WHERE species = ' ';
    -- Commit the transaction.
COMMIT;

    -- Verify that change was made and persists after commit.
SELECT name,species FROM animals;

-- Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction.
BEGIN;
DELETE FROM animals;
SELECT * from animals;
ROLLBACK;

-- After the roll back verify if all records in the animals table still exist. After that you can start breath as usual ;)
SELECT * from animals;

--Inside a transaction:
BEGIN;
    -- Delete all animals born after Jan 1st, 2022.
DELETE FROM animals WHERE date_of_birth > '2020-01-01';
    -- Create a savepoint for the transaction.
SAVEPOINT sp1;
    -- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg*-1;
    -- Rollback to the savepoint
ROLLBACK TO sp1;
    -- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg*-1 WHERE weight_kg < 0;
    -- Commit transaction
COMMIT;
