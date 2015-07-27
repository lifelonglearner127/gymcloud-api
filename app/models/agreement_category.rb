class AgreementCategory < ActiveRecord::Base
  belongs_to :user_agreement

  validates :title, :pro_title, :client_title, presence: true
end
