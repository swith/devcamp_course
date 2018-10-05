class Blog < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  enum status: { draft: 0, published: 1 }
  scope :recent, -> { order('created_at ASC') }
  validates_presence_of :title, :body, :topic_id
  belongs_to :topic

  has_many :comments, dependent: :destroy

end
