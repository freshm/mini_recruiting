FactoryGirl.define do
   factory :admin do |f|
      f.sequence(:email) { |n| "fooadmin#{n}@example.com" }
      f.firstname "Admin"
      f.lastname "Woot"
      f.password "testpass"
      f.password_confirmation "testpass"


   end

   factory :applicant do |f|
      f.sequence(:email) { |n| "fooapplicant#{n}@example.com" }
      f.firstname "Someone"
      f.lastname "What"
      f.password "testpass"
      f.password_confirmation "testpass"
   end

   factory :moderator do |f|
      f.sequence(:email) { |n| "foomoderator#{n}@moderator.com" }
      f.firstname "SomeoneM"
      f.lastname "Here"
      f.password "testpass"
      f.password_confirmation "testpass"
      f.type "Moderator"
   end

   factory :user do |f|
      f.sequence(:email) { |n| "fooa#{n}@example.com" }
      f.firstname "User"
      f.lastname "What"
      f.password "testpass"
      f.password_confirmation "testpass"
   end

   factory :vacancy do |g|
      admin
      g.title "Something"
      g.description "Somesometing"
      g.requirement "Woot"
      g.location "Nowhere"
      g.duties "Go nowhere"
   end
   
   factory :job_application do |f|
      user
      vacancy
      f.salary 12.0
      f.note "I'm a dummy note"
   end

   factory :job_assignment do |f|
      moderator
      job_application
   end
end
