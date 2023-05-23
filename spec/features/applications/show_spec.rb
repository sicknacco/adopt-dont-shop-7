require 'rails_helper'

RSpec.describe "Application Show Page", type: :feature do
  before(:each) do
    test_data
  end

  describe "Application Show Page /applications/:id" do
    describe "I can see the following:" do
      it "can show applicant name and other attributes" do
        visit "/applications/#{@application_1.id}"

        expect(page).to have_content("Applicant Name: #{@application_1.name}")
        expect(page).to have_content("Street Address: #{@application_1.street_address}")
        expect(page).to have_content("City: #{@application_1.city}")
        expect(page).to have_content("State: #{@application_1.state}")
        expect(page).to have_content("Zip Code: #{@application_1.zip_code}")
        expect(page).to have_content("Description: #{@application_1.description}")
        expect(page).to have_content("Status: #{@application_1.status}")

        visit "/applications/#{@application_2.id}"

        expect(page).to have_content("Applicant Name: #{@application_2.name}")
        expect(page).to have_content("Street Address: #{@application_2.street_address}")
        expect(page).to have_content("City: #{@application_2.city}")
        expect(page).to have_content("State: #{@application_2.state}")
        expect(page).to have_content("Zip Code: #{@application_2.zip_code}")
        expect(page).to have_content("Description: #{@application_2.description}")
        expect(page).to have_content("Status: #{@application_2.status}")
      end

      it "each pet name is a link to their show page" do
        visit "/applications/#{@application_1.id}"
        click_link("#{@pet_2.name}")
        expect(current_path).to eq("/pets/#{@pet_2.id}")

        visit "/applications/#{@application_2.id}"
        click_link("#{@pet_1.name}")
        expect(current_path).to eq("/pets/#{@pet_1.id}")

        visit "/applications/#{@application_3.id}"
        click_link("#{@pet_5.name}")
        expect(current_path).to eq("/pets/#{@pet_5.id}")
      end
    end

    describe "Searching for Pets for an Application" do
      it "has a search function on page to 'Add a Pet to this Application'" do
        visit "/applications/#{@application_1.id}"

        within "#pet_search" do
          expect(page).to have_content("Add a Pet to this Application")
          expect(page).to have_field("Search Pet")

          fill_in("Search Pet", with: "Pepper")
          click_button("Search")

          expect(current_path).to eq("/applications/#{@application_1.id}")
        end
        expect(page).to have_content("#{@pet_5.name}")

        visit "/applications/#{@application_2.id}"
        within "#pet_search" do
          expect(page).to have_content("Add a Pet to this Application")
          expect(page).to have_field("Search Pet")

          fill_in("Search Pet", with: "Marshall")
          click_button("Search")

          expect(current_path).to eq("/applications/#{@application_2.id}")
        end
        expect(page).to have_content("#{@pet_4.name}")
      end
    end

    describe "Adding pet to application after search" do
      it "can add a pet to an application" do
        visit "/applications/#{@application_1.id}"
        fill_in("Search Pet", with: "Pepper")
        click_button("Search")

        expect(page).to have_content(@pet_5.name)
        expect(page).to have_button("Adopt This Pet")

        click_button("Adopt This Pet")

        expect(current_path).to eq("/applications/#{@application_1.id}")
        expect(page).to have_content(@pet_5.name)
        expect(page).to_not have_button("Adopt This Pet")
      end
    end

    describe "Submitting an Application" do
      it "can enter description on why they would be a good owner and submit" do
        visit "/applications/#{@application_1.id}"

        fill_in("Search Pet", with: "Pepper")
        click_button("Search")
        click_button("Adopt This Pet")

        expect(page).to have_content(@pet_5.name)
        expect(page).to have_button("Submit Application")
        expect(page).to have_field("Description")

        fill_in("Description", with: "Taxidermy Project")
        click_button("Submit Application")
        expect(current_path).to eq("/applications/#{@application_1.id}")
        expect(page).to have_content("Taxidermy Project")
        expect(page).to have_content("Pending")
        expect(page).to_not have_button("Submit Application")
      end
    end

    describe "Search pet render form" do
      it "renders search_pet pertial until application is submitted" do
        visit "/applications/#{@application_1.id}"
        fill_in("Search Pet", with: "Pepper")
        click_button("Search")
        click_button("Adopt This Pet")
        fill_in("Description", with: "Taxidermy Project")
        click_button("Submit Application")

        expect(page).to_not have_field("Search Pet")
        expect(page).to_not have_button("Search")
        expect(page).to_not have_button("Submit Application")
      end
    end

    describe "Partial Matches for Pet Names" do
      it "can find pets based on a partial search" do
        visit "applications/#{@application_6.id}"
        fill_in("Search Pet", with: "Marsh")
        click_button("Search")

        expect(page).to have_content("Marshall")

        fill_in("Search Pet", with: "Be")
        click_button("Search")

        expect(page).to have_content("Beethoven")
      end
    end

    describe "Case Insensitive Matches for Pet Names" do
      it "can find pets regardless of case" do
        visit "applications/#{@application_6.id}"
        fill_in("Search Pet", with: "mArS")
        click_button("Search")

        expect(page).to have_content("Marshall")

        fill_in("Search Pet", with: "BeeTH")
        click_button("Search")

        expect(page).to have_content("Beethoven")
      end
    end

    describe "Has to have a description" do
      it "throws an error to user that field must be filled out" do
        visit "applications/#{@application_1.id}"

        click_button("Submit Application")

        expect(current_path).to eq("/applications/#{@application_1.id}")
        expect(page).to have_content("Yo, fill the field please")
      end
    end
  end
end