FactoryBot.define do
  factory :company do
    sequence(:email) { |n| "contact@company#{n}.com" }
    password { "supersecretpassword" }
  end
end
