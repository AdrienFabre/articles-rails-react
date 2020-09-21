# README

## Sharing App

This app uses Rails and React to pull a list of articles, display them and give the ability to like them.

### Requests

- Create a basic rails app (that we could run and try) with a React frontend integrated

- Pull the list of articles from this [link](https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/test-articles-v3.json), pull this from the server on page load (as it may change)

- Display the list of articles on the page.

- Add the ability to 'like' articles.

  - The data persisted and updated with each new page load.
  - The likes are global and not per user.

### User Stories

- As a global user of the 'Sharing App'

  - So I can visualise all the articles at once
  - I need to read the list of articles with:

    - article picture
    - article title
    - article description
    - owner name
    - owner avatar
    - since when it was was updated

  - So I can show interest like an article
  - I need to be able to click on a 'like' button

### Diagram

<img src="public/dataflow.jpg" alt="Dataflow" title="Dataflow" width="550" height="300" />

GET

1 - The list of articles get pulled from AWS to Rails server.

2 - The list of articles get adjusted in the Rails server.

- If the article exists in the database (same Id), it would get the number of likes.

- If the article does not exist in the database, it would create an instance of Article (with the new Id) and save it with a number of likes equal to 0.

3 - The adjusted list of articles get pulled from Rails server to React, to display the list.

PATCH

1 - Every article from the list of articles is displayed in a card which includes a button 'Like'.

2 - When the button is clicked, the specific Article Id is sent to the Rails server to the UPDATE route.

3 - The Rails server finds the article in the database and add one like, it then returns the updated number of likes to React.

### Articles Controller

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

### Running the app

```unix
git clone git@github.com:AdrienFabre/articles-rails-react.git
cd articles-rails-react
bundle
rake db:create db:migrate
rails s
```

then open: http://localhost:3000/

### Testing

Setup the database

```unix
rake db:create db:migrate
```

#### Rails Server - Rspec

Run Rspec test

```unix
rspec spec --format documentation
```

Results

```unix
Article
  validaton
    id
      must be present
    likes
      must be present
  #complete_article
    returns an object with necessary keys
  #add_like
    returns an article with one more like

Articles Controller
  GET /api/v1/articles
    returns the correct articles keys with new data
    returns the correct articles keys with saved data
  PATCH /api/v1/articles/:id
    returns the updated article
    raises error if not existing id

Status requests
  GET /api/v1/articles
    returns status 200
  PATCH /api/v1/articles/:id
    returns a status 200

Finished in 1.45 seconds (files took 1.6 seconds to load)
10 examples, 0 failures

Coverage report generated for RSpec to /home/adrien/Desktop/Rails React Projects/articles-rails-react/coverage. 129 / 129 LOC (100.0%) covered.
```

#### React Frontend - Cypress

Launch the app

```unix
rails s
```

Run Cypress test

```unix
npx cypress run
```

Resulst

```unix
Running:  home_page_spec.js (1 of 1)

  The Home Page
    ✓ successfully loads (709ms)
    ✓ contains Sharing App
    ✓ contains api response text (489ms)
    ✓ contains the clear image (289ms)
    ✓ contains the blur image (102ms)
    ✓ contains the avatar image (106ms)
    ✓ contains the like button (63ms)

  7 passing (3s)
```

### Recreate the database

```unix
rake db:drop db:create db:migrate
```
