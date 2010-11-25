# Rails 3 demo app for using CanCan permits

Uses version 0.3.0 of cancan-permits.

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

If you have problem with rspec version, uninstall any rspec-core > 2.0.1 and try again.

Uninstall executables
<code>$ gem uninstall rspec-core -v 2.1.0</code>
<code>$ gem uninstall rspec-expectations -v 2.1.0</code>

Reinstall executables
<code>$ gem uninstall rspec-core -v 2.0.1</code>

<code>
  License BloggingLicense could not be enforced using #<SystemPermit:0x0000010320e668 @ability=#<Permits::Ability:0x0000010320ee60 @can_definitions=[#<CanCan::CanDefinition:0x00000103206378 @match_all=false, @base_behavior=true, @actions=[:manage], @subjects=[User(Table doesn't exist)], @conditions={}, @block=nil>]>, @strategy=:default>  
</code>

The error seems to be caused by the User class not seeming to have a corresponding table!?

*Please help me fix the spec so that it works :)*