#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -X -t --no-align -c"

echo "Enter your username:"
IFS= read -r USERNAME || exit 0

USERNAME_SQL=${USERNAME//\'/\'\'}
USER_DATA=$($PSQL "SELECT user_id, games_played, best_game FROM users WHERE username = '$USERNAME_SQL';")

if [[ -z "$USER_DATA" ]]
then
  USER_ID=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME_SQL') RETURNING user_id;" | head -n 1)
  printf 'Welcome, %s! It looks like this is your first time here.\n' "$USERNAME"
else
  IFS='|' read -r USER_ID GAMES_PLAYED BEST_GAME <<< "$USER_DATA"
  printf 'Welcome back, %s! You have played %s games, and your best game took %s guesses.\n' "$USERNAME" "$GAMES_PLAYED" "${BEST_GAME:-0}"
fi

SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))
NUMBER_OF_GUESSES=0

echo "Guess the secret number between 1 and 1000:"

while IFS= read -r GUESS
do
  NUMBER_OF_GUESSES=$(( NUMBER_OF_GUESSES + 1 ))

  if [[ ! "$GUESS" =~ ^[+-]?[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
    continue
  fi

  if [[ "$GUESS" == -* ]]
  then
    echo "It's higher than that, guess again:"
    continue
  fi

  VALUE=${GUESS#+}
  while [[ ${#VALUE} -gt 1 && "$VALUE" == 0* ]]
  do
    VALUE=${VALUE#0}
  done

  if [[ ${#VALUE} -gt 4 ]]
  then
    echo "It's lower than that, guess again:"
    continue
  fi

  VALUE=$(( 10#$VALUE ))

  if (( VALUE > SECRET_NUMBER ))
  then
    echo "It's lower than that, guess again:"
  elif (( VALUE < SECRET_NUMBER ))
  then
    echo "It's higher than that, guess again:"
  else
    $PSQL "UPDATE users
      SET games_played = games_played + 1,
          best_game = CASE
            WHEN best_game IS NULL OR $NUMBER_OF_GUESSES < best_game
            THEN $NUMBER_OF_GUESSES
            ELSE best_game
          END
      WHERE user_id = $USER_ID;" > /dev/null

    printf 'You guessed it in %s tries. The secret number was %s. Nice job!\n' "$NUMBER_OF_GUESSES" "$SECRET_NUMBER"
    break
  fi
done
