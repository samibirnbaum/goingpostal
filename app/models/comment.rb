class Comment < ApplicationRecord
  belongs_to :post    #this model/data belongs to (has close relationship with) post model/data takes a post_id
end
