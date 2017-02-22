# A Workout data store API

An API to store workout data and allow athletes to register as users and record their workout history.
[Front-End Repo](https://github.com/laurpaik/WorkIt)

## API End-Points

| Verb   | URI Pattern            | Controller#Action |
|--------|------------------------|-------------------|
| POST   | `/sign-up`             | `users#signup`    |
| POST   | `/sign-in`             | `users#signin`    |
| PATCH  | `/change-password/:id` | `users#changepw`  |
| DELETE | `/sign-out/:id`        | `users#signout`   |
| PATCH  | `/athletes/:id` | `athletes#update`  |
| POST  | `/logs` | `logs#create`  |
| GET | `/logs`        | `logs#index`   |
| GET   | `/logs/:id`             | `logs#show`    |
| PATCH   | `/logs/:id`             | `logs#update`    |
| DELETE  | `/logs/:id` | `logs#destroy`  |
| GET | `/workouts`        | `workouts#index`   |
| GET   | `/workouts/:id`             | `workouts#show`    |

---

### User Actions

#### POST /sign-up

The `create` action expects a *POST* of `credentials` and `athlete` information identifying a new user and athlete-profile to create, in this case using `getFormFields`:

```html
<form>
  <input name="credentials[email]" type="text" value="la@example.email">
  <input name="credentials[password]" type="password" value="an example password">
  <input name="credentials[password_confirmation]" type="password" value="an example password">
  <input name="athlete[given_name]" type="text" value="lauren">
  <input name="athlete[surname]" type="text" value="p">
  <input name="athlete[date_of_birth]" type="date" value="1990-01-01">
</form>
```
Request:

```sh
curl http://localhost:4741/sign-up \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "'"${EMAIL}"'",
      "password": "'"${PASSWORD}"'",
      "password_confirmation": "'"${PASSWORD}"'"
    },
    "athlete": {
      "given_name": "'"${GIVEN_NAME}"'",
      "surname": "'"${SURNAME}"'",
      "date_of_birth": "'"${DOB}"'"
    }
  }'
```

```sh
EMAIL=laur@en.com PASSWORD=lauren GIVEN_NAME=lauren SURNAME=p DOB=1993-01-16 scripts/sign-in.sh
```

Response:

```md
HTTP/1.1 201 Created
Content-Type: application/json; charset=utf-8

{
  "user": {
    "id": 1,
    "email": "laur@en.com"
  }
}
```

#### POST /sign-in

Request:

```sh
curl http://localhost:4741/sign-in \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --data '{
    "credentials": {
      "email": "'"${EMAIL}"'",
      "password": "'"${PASSWORD}"'"
    }
  }'
```

```sh
EMAIL=laur@en.com PASSWORD=lauren scripts/sign-in.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "user": {
    "id": 1,
    "email": "laur@en.com",
    "token": "BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f"
  }
}
```

#### PATCH /change-password/:id

Request:

```sh
curl --include --request PATCH "http://localhost:4741/change-password/$ID" \
  --header "Authorization: Token token=$TOKEN" \
  --header "Content-Type: application/json" \
  --data '{
    "passwords": {
      "old": "'"${OLDPW}"'",
      "new": "'"${NEWPW}"'"
    }
  }'
```

```sh
ID=1 OLDPW=lauren NEWPW=queen TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f scripts/change-password.sh
```

Response:

```md
HTTP/1.1 204 No Content
```

#### DELETE /sign-out/:id

Request:

```sh
curl http://localhost:4741/sign-out/$ID \
  --include \
  --request DELETE \
  --header "Authorization: Token token=$TOKEN"
```

```sh
ID=1 TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f ID=1 scripts/sign-out.sh
```

Response:

```md
HTTP/1.1 204 No Content
```

### Users

| Verb | URI Pattern | Controller#Action |
|------|-------------|-------------------|
| GET  | `/users`    | `users#index`     |
| GET  | `/users/1`  | `users#show`      |

#### GET /users

Request:

```sh
curl http://localhost:4741/users \
  --include \
  --request GET \
  --header "Authorization: Token token=$TOKEN"
```

```sh
TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f scripts/users.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "users": [
    {
      "id": 2,
      "email": "bob@ava.com"
    },
    {
      "id": 1,
      "email": "ava@bob.com"
    }
  ]
}
```

#### GET /users/:id

Request:

```sh
curl --include --request GET http://localhost:4741/users/$ID \
  --header "Authorization: Token token=$TOKEN"
```

```sh
ID=2 TOKEN=BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f ID=1 scripts/user.sh
```

Response:

```md
HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8

{
  "user": {
    "id": 1,
    "email": "laur@en.com"
  }
}
```

### Athlete Actions

All athlete action requests must include a valid HTTP header `Authorization: Token token=<token>` or they will be rejected with a status of 401 Unauthorized.

#### update

The `update` action is a *PATCH* that updates the athlete who has authorization. It expects a PATCH of `athlete` specifying `given_name`, `surname`, and `date_of_birth`.

If the request is successful, the response will have an HTTP status of 204 No Content.

If the request is unsuccessful, the response will have an HTTP status of 400 Bad Request.

### Log Actions

All log action requests except `index` must include a valid HTTP header `Authorization: Token token=<token` or they will be rejected with a status of 401 Unauthorized.

#### create

The `create` action is a *POST* that creates a new log for the user signed in. It expects a POST of `log` specifying `date_completed` and `workout_id`. The user's id number automatically is assigned to `athlete_id`, as the two id numbers will be the same (see `signup`).
The response will have an HTTP status of 201 Created, and the body will contain JSON of the created log:
```json
{
  "id":7,
  "date_completed":"2017-02-21",
  "workout":{
    "id":1,
    "name":"Benchmark2k",
    "athletes":[3,9],
  },
  "athlete":{
    "id":3,
    "given_name":"Jeff",
    "surname":"Tufts",
    "date_of_birth":"1993-01-16",
    "workouts":[1, 2,3,10,13],
    "editable":true,
  }
}
```

#### index

The `index` action is a *GET* that retrieves all logs.
The response body will contain JSON containing an array of logged workouts, e.g.:
```json
{
  "logs": [
    {
      "id":1,
      "date_completed":"2017-02-22",
      "workout":{
        "id":3,
        "name":"Benchmark3663",
        "athletes":[3,9],
      },
      "athlete":{
        "id":3,
        "given_name":"Jeff",
        "surname":"Tufts",
        "date_of_birth":"1993-01-16",
        "workouts":[2,3,10,13],
        "editable":false,
      },
    },
    {
      "id":2,
      "date_completed":"2017-02-22",
      "workout":{
        "id":11,
        "name":"Anaerobic1221",
        "athletes":[5,6],
      },
      "athlete":{
        "id":6,
        "given_name":"Kate",
        "surname":"Tufts",
        "date_of_birth":"1993-01-16",
        "workouts":[11],
        "editable":false,
      },
    }
  ]
}
```
If a `user` is logged in, then `index` will return `editable` as true for that user's athlete.

#### show

The `show` action is a *GET* that retrieves all logs created by the current user.
The response body will contain JSON containing an array of the current user's logged workouts, e.g.:
```json
{
  "logs":[
    {
      "id":16,
      "date_completed":"2017-02-22",
      "workout":{
        "id":10,
        "name":"Anaerobic2500",
        "athletes":[1,2,3,8]
      },
      "athlete":{
        "id":1,
        "given_name":"Lauren",
        "surname":"Tufts",
        "date_of_birth":"1993-01-16",
        "workouts":[4,10,13],
        "editable":true
      }
    },
    {
      "id":11,
      "date_completed":"2017-02-22",
      "workout":{
        "id":4,
        "name":"Benchmark500Dash",
        "athletes":[1]
      },
      "athlete":{
        "id":1,
        "given_name":"Lauren",
        "surname":"Tufts",
        "date_of_birth":"1993-01-16"
        ,"workouts":[4,10,13],
        "editable":true
      }
    }
  ]
}
```

#### update

The `update` action is a *PATCH* that updates a logged workout for a user who has authorization. It expects a PATCH of `log` specifying `date_completed` and `workout_id`. The user's id number automatically is assigned to `athlete_id`.

If the request is successful, the response will have an HTTP status of 204 No Content.

If the request is unsuccessful, the response will have an HTTP status of 400 Bad Request.

#### destroy

The `destroy` action is a *DELETE* that deletes a logged workout for a user who has authorization.

If the request is successful, the response will have an HTTP status of 204 No Content.

If the request is unsuccessful, the response will have an HTTP status of 400 Bad Request.

### Workout Actions

For the time being, Workout will be treated as a resource database. Users can choose from the workouts provided to create logs. The `index` action request is so users can know which ids go with which workouts for when they create a log. Later down the line I would like to create an admin/"coach" model that can create workouts.

#### index

The `index` action is a *GET* that retrieves all workouts.
The response body will contain JSON containing an array of workouts, e.g.:
```json
{
  "workouts":[
    {
      "id":1,
      "name":"Benchmark2k",
      "athletes":[5],
    },
    {
      "id":2,
      "name":"Benchmark5k",
      "athletes":[3,8]
    }
  ]
}
```
