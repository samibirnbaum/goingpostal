FactoryGirl.define do
    factory :post do
        title RandomData.random_sentence
        body RandomData.random_paragraph
        rank 0.0 #float data type
        user #automatically associated with user factory
        topic #automatically associated with topic factory
    end
end