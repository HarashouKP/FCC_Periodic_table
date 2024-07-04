#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
INPUT=$1

if [[ -z $INPUT ]] ; then
  echo -e "Please provide an element as an argument."
else
#if INPUT NOT A NUMBER
  if [[ ! $INPUT =~ ^[0-9]+$ ]] ;then


    if [[ ${#INPUT} -lt 3 ]] ; then
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$INPUT'")
    NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$SYMBOL'")
    ATOMICNUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$NAME' ")
    else
    #if string more than 2 characters
    NAME=$($PSQL "SELECT name FROM elements WHERE name = '$INPUT'")
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name = '$NAME'")
    ATOMICNUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$SYMBOL'")
    fi


  else
  #if INPUT is a Number
    ATOMICNUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$INPUT")
    NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $ATOMICNUMBER")
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ATOMICNUMBER")
  fi
      
  
  #Query
    TYPEID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMICNUMBER")
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPEID ")
    MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = '$ATOMICNUMBER'")
    MELTINGPOINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = '$ATOMICNUMBER'")
    BOILINGPOINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = '$ATOMICNUMBER'")

    #if not find
    if [[ -z $BOILINGPOINT ]]; then
    echo -e "I could not find that element in the database."
    else
    echo -e "The element with atomic number $ATOMICNUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTINGPOINT celsius and a boiling point of $BOILINGPOINT celsius."
    fi

fi

