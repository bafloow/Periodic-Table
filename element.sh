PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"


ELE1=$($PSQL "SELECT * FROM elements WHERE atomic_number='$1'")
ELE2=$($PSQL "SELECT * FROM elements WHERE name='$1'")
ELE3=$($PSQL "SELECT * FROM elements WHERE symbol='$1'")

if [ "$#" -ne 1 ]; then
echo "Please provide an element as an argument."
fi

if [[ -z $ELE1 && -z $ELE2 && -z $ELE3 && -n $1 ]]
then 
echo "I could not find that element in the database."
fi

if [[ -z $ELE1 && -z $ELE2 && -n $ELE3 ]]
then
JOIN1=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) where symbol='$1'")
echo "$JOIN1" | while IFS="|" read   TYPE_ID ATOMIC_NUMBER SYMBOL NAME MELTING BOILING MASS TYPE
do
echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
done
fi

if [[ -z $ELE1 && -n $ELE2 && -z $ELE3 ]]
then
JOIN2=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) where name='$1'")
echo "$JOIN2" | while IFS="|" read   TYPE_ID ATOMIC_NUMBER SYMBOL NAME MELTING BOILING MASS TYPE
do
echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
done
fi

if [[ -n $ELE1 && -z $ELE2 && -z $ELE3 ]]
then
JOIN3=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) where atomic_number='$1'")
echo "$JOIN3" | while IFS="|" read   TYPE_ID ATOMIC_NUMBER SYMBOL NAME MELTING BOILING MASS TYPE
do
echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
done
fi
