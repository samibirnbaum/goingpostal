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

unique_post = Post.find_or_create_by!(title: "the indempotent post", body: "no matter how many times this code runs the first run and only that run happens")
Comment.find_or_create_by!(post: unique_post, body: "an idempotent comment for the indepotent post")

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"