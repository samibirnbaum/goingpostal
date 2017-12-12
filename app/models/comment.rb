class Comment < ApplicationRecord
  #@body
  #@post_id
  belongs_to :post    #ARMethod-this model/data belongs to (has close relationship with) post model/data takes a post_id
end
