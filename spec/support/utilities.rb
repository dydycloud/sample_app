include ApplicationHelper

def valid_signup 
  fill_in "Name",           with: "Example User"
  fill_in "Email",          with: "user@example.com"
  fill_in "Password",       with: "foobar"
  fill_in "Confirmation",   with: "foobar"
end

def sign_in(user)
  visit signin_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end

def fill_update 
  	fill_in "Name",             with: new_name
  	fill_in "Email",            with: new_email
	fill_in "Password",         with: user.password
	fill_in "Confirm Password", with: user.password
	click_button "Save changes"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-success', text: message)
  end
end

RSpec::Matchers.define :have_h1 do |message|
  match do |page|
    page.should have_selector('h1', text: message)
  end
end

RSpec::Matchers.define :have_title do |message|
  match do |page|
    page.should have_selector('title', text: message)
  end
end

RSpec::Matchers.define :have_profil_link do |message|
  match do |page|
    page.should have_link('Profile', text: message)
  end
end

RSpec::Matchers.define :have_settings_link do |message|
  match do |page|
    page.should have_link('Settings', text: message)
  end
end

RSpec::Matchers.define :have_signin_link do |message|
  match do |page|
    page.should have_link('Sign in', text: message)
  end
end

RSpec::Matchers.define :have_signout_link do |message|
  match do |page|
    page.should have_link('Sign out', text: message)
  end
end

RSpec::Matchers.define :have_signup_link do |message|
  match do |page|
    page.should have_link('Sign up', text: message)
  end
end



