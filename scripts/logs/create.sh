#!/bin/bash

API="${API_ORIGIN:-http://localhost:4741}"
URL_PATH="/logs"
curl "${API}${URL_PATH}" \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=$TOKEN" \
  --data '{
    "log": {
      "date_completed": "'"${DATE}"'",
      "workout_id": "'"${WORKOUT_ID}"'",
      "athlete_id": "'"${ATHLETE_ID}"'"
    }
  }'


  #  \
  # --header "Authorization: Token token=$TOKEN"

echo
