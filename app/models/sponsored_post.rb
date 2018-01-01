class SponsoredPost < ApplicationRecord
  #@title
  #@body
  #@price
  #@topic_id
  belongs_to :topic
end
