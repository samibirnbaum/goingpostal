require "random_data" #requires a separate file of ruby code - often a class

50.times do
    Post.create!(
        title: RandomData.random_sentence, #use these methods on the class to create strings for our attributes
        body: RandomData.random_paragraph
    )
end

posts = Post.all #retrieves every post object from the db and stores it in variable called posts - returns array

100.times do
    Comment.create!(
        post: posts.sample, #array method to pick out random element, in this case a post object
        body: RandomData.random_paragraph
    )
end

50.times do
    Question.create!(
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph,
        resolved: false
    )
end

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Question.count} questions created"