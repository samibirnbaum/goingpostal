FactoryGirl.define do
    pw = RandomData.random_sentence
    factory :user do    #this factory builds user objects for us
        name RandomData.random_name #maintains this name for every build
        sequence(:email){|n| "user#{n}@factory.com" } #changes this with every build
        password pw
        password_confirmation pw
        role :member
    end
end