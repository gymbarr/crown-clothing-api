# Crown Clothing API
> A backend part of an E-Commerce application "Crown Clothing Shop" that provides an API to its data
> Frontend part of the "Crown Clothing Shop": [https://github.com/gymbarr/crown-clothing-client]
> Live demo for the whole fullstack app [_here_](https://cosmic-sawine-9f1c88.netlify.app/).

## Table of Contents
* [General Info](#general-information)
* [Technologies Used](#technologies-used)
* [Features](#features)
* [Prerequisite](#prerequisite)
* [Getting Started](#getting-started)
* [Configurations](#configurations)
* [Making Purchases](#making-purchases)
* [Sending Emails](#sending-emails)
* [User Roles](#user-roles)
* [Project Status](#project-status)
* [Room for Improvement](#room-for-improvement)
* [Contact](#contact)


## General Information
API made with Ruby on Rails as main framework. The API provides users authentication system based on JWT tokens.
It also has administration functionality, so requests are authorized based on users permissions.
All responses data are serialized in JSON format.
The app maintains notifications by email.


## Technologies Used
- Ruby on Rails - version 7.0.4
- PostgreSQL - version 14
- ElasticSearch - version 7.17.9
- Stripe - version 8.1.0


## Features
- Authentication system based on JWT tokens (with token autorefreshing)
- Authorization system based on users roles
- Storing images via Rails Active Storage
- Searching by categories and products via ElasticSearch and PostgreSQL
- Creating Stripe Checkout Session and handling Stripe Webhook for making purchases
- Sending notifications to users via email about payments
- CI with Github Actions (tests and linter jobs)
- CD with Capistrano


## Prerequisite
- **Ruby 3.1.1**
- **Rails 7.0.4**
- **PostgreSQL 14**
- **ElasticSearch 7.17.9**


## Getting Started
**Clone the repo from github**

        $ git clone https://github.com/gymbarr/crown-clothing-api.git
        $ cd crown-clothing-api
        $ bundle install

**Create `.env` file in the root folder of the project and past to it content of the `.env.example` file**
**Setup database credentials as shown in the Configuration section for ActiveRecord and create database running**

        $ rails db:create

**Run the migrations**

        $ rails db:migrate

**Run ElasticSearch (depending on the way it was installed) on port 9200**
**Generate data by running seeds (optionally)**

        $ rails db:seed

**Run the backend server**

       $ rails server

**Run the frontend server and test functionality in the browser**


## Configurations
### ActiveRecord
Set credentials for your database by filling variables with blank values under `# database PostgreSQL variables`

```env
# .env
# database PostgreSQL variables

DB_HOST=localhost
DB_PORT=5432
DB_USERNAME=
DB_PASSWORD=
DB_RAILS_MAX_THREADS=5
DB_NAME_DEVELOPMENT=crown_clothing_db_development
DB_NAME_TEST=crown_clothing_db_test
DB_NAME_PRODUCTION=crown_clothing_db_production
```

### Action Mailer
Set credentials for your mailing server by filling variables with blank values under `# mailer variables`

```env
# .env
# mailer variables

ACTION_MAILER_DELIVERY_METHOD=smtp
SMTP_ADDRESS=smtp.gmail.com
SMTP_PORT=587
SMTP_USERNAME=
SMTP_PASSWORD=
SMTP_SECURED_PASSWORD=
SMTP_AUTHENTICATION=plain
```

### Stripe
Set api keys of your stripe account under `# stripe keys variables`

```env
# .env
# stripe keys variables

STRIPE_PUBLISHABLE_KEY=
STRIPE_SECRET_KEY=
STRIPE_ENDPOINT_SECRET=
```


## Making Purchases
For dealing with making purchases in the app you need to create an account on [stripe.com](https://stripe.com).
And set api keys as shown in the Configuration section for Stripe.

To approve payments from users stripe send to the app a webhook as a confirmation.
This webhook can be added in your personal account. And its endpoint have to lead to the webhooks_controller of the app.
But for the local environment the app server is not visible from the Internet.
So to test this functionality localy you can use [ngrok](https://ngrok.com) as a gateway to the Internet.


## Sending Emails
The application maintains notifications by email sending for some scenarios:
- After successful payment of an order;
- When payment was successfull but the product is out of stock.

To turn on notifications by emails you need to configure SMTP settings as shown in the Configuration section for Action Mailer.


## User Roles
The application has two types of roles:
- basic user (is added to every user after sign up)
- admin user

Adding the admin role to a user:

```ruby
user = User.find(1)
user.add_role Role.admin_user_role
```


## Project Status
Project is: _in progress_


## Room for Improvement
To do:
- Authentication with Google
- Localize the app to support other languages


## Contact
Created by [@Andrey Timakhovich](https://www.linkedin.com/in/andrey-timakhovich/) - feel free to contact me!
