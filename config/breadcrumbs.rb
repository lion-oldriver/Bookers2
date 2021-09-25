crumb :root do
  link "Home", root_path
end

crumb :books_index do
  link "Index", books_path
  parent :root
end

crumb :book_show do |book|
  link "#{book.title}", book_path(book)
  parent :books_index
end

crumb :book_edit do |book|
  link "編集", edit_book_path(book)
  parent :book_show, book
end

crumb :users_index do
  link "Index", users_path
  parent :root
end

crumb :user_show do |user|
  link "#{user.name}", user_path(user)
  parent :users_index
end

crumb :user_edit do |user|
  link "編集", edit_user_path(user)
  parent :user_show, user
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).