# Satellite Challenge

### Rails API Application

## Table of Contents

  - [Author](#author)
  - [Getting Started](#getting-started)
  - [Endpoints](#endpoints)
  - [Runing the tests](#running-the-tests)
  - [Built With](#built-with)
  - [Versioning](#versions)

## Author

  - **Kris Litman**<br>
    [GitHub](https://github.com/krislitman)<br>
    [LinkedIn](https://www.linkedin.com/in/kris-litman/)

## Getting Started

<!-- Add application specific instructions -->

### Installing

These instructions will get you up and running with a copy of the project on
your local machine for development and testing purposes.

1. Fork and Clone this repo
2. Install all the required packages in the Gemfile with the command: `bundle install`
3. Run `rails db:{drop,create,migrate}` to create and migrate the database
4. Run rails s to start the rails server (located at localhost:3000)
5. Enter endpoints (see below) into your browser or Postman to see JSON responses!

## Endpoints

#### /stats

**`GET localhost:3000/api/v1/stats`**

<ul>
  <li>
  </li>
</ul>

Example Response:

#### /health

**`GET localhost:3000/api/v1/health`**

<ul>
  <li>
  </li>
</ul>

Example Response:


## Running the tests 

**Testing with RSpec**
To run the full test suite you will need to run the command:
`bundle exec rspec`

<!-- Add where to find and run unit tests -->

## Built With

- Rails
- PostgreSQL
- Postman
- RSpec
- Capybara
- Fast JSON API
- Faraday
- Shoulda Matchers

## Versions

- Ruby 2.5.3

- Rails 5.2.6
