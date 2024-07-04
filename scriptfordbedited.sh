#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

RENAMECOL1=$($PSQL "ALTER TABLE properties RENAME COLUMN weight to atomic_mass")
RETYPECOL1=$($PSQL "ALTER TABLE properties ALTER COLUMN atomic_mass TYPE numeric(9,6) ,ALTER COLUMN atomic_mass set NOT NULL")
ADDFKTOAT1=$($PSQL "ALTER TABLE properties ADD FOREIGN KEY (atomic_number) REFERENCES elements(atomic_number)")
RENAMECOL2=$($PSQL "ALTER TABLE properties RENAME COLUMN melting_point to melting_point_celsius")
RETYPECOL2=$($PSQL "ALTER TABLE properties ALTER COLUMN melting_point_celsius TYPE numeric ,ALTER COLUMN melting_point_celsius set NOT NULL")

RENAMECOL3=$($PSQL "ALTER TABLE properties RENAME COLUMN boiling_point to boiling_point_celsius")
RETYPECOL3=$($PSQL "ALTER TABLE properties ALTER COLUMN boiling_point_celsius TYPE numeric ,ALTER COLUMN boiling_point_celsius set NOT NULL")

RESYMBOLCOL=$($PSQL "ALTER TABLE elements ALTER COLUMN symbol TYPE varchar(2) ,ALTER COLUMN symbol set NOT NULL ,ADD CONSTRAINT UQ_symbol UNIQUE(symbol)")
RENAMECOL=$($PSQL "ALTER TABLE elements ALTER COLUMN name TYPE varchar(40) ,ALTER COLUMN name set NOT NULL ,ADD CONSTRAINT UQ_name UNIQUE(name)")
CREATETABLE1=$($PSQL "CREATE TABLE types (type_id SERIAL PRIMARY KEY NOT NULL ,type VARCHAR NOT NULL)")
INSERTTABLE1=$($PSQL "INSERT INTO types(type) SELECT DISTINCT type FROM properties")

#ALTER TABLE properties ADD COLUMN type_id INT NULL
$($PSQL "ALTER TABLE properties ADD COLUMN type_id INT NULL")

#UPDATE properties SET type_id=1 WHERE type='metal'
$($PSQL "UPDATE properties SET type_id=1 WHERE type='metal'")

#UPDATE properties SET type_id=2 WHERE type='metalloid'
$($PSQL "UPDATE properties SET type_id=2 WHERE type='metalloid'")

#UPDATE properties SET type_id=3 WHERE type='nonmetal'
$($PSQL "UPDATE properties SET type_id=3 WHERE type='nonmetal'")

#ALTER TABLE properties ADD CONSTRAINT FK_properties_types FOREIGN KEY (type_id) REFERENCES types(type_id)
$($PSQL "ALTER TABLE properties ADD CONSTRAINT FK_properties_types FOREIGN KEY (type_id) REFERENCES types(type_id)")

#ALTER TABLE properties ALTER COLUMN type_id TYPE INT ,ALTER COLUMN type_id set NOT NULL
$($PSQL "ALTER TABLE properties ALTER COLUMN type_id TYPE INT ,ALTER COLUMN type_id set NOT NULL")

#UPDATE elements SET symbol='H' WHERE symbol='h'
$($PSQL "UPDATE elements SET symbol='H' WHERE symbol='h'")

#UPDATE elements SET symbol='He' WHERE symbol='he'
$($PSQL "UPDATE elements SET symbol='He' WHERE symbol='he'")

#UPDATE elements SET symbol='Li' WHERE symbol='li' 
$($PSQL "UPDATE elements SET symbol='Li' WHERE symbol='li'")

#UPDATE elements SET symbol='Be' WHERE symbol='be'
$($PSQL "UPDATE elements SET symbol='Be' WHERE symbol='be'")

#UPDATE elements SET symbol='Mt' WHERE symbol='mT'
$($PSQL "UPDATE elements SET symbol='Mt' WHERE symbol='mT'")

#ALTER TABLE properties ALTER COLUMN atomic_mass TYPE DECIMAL
$($PSQL "ALTER TABLE properties ALTER COLUMN atomic_mass TYPE DECIMAL")

#UPDATE properties SET atomic_mass = atomic_mass::REAL
$($PSQL "UPDATE properties SET atomic_mass = atomic_mass::REAL")

#You should add the element with atomic number 9 to your database. Its name is Fluorine, symbol is F, mass is 18.998, melting point is -220, boiling point is -188.1, and it's a nonmetal
$($PSQL "INSERT INTO elements (atomic_number,symbol,name) VALUES (9,'F','Fluorine')")
$($PSQL "INSERT INTO properties (atomic_number,type,atomic_mass,melting_point_celsius,boiling_point_celsius,type_id) VALUES (9,'nonmetal',18.998,-220,-188.1,3)")

#You should add the element with atomic number 10 to your database. Its name is Neon, symbol is Ne, mass is 20.18, melting point is -248.6, boiling point is -246.1, and it's a nonmetal
$($PSQL "INSERT INTO elements (atomic_number,symbol,name) VALUES (10,'Ne','Neon')")
$($PSQL "INSERT INTO properties (atomic_number,type,atomic_mass,melting_point_celsius,boiling_point_celsius,type_id) VALUES (10,'nonmetal',20.18,-248.6,-246.1,3)")

#You should delete the non existent element, whose atomic_number is 1000, from the two tables
$($PSQL "DELETE FROM properties WHERE atomic_number=1000")
$($PSQL "DELETE FROM elements WHERE atomic_number=1000")

#Your properties table should not have a type column

$($PSQL "ALTER TABLE properties DROP COLUMN type")






 








