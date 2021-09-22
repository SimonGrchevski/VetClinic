/* Database schema to keep the structure of entire database. */

DROP TABLE IF EXISTS animals;

CREATE TABLE animals (
    id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name char(50),
    date_of_birth date,
    escape_attempts int,
    neutered boolean,
    weight_kg decimal,
);

ALTER TABLE animals
ADD species char(50);