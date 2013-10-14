FactoryGirl.define do
   factory :admin do |f|
      f.sequence(:email) { |n| "foo#{n}@example.com" }
      f.firstname "What"
      f.lastname "Woot"
      f.password "testpass"
      f.password_confirmation "testpass"


   end

   factory :applicant do |f|
      f.sequence(:email) { |n| "foo#{n}@example.com" }
      f.firstname "What"
      f.lastname "Woot"
      f.password "testpass"
      f.password_confirmation "testpass"
   end

   factory :advertisement do |g|
      admin
      g.title "Something"
      g.description "Somesometing"
      g.requirement "Woot"
      g.location "Nowhere"

         #:description, :location, :requirement, :title, :admin_id
   end
end
