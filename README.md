# my-travels-rails-app

Ruby on Rails web application and content management system for making, organizing,
and documenting travel plans. Based on user experiences, the application provides
insight into the world's most popular destinations and the features that make them unique.

After creating an account, users have the ability to make new travel plans. For existing
plans users can submit journal entries or notes in the form of travel logs to detail their
upcoming itineraries or past experiences.

Users can also view the travel plans and logs submitted by other users. For convenience
and to aid with future planning, the app provides two dynamically generated tables based
on user data: one listing the most popular destinations and the other ranking the most
traveled users.

## Usage

To use this application, clone the repository and

(1) run `rails db:migrate db:seed`
> Creates the schema and seeds the database with 100 users, up to 10 travels per
user, and up to 5 logs per travel (all randomly generated).

(2) run `rails server`
> Starts the application.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rhhaynes/my-travels-rails-app.
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected
to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The application is available as open source under the terms of the
[MIT License](https://github.com/rhhaynes/my-travels-rails-app/blob/master/LICENSE.txt).

## Code of Conduct

Everyone interacting in the MyTravels project’s codebases, issue trackers, chat rooms and mailing lists is expected
to follow the [code of conduct](https://github.com/rhhaynes/my-travels-rails-app/blob/master/CODE_OF_CONDUCT.md).
