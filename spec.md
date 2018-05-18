# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes)
```ruby
User
has_many :travels
```
```ruby
Destination
has_many :travels
```
```ruby
Travel
has_many :logs
```

- [x] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User)
```ruby
Travel
belongs_to :user
belongs_to :destination
```
```ruby
Log
belongs_to :travel
```

- [x] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients)
```ruby
User
has_many :destinations, :through => :travels
has_many :logs, :through => :travels
```
```ruby
Destination
has_many :users, :through => :travels
has_many :logs, :through => :travels
```

- [x] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity)
```ruby
Travel
t.string :purpose
t.date :start_date
t.date :end_date
```

- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
```ruby
User
validates :username, :presence => true, :uniqueness => true, :format => {:without => /\A.*\@.*\z/}
validates :email,    :presence => true, :uniqueness => true, :format => {:with => /\A\w+\@\w+\.\w+\z/}
```
```ruby
Destination
validates :name, :presence => true, :uniqueness => true
```
```ruby
Travel
validates :start_date, :presence => true
```
```ruby
Log
validates :title, :presence => true, :uniqueness => {:scope => :travel, :message => "has already been used"}
```

- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
```ruby
URL: /home
User.most_travels
# def self.most_travels(n = 15)
#   self.left_joins(:destinations)
#       .group(:username)
#       .order("COUNT(destinations.id) DESC")
#       .limit(n)
# end
```
```ruby
URL: /home
Destination.most_popular
# def self.most_popular(n = 15)
#   self.left_joins(:users)
#       .group(:name)
#       .order("COUNT(users.id) DESC")
#       .limit(n)
# end
```

- [x] Include signup (how e.g. Devise)
```ruby
Custom Authentication Logic
URL: / 
URL: /signup
```

- [x] Include login (how e.g. Devise)
```ruby
Custom Authentication Logic
URL: /login
```

- [x] Include logout (how e.g. Devise)
```ruby
Custom Authentication Logic
URL: /logout
```

- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
```ruby
OmniAuth - GitHub
URL: / 
URL: /login
URL: /signup
```

- [x] Include nested resource show or index (URL e.g. users/2/recipes)
```ruby
URL: /:user_slug/destinations
URL: /:user_slug/travels
URL: /travels/1/logs/1
```

- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients)
```ruby
URL: /travels/1/logs/new
```

- [x] Include form display of validation errors (form URL e.g. /recipes/new)
```ruby
URL: / 
URL: /login
URL: /signup
URL: /:user_slug/edit
URL: /:user_slug/travels
URL: /travels/1/edit
URL: /travels/1/logs/new
URL: /travels/1/logs/1/edit
```

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate
