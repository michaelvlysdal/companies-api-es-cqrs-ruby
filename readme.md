# Optimistic ruby api, with ES/CQRS using the sequent gem

First attempt at playing around with ruby. Using ES and CQRS to make it easier to adapt to future requirements and changes.

Loads of things that can be improved, probably adding tests and validations is most crucial.

## Getting started

Requires PostgreSQL locally installed

```sh
export DATABASE_URL=postgres://:@localhost/companies_db
bundle install
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake view_schema:build
bundle exec rackup -p 4567
```

Some curls

Create a company:
curl -i -X POST -H "Content-Type: application/json" -d'{"name":"Testing","cvr":"a cvr","address":"An address","city":"Århus","country":"Denmark","phone":"1234"}' http://localhost:4567/api/v1/companies

Get companies:
curl -H "Content-Type: application/json" http://localhost:4567/api/v1/companies

Pick an id and get more details for a specific company:
curl -H "Content-Type: application/json" http://localhost:4567/api/v1/companies/{ID}