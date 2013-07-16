# require 'spec_helper'

# describe "Static pages" do

  # describe "Home page" do

  #   it "should have the h1 'Sample App'" do
  #     visit '/static_pages/home'
  #     page.should have_selector('h1', :text => 'Sample App')
  #   end

  #   it "should have the base title" do
  #     visit '/static_pages/home'
  #     page.should have_selector('title',
  #                       :text => "Ruby on Rails Tutorial Sample App")
  #   end

  #   it "should not have a custom page title" do
  #     visit '/static_pages/home'
  #     page.should_not have_selector('title', :text => '| Home')
  #   end
  # end

  # describe "Help page" do

  #   it "should have the h1 'Help'" do
  #     visit '/static_pages/help'
  #     page.should have_selector('h1', :text => 'Help')
  #   end

  #   it "should have the base title" do
  #     visit '/static_pages/help'
  #     page.should have_selector('title',
  #                       :text => "Ruby on Rails Tutorial Sample App")
  #   end

  #     it "should not have a custom page title" do
  #     visit '/static_pages/help'
  #     page.should_not have_selector('title', :text => '| Help')
  #   end
  # end

  # describe "About page" do

  #   it "should have the h1 'About Us'" do
  #     visit '/static_pages/about'
  #     page.should have_selector('h1', :text => 'About Us')
  #   end

  #   it "should have the base title" do
  #     visit '/static_pages/about'
  #     page.should have_selector('title',
  #                     :text => "Ruby on Rails Tutorial Sample App")
  #   end
  #     it "should not have a custom page title" do
  #     visit '/static_pages/about'
  #     page.should_not have_selector('title', :text => '| About Us')
  #   end
  # end

  # describe "Contact page" do

  #   it "should have the h1 'Contact'" do
  #     visit '/static_pages/contact'
  #     page.should have_selector('h1', :text => 'Contact')
  #   end
  #   it "should have the base title" do
  #     visit '/static_pages/contact'
  #     page.should have_selector('title', 
  #                     :text => "Ruby on Rails Tutorial Sample App | Contact")
  #   end
  # end

# Tests for routes
require 'spec_helper'

describe "Static pages" do
  subject{page}

  describe "Home page" do              # Tests for Home page
    before {visit root_path}

      it {should have_selector('h1', text: 'Sample App') }
      it {should have_selector('title',text: full_title(''))}
      it {should_not have_selector 'title', text: '| Home' }
    end
  

  describe "Help page" do              # Tests for Help page
     before { visit help_path }

    it { should have_selector('h1',    text: 'Help') }
    it { should have_selector('title', text: full_title('Help')) }
  end

  describe "About page" do             # Tests for About page
  before { visit about_path }

    it { should have_selector('h1',    text: 'About') }
    it { should have_selector('title', text: full_title('About Us')) }
  end

  describe "Contact page" do           # Test for Contact page
    before {visit contact_path}

    it { should have_selector('h1',    text: 'Contact') }
    it { should have_selector('title', text: full_title('Contact')) }
  end
end