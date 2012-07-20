FactoryGirl.define do
  factory :user do
    name     "Sandy PIERRE"
    email    "sandy.pierre@bemonkey.net"
    password "foobar"
    password_confirmation "foobar"
  end
end