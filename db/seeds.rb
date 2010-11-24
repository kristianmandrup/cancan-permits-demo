# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

@editor         = User.create(:name => "Editor",  :role => "editor")
@admin          = User.create(:name => "Admin",   :role => "admin")

@editor_article = Article.create(:user => @editor)
@admin_article  = Article.create(:user => @admin)      

# @ability        = Permits::Ability.new(@editor)
