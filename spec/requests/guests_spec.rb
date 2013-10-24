require 'spec_helper'

describe "Guests" do
   describe "click an vacancy" do
      it "can apply for it and sign up." do
      	vacancy = FactoryGirl.create(:vacancy)

      	visit root_url

      	page.should have_content(vacancy.title)
      	page.should have_content(vacancy.location)

      	click_link vacancy.title

      	assert_equal vacancy_url(vacancy), current_url

      	click_link "Apply now"

      	page.should have_content("Firstname")
      	page.should have_content("Lastname")
      	page.should have_content("Email")
      	page.should have_content("Password")
      	page.should have_content("Password confirmation")

      	page.should have_content("Salary")
      	page.should have_content("Note")


      	fill_in "Firstname", with: "New"
      	fill_in "Lastname", with: "Here"
      	fill_in "Email", with: "new@here.com"
      	fill_in "Password*", with: "testpass", exact: true
      	fill_in "Password confirmation", with: "testpass", exact: true
      	fill_in "Salary", with: 12.0
      	fill_in "Note", with: "Some lore ipsum text here."

      	click_button "Sign up and create job application"

      	assert_equal current_url, root_url

      	page.should have_content("Welcome! You have signed up and applied successfully for this vacancy.")
         User.last.job_applications.all.count.should == 1
      end

      it "can apply for it and sign up but creates no job application if the vacancy was deleted before." do
         vacancy = FactoryGirl.create(:vacancy)

         visit root_url

         page.should have_content(vacancy.title)
         page.should have_content(vacancy.location)

         click_link vacancy.title

         assert_equal vacancy_url(vacancy), current_url

         click_link "Apply now"

         vacancy.delete

         page.should have_content("Firstname")
         page.should have_content("Lastname")
         page.should have_content("Email")
         page.should have_content("Password")
         page.should have_content("Password confirmation")

         page.should have_content("Salary")
         page.should have_content("Note")


         fill_in "Firstname", with: "New"
         fill_in "Lastname", with: "Here"
         fill_in "Email", with: "new@here.com"
         fill_in "Password*", with: "testpass", exact: true
         fill_in "Password confirmation", with: "testpass", exact: true
         fill_in "Salary", with: 12.0
         fill_in "Note", with: "Some lore ipsum text here."

         click_button "Sign up and create job application"

         assert_equal current_url, root_url

         page.should have_content("Welcome! You have signed up but your application could not be proccessed.")
         User.last.job_applications.all.count.should == 0
      end
   end
end
