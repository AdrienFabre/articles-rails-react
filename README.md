# README

## Article App

This app uses Rails and React to pull a list of articles, display them and give the ability to like them.

### Requests

- Pull the list of articles from:

  - https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/test-articles-v3.json
  - Pull this from the server on page load (as it may change)

- Display the list of articles on the page.

- Add the ability to 'like' an article.

  - The data persisted and updated with each new page load.
  - The likes are global and not per user.

- Organise a collection.

### Dataflow

1/ List of articles get pulled from AWS to Rails controller

2/ List of articles get pulled from Rails controller to React

#### Articles Controller

<img src="public/dataflow.jpg" alt="Dataflow" title="Dataflow" width="550" height="300" />

index

- pull list_of_articles from AWS

  - map through the list_of_articles

    - create updated_article

    - if 'article id' exists in the DB

      - find 'article id'

      - add 'likes' to updated_article

    - else

      - create the article in the DB with 0 like

  - complete the updated_article necessary data

- return all updated_articles

update

- find 'article id'
- add 'likes' to updated_article
- return updated_article

### Testing

I will use Rspec for the Rails backend.
I will use Jest for the React frontend.

### Running the app

- fork the repo
- run
  - bundle install
  - yarn install
  - rake db:create
  - rake db: migrate
  - rails s
  - then open: http://localhost:3000/

### Recreate the DB

- rake db:drop db:create db:migrate

### Dependencies

Rails

- rest-client

React

- axios
