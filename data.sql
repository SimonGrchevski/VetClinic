/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, weight_kg,neutered, escape_attempts) VALUES
('Agumon','2020-02-03',10.23,true,0),
('Gabumon','2018-11-15',8.0,true,2),
('Pikachu','2021-01-07',15.04,false,1),
('Devimon','2017-06-12',11.0,true,5),
('Charmander','2020-02-08',-11.0,false,0),
('Plantmon','2022-11-15',-5.7,true,2),
('Squirtle','1993-04-02',-12.13,false,3),
('Angemon','2005-06-12',-45.0,true,1),
('Boarmon','2005-06-07',20.4,true,7),
('Blossom','1998-10-13',17.0,true,3);

INSERT INTO owners(full_name, age) 
VALUES 
('Sam Smith',34),
('Jennifer Orwell',19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

INSERT INTO species(name)
VALUES ('Pokemon'),('Digimon');

UPDATE animals
SET owner_id = 1
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = 2
WHERE name = 'Gabumon' OR name = 'Pikachu';

UPDATE animals
SET owner_id = 4
WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';

UPDATE animals
SET owner_id = 5
WHERE name = 'Angemon' OR name = 'Boarmon';

UPDATE animals
SET species_id = 2
WHERE name like '%mon';

UPDATE animals
SET species_id = 1 
WHERE species_id IS NULL;