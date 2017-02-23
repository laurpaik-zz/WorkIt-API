# A Workout data store API

An API to store workout data and allow athletes to register as users and record their workout history.

### [Front-End Repo](https://github.com/laurpaik/WorkIt)

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
EMAIL='laur@en.com' PASSWORD='lauren' GIVEN_NAME='lauren' SURNAME='p' DOB='1993-01-16' sh scripts/sign-in.sh
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
EMAIL='laur@en.com' PASSWORD='lauren' sh scripts/sign-in.sh
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
ID=1 OLDPW='lauren' NEWPW='queen' TOKEN='BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f' sh scripts/change-password.sh
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
ID=1 TOKEN='BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f' ID=1 sh scripts/sign-out.sh
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
TOKEN='BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f' sh scripts/users.sh
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
ID=2 TOKEN='BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f' ID=1 sh scripts/user.sh
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

Request:
```sh
curl http://localhost:4741/athletes \
  --include \
  --request PATCH \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=$TOKEN" \
  --data '{
    "athlete": {
      "given_name": "'"${GIVEN_NAME}"'",
      "surname": "'"${SURNAME}"'",
      "date_of_birth": "'"${DOB}"'"
    }
  }'
```

```sh
ID=1 TOKEN='BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f' ID=1 GIVEN_NAME='Lauren' SURNAME='McFace' DOB='1993-01-01' sh scripts/athletes/update.sh
```

Response:

```md
HTTP/1.1 204 No Content
```

The `update` action is a *PATCH* that updates the athlete who has authorization. It expects a PATCH of `athlete` specifying `given_name`, `surname`, and `date_of_birth`.

If the request is successful, the response will have an HTTP status of 204 No Content.

If the request is unsuccessful, the response will have an HTTP status of 400 Bad Request.

### Log Actions

All log action requests except `index` must include a valid HTTP header `Authorization: Token token=<token` or they will be rejected with a status of 401 Unauthorized.

#### create

The `create` action is a *POST* that creates a new log for the user signed in. It expects a POST of `log` specifying `date_completed` and `workout_id`. The user's id number automatically is assigned to `athlete_id`, as the two id numbers will be the same (see `signup`).

Request:

```sh
curl http://localhost:4741/logs \
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
```

```sh
ID=1 TOKEN='BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f' DATE='2017-02-20' WORKOUT_ID=3 ATHLETE_ID=1 sh scripts/athletes/update.sh
```

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

The `index` action is a *GET* that retrieves all logs. I left this without an authorization header because I feel that people should be able to at least see what workouts users are doing. It's always fun to share your accomplishments.

Request:

```sh
curl http://localhost:4741/logs \
  --include \
  --request GET
```

```sh
sh scripts/logs/index.sh
```

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

Request:

```sh
curl http://localhost:4741/logs/$ID \
  --include \
  --request GET \
  --header "Authorization: Token token=$TOKEN"
```

```sh
TOKEN='BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f' ID=1 sh scripts/logs/show.sh
```

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

Request:
```sh
curl http://localhost:4741/logs/$ID \
  --include \
  --request PATCH \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=$TOKEN" \
  --data '{
    "log": {
      "date_completed": "'"${DATE}"'",
      "workout_id": "'"${WORKOUT_ID}"'"
    }
  }'
```

```sh
TOKEN='BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f' ID=1 DATE='2017-02-22' WORKOUT_ID=8 sh scripts/logs/show.sh
```

If the request is successful, the response will have an HTTP status of 204 No Content.

If the request is unsuccessful, the response will have an HTTP status of 400 Bad Request.

#### destroy

The `destroy` action is a *DELETE* that deletes a logged workout for a user who has authorization.

Request:
```sh
curl http://localhost:4741/logs/$ID \
  --include \
  --request DELETE \
  --header "Authorization: Token token=$TOKEN"
```

```sh
ID=1 TOKEN='BAhJIiVlZDIwZTMzMzQzODg5NTBmYjZlNjRlZDZlNzYxYzU2ZAY6BkVG--7e7f77f974edcf5e4887b56918f34cd9fe293b9f' ID=20 sh scripts/logs/destroy.sh
```
If the request is successful, the response will have an HTTP status of 204 No Content.

If the request is unsuccessful, the response will have an HTTP status of 400 Bad Request.

### Workout Actions

For the time being, Workout will be treated as a resource database. Users can choose from the workouts provided to create logs. The `index` action request is so users can know which ids go with which workouts for when they create a log. Later down the line I would like to create an admin/"coach" model that can create workouts.

#### index

The `index` action is a *GET* that retrieves all workouts. Again, I believe anyone should be able to see the workouts, so I have not required authorization for getting an index of workouts.

Request:
```sh
curl http://localhost:4741/workouts \
  --include \
  --request GET
```

```sh
sh scripts/workouts/index.sh
```

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
### My Struggles and Lessons Learned

I would say the biggest struggle for me during this project was setting up the relationship between the user and the athlete. I essentially created all my models and relationships separate from the user and added this last one-to-one relationship after I knew everything else worked. I believe I could have finished this earlier had I not included this relationship, but it not only makes my site more secure, but also gives me more flexibility to move forward with more models without worrying about security.

I guess you could say this taught me how to be patient with building the back-end and how to properly decipher the errors I get. I've been told time and time again that errors are a good thing, but I didn't fully understand until this project. I've definitely learned to trust my errors and relate more to the machine I'm operating.

I also learned how important the planning process is. I spent much more time planning for this project than the last, and I felt much more prepared to deal with my problems. While I didn't follow my schedule perfectly, I was able to spend a full day solely on debugging.

I think the most interesting part of this project for me was learning how much I enjoyed building the back-end. I came into this bootcamp thinking I would have these beautiful websites, yet this whole week I've been excited just to see everything work the way I intended even if the site itself is ugly as sin. That said, I do want to make them better looking later on, but that is no longer at the top of my priority list.

### Future Goals
- I would like to incorporate timeTaken and distance as optional parameters for the logs and the workouts.
- I also want to make `Workouts` CRUDable. My initial thought for this site was to let users create their own workouts and share them with each other.
- Eventually (much later down the line) I would like to create a `Set` model with optional columns such as `distance`, `timeTaken`, `rest`, `weight`, `reps`, etc... In my mind, `workout has_many :sets`. I think if I can create that relationship, I can start to let users create their own templates for workouts. I would need to learn a lot more about entity relationships, though.

### Built With:
- Ruby
- Ruby on Rails
- PostgreSQL
