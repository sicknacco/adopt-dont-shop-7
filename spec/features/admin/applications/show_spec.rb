require "rails_helper"

RSpec.describe "Admin Application Show Page", type: :feature do
  before(:each) do
    admin_test_data
  end

  describe "Approving a Pet for an Application" do
    describe "I see every pet that the app is for and buttons to approve each pet" do
      it "can approve a pet for a specific application" do
        visit("admin/applications/#{@application_1.id}")
        expect(page).to have_content("Pending Pets:")
        expect(page).to have_content("#{@pet_2.name}")
        expect(page).to have_content("#{@pet_4.name}")

        expect(page).to have_button("Approve #{@pet_2.name}")
        expect(page).to have_button("Approve #{@pet_4.name}")
        
        click_button("Approve #{@pet_2.name}")
        
        expect(current_path).to eq("/admin/applications/#{@application_1.id}")
        expect(page).to_not have_button("Approve #{@pet_2.name}")
        expect(page).to have_content("Pet Status: Approved")
        expect(page).to have_button("Approve #{@pet_4.name}")
      end
    end
  end

  describe "Denying a Pet for an Application" do
    describe "I see every pet that the app is for and buttons to deny each pet" do
      it "can deny a pet for a specific application" do
        visit("admin/applications/#{@application_1.id}")
        expect(page).to have_content("Pending Pets:")
        expect(page).to have_content("#{@pet_2.name}")
        expect(page).to have_content("#{@pet_4.name}")

        expect(page).to have_button("Deny #{@pet_2.name}")
        expect(page).to have_button("Deny #{@pet_4.name}")
        
        click_button("Deny #{@pet_2.name}")
        
        expect(current_path).to eq("/admin/applications/#{@application_1.id}")
        expect(page).to_not have_button("Deny #{@pet_2.name}")
        expect(page).to have_content("Pet Status: Denied")
        expect(page).to have_button("Deny #{@pet_4.name}")
      end
    end
  end
end