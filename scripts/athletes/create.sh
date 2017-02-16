#!/bin/bash

API="${API_ORIGIN:-http://localhost:4741}"
URL_PATH="/athletes"
curl "${API}${URL_PATH}" \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --data '{
    "athlete": {
      "given_name": "'"${GIVEN_NAME}"'",
      "surname": "'"${SURNAME}"'",
      "date_of_birth": "'"${DOB}"'"
    }
  }'


  #  \
  # --header "Authorization: Token token=$TOKEN"

echo
