# To change this template, choose Tools | Templates
# and open the template in the editor.

Factory.define :user do |f|
  f.sequence(:firstname) { |n| "first#{n}"}
  f.sequence(:lastname) { |n| "last#{n}"}
  f.password "test"
  f.password_confirmation { |u| u.password }
  f.sequence(:email) { |n| "email#{n}@email.com"}
end