class AgreementCategory < ActiveRecord::Base

  has_many :user_agreements

  validates :title, :pro_title, :client_title, presence: true

end
