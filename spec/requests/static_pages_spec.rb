require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end 

  describe "Home page" do
    before { visit root_path }
    let(:heading) { 'Abi Singing' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it { should_not have_selector 'title', text: '| Home' }
  end

  describe "Help page" do
    before { visit help_path }
    let(:heading) { 'Help' }
    let(:page_title) { 'Help' }

    it_should_behave_like "all static pages"  
  end

  describe "About page" do
    before { visit about_path }

    let(:heading) { 'About' }
    let(:page_title) { 'About' }

    it_should_behave_like "all static pages" 
  end

  describe "Contact page" do
    before { visit contact_path }

    let(:heading) { 'Contact Me' }
    let(:page_title) { 'Contact Me' }

    it_should_behave_like "all static pages" 
  end 

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About')
    click_link "Contact"
    page.should have_selector 'title', text: full_title('Contact Me')
    click_link "Home"
    page.should_not have_selector 'title', text: full_title('| Home')
    click_link "abi singing"
    page.should_not have_selector 'title', text: full_title('| Home')
    click_link "What to expect?"
    page.should have_selector 'title', text: full_title('Expectations')
    click_link "Never too late"
    page.should have_selector 'title', text: full_title('Never too late')
    click_link "Fees"
    page.should have_selector 'title', text: full_title('Fees')
    click_link "Singing Clinics"
    page.should have_selector 'title', text: full_title('Singing Clinics')
    click_link "Theory"
    page.should have_selector 'title', text: full_title('Theory lessons')
  end
end