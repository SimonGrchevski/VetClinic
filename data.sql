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
VALUES ('Sam Smith',34);

INSERT INTO owners(full_name, age) 
VALUES ('Jennifer Orwell',19);

INSERT INTO owners(full_name, age) 
VALUES ('Bob', 45);

INSERT INTO owners(full_name, age) 
VALUES ('Melody Pond', 77);

INSERT INTO owners(full_name, age) 
VALUES ('Dean Winchester', 14);

INSERT INTO owners(full_name, age) 
VALUES ('Jodie Whittaker', 38);

INSERT INTO species(name)
VALUES ('Pokemon');

INSERT INTO species(name)
VALUES ('Digimon');

INSERT INTO vets(name,age,date_of_graduation)
VALUES ('William Tatcher',45,'2000-04-23');

INSERT INTO vets(name,age,date_of_graduation)
VALUES ('Maisy Smith',26,'2019-01-17');

INSERT INTO vets(name,age,date_of_graduation)
VALUES ('Stephanie Mendez',64,'1981-05-04');

INSERT INTO vets(name,age,date_of_graduation)
VALUES ('Jack Harkness',38,'2008-06-08');


INSERT INTO specializations
VALUES((SELECT id FROM vets WHERE name='William Tatcher'), 
       (SELECT id FROM species WHERE name='Pokemon')); 

INSERT INTO specializations
VALUES((SELECT id FROM vets WHERE name='Stephanie Mendez'), 
       (SELECT id FROM species WHERE name='Digimon')); 

INSERT INTO specializations
VALUES((SELECT id FROM vets WHERE name='Stephanie Mendez'), 
       (SELECT id FROM species WHERE name='Pokemon')); 

INSERT INTO specializations
VALUES((SELECT id FROM vets WHERE name='Jack Harkness'), 
       (SELECT id FROM species WHERE name='Digimon')); 

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name ='Sam Smith')
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name ='Jennifer Orwell')
WHERE name = 'Gabumon' OR name = 'Pikachu';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name ='Bob')
WHERE name = 'Devimon' OR name = 'Plantmon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name ='Melody Pond')
WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name ='Dean Winchester')
WHERE name = 'Angemon' OR name = 'Boarmon';

UPDATE animals
SET species_id = (SELECT id from species WHERE name = 'Digimon')
WHERE name like '%mon';

UPDATE animals
SET species_id = (SELECT id from species WHERE name = 'Pokemon') 
WHERE species_id IS NULL;

