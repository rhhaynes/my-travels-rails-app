# my-travels-rails-app

Rails MVC web application with CRUD functionality for making, organizing, and
documenting travel plans. Based on user experiences, MyTravels provides insight
into the world's most popular destinations and the features that make them unique.

After creating an account, users have the ability to make new travel plans. For
existing plans users can submit travel logs detailing their upcoming itineraries
and past experiences.

Users can also view the travel plans and logs submitted by other users. For
convenience the app provides two dynamically generated lists based on user data:
one showing the most popular destinations and the other ranking the most traveled
users.

## Usage

To use this application, clone the repository and

(1) run `rails db:migrate db:seed`
> Creates the schema and seeds the database with 100 users, up to 10 travels per
user, and up to 5 logs per travel (all randomly generated).

(2) run `rails server`
> Starts the application.
