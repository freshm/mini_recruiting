FactoryGirl.define do
   factory :admin do |f|
      f.sequence(:email) { |n| "foo#{n}@example.com" }
      f.firstname "Admin"
      f.lastname "Woot"
      f.password "testpass"
      f.password_confirmation "testpass"


   end

   factory :applicant do |f|
      f.sequence(:email) { |n| "fooa#{n}@example.com" }
      f.firstname "Applicant"
      f.lastname "What"
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
   
   factory :job_application do |f|
      applicant
      advertisement
      f.wage 12.0
      f.note "I'm a dummy note"
   end
end
