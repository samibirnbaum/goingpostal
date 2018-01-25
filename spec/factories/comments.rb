FactoryGirl.define do
    factory :comment do
        body RandomData.random_paragraph
        user #create associations in rspec file
        post #create associations in rspec file
    end
end