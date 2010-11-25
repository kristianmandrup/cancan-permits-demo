# Rails 3 demo app for using CanCan permits

Uses version 0.3.1 of cancan-permits.

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

## Create Permits (and Licenses) using the generator

<code>$ rails g permits --roles editor</code>

<code>
     create  app/permits/guest_permit.rb
     create  app/permits/admin_permit.rb
     create  app/permits/editor_permit.rb
     create  app/permits/any_permit.rb
     create  app/permits/system_permit.rb

     create  app/licenses/user_admin_license.rb  
     create  app/licenses/blogging_license.rb  
</code>

To avoid generating deault licenses:
<code>$ rails g permits --roles editor --no-default-licenses</code>

To get list of all generator options
<code>$ rails g permits</code>

## Edit permits

Admin permit:
<code>
  def permit?(user, options = {}) 
    return if !role_match? user    
    can :manage, :all    
  end    
</code>

Any permit:
<code>
  def permit?(user, options = {}) 
    super        
  end  
</code>

Editor permit:
<code>
  def permit?(user, options = {}) 
    super
    return if !role_match? user    
    owns(user, Article)
  end
</code>

Guest permit:
<code>
  def permit?(user, options = {}) 
    super    
    return if !role_match? user   
    can :create, Article
  end  
</code>

System permit:
<code>
  def permit?(user, options = {}) 
    super
    request = options[:request]
    if request && request.host.localhost? && localhost_manager?
      can(:manage, :all) 
      return :break
    end    
  end  
</code>

The system permit illustrates an example of how custom data can be sent into the options hash to be used for considering whether to give permission.
Here it is assumed that the :request key can optionally have a request object to be used to determine if the user is accessing the app from localhost. 

## Test that it works!

Migrate the DB (Development mode)

<code>$ rake db:migrate</code> 

Seed the database with initial data (optional)

<code>rake db:seed</code>

Make the Test DB reflect the evelopment DB

<code>rake db:test:prepare</code> 

The main spec is in spec/models/user_spec.rb

<code>$ rspec models/user_spec.rb</code>

## Integrating CanCan REST links

Gemfile
<code>
  gem 'cancan', '~> 1.4.0' # not sure this one is needed, but ...  
  gem 'cancan-rest-links', '~> 0.1.5'
  gem 'cream', '~> 0.7.4'  
  gem 'devise', '~> 1.2.0'    
</code>

Run bundler
<code>$ bundle install</code>

<code>$ rails generate devise:install</code>

<code>$ rails generate devise User</code>

Fix the devise user migration:

<code>
  class DeviseCreateUsers < ActiveRecord::Migration
    def self.up
      drop_table :users   # <----- temporary hack, remove after migration is run

      create_table(:users) do |t|
        t.string :name    # <-----
        t.string :role    # <----- 

        t.database_authenticatable :null => false  
  ...
</code>

Update the Database!

<code>$ rake db:migrate</code> 

<code>rake db:test:prepare</code> 

Create a Rails initializer 'initializers/rest_links.rb'

We need to define the available roles in a central location.

<code>
  module Cream
    def self.available_roles
      [:guest, :admin, :editor]
    end
  end
  
  # This is really UGLY!!! Yikes. Sorry guys...
  require 'cancan-rest-links/rails/configure'  
  require 'cream'
  require 'cream/configure/rails'  
</code>

We should also modify the User model in 'models/user.rb' to reference this

<code>
  def self.roles
    Cream.available_roles # [:guest, :admin, :editor]
  end      
</code>

## Setup a Devise user authentication filter

Make all pages require login

application_controller.rb
<code>
class ApplicationController < ActionController::Base
  protect_from_forgery  
  before_filter :authenticate_user!    
end
</code>

This will ensure that current_user is set, which is fx used by CanCan's #can? and #cannot? methods

## Modify Devise views

Now we need to configure the sign up form:

<code>$ rails generate devise:views</code>

in 'views/devise/registrations/new.html.erb'

We insert some code to create a text field to enter the role of a user

<code>
  <p><%= f.label :role %><br />
  <%= f.text_field :role %></p>
</code>

## Test the full Authorization system with users and Permits

<code>$ rails server</code>

Now when we go to localhost:3000/articles, we will be sent to a page asking us to login or signup. If we signup we can create a user and experiment with different roles,
then edit the permission files and see which links will be active or not for a given user with a given role. Nice! 

## Contributions

In order to contribute to and improve the framework, I suggest you start by cloning the gems used:

<code>
  $ git clone git://github.com/kristianmandrup/cancan-rest-links.git
  $ git clone git://github.com/kristianmandrup/cream.git
  $ git clone git://github.com/kristianmandrup/cancan-permits.git  
</code>

Then configure the Gemfile to point to your local gem copy 

Gemfile
<code>
  gem 'cancan-permits', '~> 0.3.1', :path => '/...//cancan-permits'
  gem 'cancan-rest-links', '~> 0.1.6', :path => '...//cancan-rest-links'
  gem 'cream', '~> 0.7.4', :path => '/...//cancan-permits'  
</code>

Then you are free to put whatever debugging code (p puts and ... statetement?) in your local copy of the gems.

### Design trouble areas

Currently there is a very bad dependency issue between *cream* and *cancan-rest-links* which should be fixed ASAP. 
It should also not be required to have the *#auth_labels* method and it should definetely not be required to be present on the View! 
A redesign of this part is essential!

## Troubleshooting

If you have problem with the rspec executable version, uninstall any rspec-core > 2.0.1 and try again.

<code>$ gem list rspec-core</code>

Uninstall executables:
<code>$ gem uninstall rspec-core -v 2.1.0</code>
<code>$ gem uninstall rspec-expectations -v 2.1.0</code>

Reinstall executables:
<code>$ gem uninstall rspec-core -v 2.0.1</code>
