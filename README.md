# Whether Sweater...Sweater Weather 
<img src="https://media.giphy.com/media/1hoNF06qLj0AehQrUE/giphy.gif" width="350" height="350">


## Table of Contents
- [Project Overview](#project-overview)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Contributions](#contributions)
- [Acknowledgements](#acknowledgements)

***
## Project Overview
Whether Sweater, besides being somewhat of a tongue twister, is a fictional trip planning back-end application built with Rails. It uses data from several external API services to provide the "front-end team" with current and future forecast information for a location from its coordinates as well as an image of that location. 

Please see the external API resources used [here](#external-api-info)

### Built With:
- Ruby 2.5.3
- Rails 5.2.4
- Postgres

***
## Getting Started

### Local Setup:
1. Fork and clone this repository.
2. `cd whether_sweater`
3. Run `bundle install` to install gem packages.
4. Run `rails db:setup` to setup the databases.
5. Run `bundle exec figaro install`
6. Add your own API keys to the `config/application.yml` file and name them accordingly:

- `MAPQUEST_API_KEY: <api_key>`
- `OPEN_WEATHER_API_KEY: <api_key>`
- `UNSPLASH_API_KEY: <api_key>`

_To get your own API keys, please follow the links listed [here](#external-api-info). You will only need one for MapQuest_

_[Gems Used](#gems-installed)_
***

## Usage

### Testing: 
- Run tests: `bundle exec rspec`
- Run through the different endpoints by running `rails s` from your CLI
  - **Recommended** Use Postman to see specific responses. 
  
  [![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/2ea6fbdf2969697791fc)
  
  - **Note**: If you are having trouble with the [endpoints](#endpoints) working, please ensure you are in your development environment. 
    - If you need to change to your development environment, please run `ENV=development rails s` instead of just `rails s`


### Endpoints:
- [Retrive Weather for a Location](#retrieve-weather-for-a-location)
- [Background Image by Location](#background-image-by-location)
- [User Registration](#user-registration)
- [User Login](#user-login)
- [Road Trip](#road-trip)

#### Retrieve Weather for a location
`GET /api/v1/forecast?location=city,state`

This endpoint retrieves weather forecast information based on a city/state combination. It references the MapQuest Geocoding API to find longitude and latitude coordinates which is passed to the OpenWeather One Call API to return a set of current, daily and hourly forecast information. The response is in JSON format.

Response Example:

```
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "datetime": "2021-01-21T11:06:42.000-07:00",
                "sunrise": "2021-01-21T07:16:00.000-07:00",
                "sunset": "2021-01-21T17:06:21.000-07:00",
                "temperature": 45.37,
                "feels_like": 39.07,
                "humidity": 35,
                "uvi": 1.83,
                "visibility": 10000,
                "conditions": "overcast clouds",
                "icon": "04d"
            },
            "daily_weather": [
                {
                    "date": "01/22/21",
                    "sunrise": "2021-01-22T07:15:24.000-07:00",
                    "sunset": "2021-01-22T17:07:31.000-07:00",
                    "max_temp": 47.7,
                    "min_temp": 31.71,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "date": "01/23/21",
                    "sunrise": "2021-01-23T07:14:45.000-07:00",
                    "sunset": "2021-01-23T17:08:41.000-07:00",
                    "max_temp": 45.73,
                    "min_temp": 27.81,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "date": "01/24/21",
                    "sunrise": "2021-01-24T07:14:05.000-07:00",
                    "sunset": "2021-01-24T17:09:52.000-07:00",
                    "max_temp": 36.16,
                    "min_temp": 27.7,
                    "conditions": "scattered clouds",
                    "icon": "03d"
                },
                {
                    "date": "01/25/21",
                    "sunrise": "2021-01-25T07:13:22.000-07:00",
                    "sunset": "2021-01-25T17:11:03.000-07:00",
                    "max_temp": 37.47,
                    "min_temp": 28.98,
                    "conditions": "light snow",
                    "icon": "13d"
                },
                {
                    "date": "01/26/21",
                    "sunrise": "2021-01-26T07:12:38.000-07:00",
                    "sunset": "2021-01-26T17:12:15.000-07:00",
                    "max_temp": 36.21,
                    "min_temp": 28.71,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                }
            ],
            "hourly_weather": [
                {
                    "time": "12:00:00",
                    "temperature": 44.78,
                    "wind_speed": "3.87 mph",
                    "wind_direction": "from E",
                    "conditions": "broken clouds",
                    "icon": "04d"
                },
                {
                    "time": "13:00:00",
                    "temperature": 45.57,
                    "wind_speed": "2.8 mph",
                    "wind_direction": "from E",
                    "conditions": "scattered clouds",
                    "icon": "03d"
                },
                {
                    "time": "14:00:00",
                    "temperature": 46.08,
                    "wind_speed": "3.2 mph",
                    "wind_direction": "from NE",
                    "conditions": "scattered clouds",
                    "icon": "03d"
                },
                {
                    "time": "15:00:00",
                    "temperature": 46.47,
                    "wind_speed": "3.8 mph",
                    "wind_direction": "from NNE",
                    "conditions": "scattered clouds",
                    "icon": "03d"
                },
                {
                    "time": "16:00:00",
                    "temperature": 45.57,
                    "wind_speed": "4.68 mph",
                    "wind_direction": "from NNE",
                    "conditions": "broken clouds",
                    "icon": "04d"
                },
                {
                    "time": "17:00:00",
                    "temperature": 43.54,
                    "wind_speed": "4.81 mph",
                    "wind_direction": "from NNE",
                    "conditions": "broken clouds",
                    "icon": "04d"
                },
                {
                    "time": "18:00:00",
                    "temperature": 41.88,
                    "wind_speed": "4.5 mph",
                    "wind_direction": "from NE",
                    "conditions": "overcast clouds",
                    "icon": "04n"
                },
                {
                    "time": "19:00:00",
                    "temperature": 40.5,
                    "wind_speed": "3.29 mph",
                    "wind_direction": "from NE",
                    "conditions": "overcast clouds",
                    "icon": "04n"
                }
            ]
        }
    }
}
```

#### Background Image by Location
`GET /api/v1/backgrounds?location=city,state`

This endpoint retrieves an image from the Unsplash API for the location query given. The endpoint also includes credit information for the author of the image and their website url. The response is returned in JSON format.

Response Example:
```
{
    "data": {
        "id": null,
        "type": "image",
        "attributes": {
            "image": {
                "location": "denver,co",
                "image_url": "https://images.unsplash.com/photo-1603033156166-2ae22eb2b7e2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwxOTkzNjl8MHwxfHNlYXJjaHwxfHxkb3dudG93biUyMGRlbnZlcixjb3xlbnwwfHx8&ixlib=rb-1.2.1&q=80&w=1080",
                "alt_text": "Downtown Denver summer 2017",
                "credit": {
                    "source": "unsplash.com",
                    "photographer": "Andrew Coop"
                }
            }
        }
    }
```

#### User Registration
`POST /api/v1/users`

The User Registration endpoint takes in a JSON request in the body and creates a user unless that user already exists in the database. In addition, the User model generates a unique API Key for that user and saves it along with their email address and encrypted password. The endpoint sends back that user's email address and API key in the body of the response.

Request Example: 
```
{
  "email": "test@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```

Response Example:
```
{
    "data": {
        "id": "2",
        "type": "user",
        "attributes": {
            "email": "test@example.com",
            "api_key": "AbcD123example"
        }
    }
}
```

#### User Login
`POST /api/v1/sessions`

The login endpoint is able to receive a JSON body request with an email address and password, authenticate that user, and return that user's email address and API key in the body of the response.

Request Example:
```
{
  "email": "example@example.com",
  "password": "password"
}
```

Response Example:
```
{
  "data": {
    "type": "users",
    "id": "2",
    "attributes": {
      "email": "example@example.com",
      "api_key": "AbcD123example"
    }
  }
}
```

#### Road Trip
`POST /api/v1/road_trip`

This endpoint uses a origin and destination to provide an expected time of arrival (`travel_time`) and the weather forecast at the destination, including its condition and temperature. The JSON body request must include an authorized API key to return a response.

Request Example:
```
{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "AbcD123example"
}
```

Response Example:
```
{
    "data": {
        "id": null,
        "type": "roadtrip",
        "attributes": {
            "start_city": "Denver,CO",
            "end_city": "Pueblo,CO",
            "travel_time": "01 hour(s), 44 minute(s)",
            "weather_at_eta": {
                "conditions": "clear sky",
                "temperature": 52.03
            }
        }
    }
}
```
***
## Contributions
**Carson Jardine** 

[![Linkedin](https://i.stack.imgur.com/gVE0j.png) LinkedIn](https://www.linkedin.com//in/carson-jardine/)
&nbsp; ||
[![GitHub](https://i.stack.imgur.com/tskMh.png) GitHub](https://github.com/carson-jardine)
***
## Acknowledgements
This project was completed at the Turing School of Design & Engineering, Backend Engineering Program during Module 3. Checkout the [project page](https://backend.turing.io/module3/projects/sweater_weather/) and [technical requirements](https://backend.turing.io/module3/projects/sweater_weather/requirements).

This application utilizes the following free API datasets:
#### External API Info:
- [MapQuest Geocoding API](https://developer.mapquest.com/documentation/geocoding-api/)
- [MapQuest Directions API](https://developer.mapquest.com/documentation/directions-api/)
- [OpenWeather OneCall API](https://openweathermap.org/api/one-call-api)
- [Unsplash Image API](https://unsplash.com/developers)

#### Gems Installed:
- [`factory-bot`](https://github.com/thoughtbot/factory_bot) - testing object generator
- [`faker`](https://github.com/faker-ruby/faker) - generates fake data for testing
- [`faraday`](https://github.com/lostisland/faraday) - HTTP client library that provides a common interface over many adapters
- [`fastjson-api`](https://github.com/Netflix/fast_jsonapi) - Ruby object serializer
- [`figaro`](https://github.com/laserlemon/figaro) - makes it easy to securely configure Rails applications.
- [`pry`](https://github.com/pry/pry) - runtime developer console
- [`rspec-rails`](https://github.com/rspec/rspec-rails) - testing suite
- [`simplecov`](https://github.com/simplecov-ruby/simplecov) - tracks test coverage
- [`shoulda-matchers`](https://github.com/thoughtbot/shoulda-matchers) - simplifies testing syntax
- [`vcr`](https://github.com/vcr/vcr) - records your test suite's HTTP interactions and replays them during future test runs for fast, deterministic, accurate tests.
- [`webmock`](https://github.com/bblimke/webmock) - library for stubbing and setting expectations on HTTP requests in Ruby.
