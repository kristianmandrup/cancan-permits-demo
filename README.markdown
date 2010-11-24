# Rails 3 demo app for using CanCan permits

Uses version 0.2.9 of cancan-permits.

## Create Model

* Create User model with a :role attribute
* Create Article model
* Let a User have many Articles 

### User model

<code>$ rails g scaffold user name:string role:string</code>

<code>
  class Article < ActiveRecord::Base
    belongs_to :user
  end  
</code>

### Article model

<code>$ rails g scaffold article user_id:integer name:string body:string</code>

<code>
  class User < ActiveRecord::Base
    has_many :articles
  end  
</code>

## Create Permits

<code>$ rails g permits</code>

<code>
     create  app/permits/guest_permit.rb
     create  app/permits/admin_permit.rb
     create  app/permits/any_permit.rb
     create  app/permits/system_permit.rb
     create  app/permits/licenses.rb  
</code>

## Test that it works

First run <code>$ rake db:migrate && rake db:sedd</code> in the terminal to setup and init the database.

The main test is in spec/models/user

<code>$ rspec models/user_spec.rb</code>

Does it work!?