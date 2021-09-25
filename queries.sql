/*Queries that provide answers to the questions from all projects.*/

                  -- Milestone 1
-- Find all animals whose name ends in "mon".
SELECT * 
FROM animals 
WHERE name LIKE '%mon';
-- List the name of all animals born between 2016 and 2019.
SELECT name 
FROM animals 
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name 
FROM animals 
WHERE neutered AND escape_attempts < 3;
-- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth 
FROM animals 
WHERE name IN('Agumon','Pikachu');
-- List name and escape attempts of animals that weigh more than 10.5kg.
SELECT name, escape_attempts 
FROM animals 
WHERE weight_kg > 10.5;
-- Find all animals that are neutered.
SELECT * 
FROM animals 
WHERE neutered;
-- Find all animals not named Gabumon.
SELECT * 
FROM animals 
WHERE name != 'Gabumon';
-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT* 
FROM animals 
WHERE weight_kg 
  BETWEEN 10.4 AND 17.3;


                  -- Milestone 2
-- How many animals are there?
SELECT COUNT(*) 
FROM animals;
-- How many animals have never tried to escape?
SELECT COUNT(*) 
FROM animals 
WHERE escape_attempts = 0 GROUP BY escape_attempts;
-- Check the names and escape_attempts if the query was correct( extra )
SELECT name, escape_attempts 
FROM animals 
WHERE escape_attempts= 0 
GROUP BY name,escape_attempts;
-- What is the average weight of animals?
SELECT AVG(weight_kg) AS "Average Weight" 
FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, AVG(escape_attempts) AS "Average Escape Attempts" 
FROM animals 
GROUP BY neutered;
-- What is the minimum and maximum weight of each type of animal?
SELECT MIN(weight_kg), MAX(weight_kg) 
FROM animals;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) 
FROM animals
WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31'
GROUP BY species;

                  -- Milestone 3
-- What animals belong to Melody Pond?
SELECT name 
FROM animals 
JOIN owners ON animals.owner_id = owners.id 
WHERE full_name = 'Melody Pond';
-- List of all animals that are pokemon (their type is Pokemon)
SELECT animals.name, species.name as animal_breed 
FROM animals 
JOIN species ON  animals.species_id = species.id where species.id = 1;
-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name,animals.name as animal_name 
FROM owners 
LEFT JOIN animals ON  owners.id = animals.owner_id;
-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name 
FROM owners 
JOIN animals ON owners.id = animals.owner_id 
WHERE owners.full_name = 'Jennifer Orwell' AND animals.name='Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name 
FROM owners 
JOIN animals ON owners.id = animals.owner_id 
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts=0;

-- Who owns the most animals?
SELECT owners.full_name,count(animals.name) as animals_count
FROM owners
JOIN animals ON owners.id = animals.owner_id 
GROUP BY owners.full_name
ORDER BY animals_count DESC
LIMIT 1;

                  -- Milestone 4
-- Who was the last animal seen by William Tatcher?
SELECT animals.name,vets.name,date_of_visit 
FROM visits 
JOIN animals ON (animals_id = animals.id)
JOIN vets ON (vet_id=vets.id)
WHERE vets.name = 'William Tatcher'
ORDER BY date_of_visit DESC
LIMIT 1;
-- How many different animals did Stephanie Mendez see?
SELECT vets.name,count(animals) as different_animals
FROM visits
JOIN animals ON (animals_id = animals.id)
JOIN vets ON (vet_id = vets.id)
WHERE vets.name = 'Stephanie Mendez'
GROUP BY vets.name;
-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name,species.name as speciality
FROM specializations
JOIN species on (species_id = species.id)
right JOIN vets on ( vet_id = vets.id );
-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name,date_of_visit
FROM visits
JOIN animals ON (animals_id = animals.id)
JOIN vets ON (vet_id = vets.id)
WHERE vets.name = 'Stephanie Mendez' AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';
-- What animal has the most visits to vets?
SELECT animals.name, count(vets.name) as visits
FROM visits
JOIN animals ON (animals_id = animals.id)
JOIN vets ON (vet_id = vets.id)
GROUP BY animals.name
ORDER BY visits DESC
LIMIT 1;
-- Who was Maisy Smith's first visit?
SELECT animals.name, date_of_visit
FROM visits
JOIN animals ON (animals_id = animals.id)
JOIN vets ON (vet_id = vets.id)
WHERE vets.name ='Maisy Smith'
ORDER BY date_of_visit ASC
LIMIT 1;
-- Details for most recent visit: animal information, vet information, and date of visit. 
SELECT vets.name as vet_name, 
        vets.age as vet_age,
        animals.name as ani_name,
        animals.date_of_birth as ani_birth,
        animals.escape_attempts as ani_escape_attemps,
        date_of_visit as visit
FROM visits
JOIN animals ON (animals_id = animals.id)
JOIN vets ON (vet_id = vets.id)
ORDER BY date_of_visit DESC
LIMIT 5;
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
