# BLZ

```
This project initialized as a new business the idea was store all people that works with beauty like
hairdresser or barber, then customers would search by your required service and search your available time,
but we didnt won enough cash to keep the business open, then we converted this project to open source
```

## How to run

build and run the server

```
sudo docker-compose up --build
```

create and migrate database

```
sudo docker-compose run --rm web_app rails db:create db:migrate
```

## How to test

rspec

```
sudo docker-compose run --rm web_app rspec
```

rubocop

```
sudo docker-compose run --rm web_app rubocop -A
```
