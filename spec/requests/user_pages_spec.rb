require 'spec_helper'

describe "User Pages" do
  subject { page }

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }

    before(:all)  { 30.times { FactoryGirl.create(:user) } }
    after(:all)   { User.delete_all }

    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_h1('All users') }

    describe "pagination" do
      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1) do |user|
          page.should have_selector('li', text: user.name)
        end
      end
    end

    describe "delete links" do
      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete' , href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('delete').to change('User',:count).by(-1) }
        end
        it { should_not have_link('delete', href: user_path(:admin)) }
      end
    end
  end
  describe "signup page" do
    before { visit signup_path }

    it { should have_h1('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe "signup" do
    before { visit signup_path }

    let(:submit) { "Create my account" }
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button "Create my account" }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        let(:user) { User.find_by_email('user@example.com') }

        it { should have_title("Sign up") }
        it { should have_content('error') }
        
      end
    end

    describe "with valid information" do
      before { valid_signup }

      it "should create a user" do
        expect { click_button "Create my account" }.to change(User, :count).by(1)
      end

      describe "after submission" do
        before { click_button submit }

        let(:user) { User.find_by_email('user@example.com') }

        it { should have_title(user.name) }
        it { should have_success_message('Welcome') }
        
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('user@example.com') }

        it { should have_title(user.name) }
        it { should have_success_message('Welcome') }
        it { should have_signout_link }
      end
    end
  end

  describe "profile page" do
  	#code to make a user variable
  	let(:user) { FactoryGirl.create(:user) }
  	
  	before { visit user_path(user) }

  	it { should have_h1(user.name) }
  	it { should have_title(user.name) }
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_h1("Update your profile") }
      it { should have_title("Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "new@example.com"}

      before { fill_update }


      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_signout_link(signout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end
  end
end
