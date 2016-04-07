class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings

  scope :visible_to, -> (user) {user ? all : Topic.public_viewable}

  scope :public_viewable, -> {where(public: true)}

  scope :private_viewable, -> {where(public:false)}
end
