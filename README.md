# Satellite Challenge

Rails API Application that uses a custom rake task to read in real-time altitude data, 
and exposes an API.

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

To collect the real-time altitude data, you will need to run a rake task. This will run until you decide to 
stop the process, and re-running the process will erase any previously collected data. You can request the 
end-points as soon as you run the rake task & local server. See the instructions below to begin. 

### Installing

These instructions will get you up and running with a copy of the project on
your local machine for development and testing purposes.

1. Fork and Clone this repo
2. Install all the required packages in the Gemfile with the command: `bundle install`
3. Run `rails db:{drop,create,migrate}` to create and migrate the database
4. Run the rake task `rails pull_data:run` which will read in the real-time altitude data
4. Run `rails s` simultaneously to start the rails server (located at localhost:3000)
5. Enter endpoints (see below) into your browser or Postman to see JSON responses!

## Endpoints

#### /stats

**`GET localhost:3000/api/v1/stats`**

<ul>
  <li>
    The /stats end-point returns the minimum, maximum, and average altitude for
    the satellite over the last five minutes
  </li>
</ul>

Example Response:

```
{
    "data": {
        "id": "null",
        "type": "five_minute_altitude_stats",
        "attributes": {
            "minimum": 160.0,
            "maximum": 160.0,
            "average": 160.0
        }
    }
}
```

#### /health

**`GET localhost:3000/api/v1/health`**

<ul>
  <li>
    The /health end-point returns a warning message when the satellite's average altitude goes below 160km for 
    more than one minute, a message stating sustained low earth orbit resumed, or an 'OK' message 
  </li>
</ul>

Example Response:

```
{
    "data": {
        "id": "null",
        "type": "satellite_health",
        "attributes": {
            "message": "Altitude is A-OK"
        }
    }
}
```

## Running the tests 

**Testing with RSpec**
To run the full test suite you will need to run the command:
`bundle exec rspec`

To run the unit test, use the command:
`bundle exec rspec spec/unit_tests/health_spec.rb`

## Built With

- Rails
- PostgreSQL
- Postman
- RSpec
- Capybara
- Fast JSON API
- Faraday
- Shoulda Matchers
- Factory Bot Rails

## Versions

- Ruby 2.5.3

- Rails 5.2.6
