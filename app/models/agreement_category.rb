# == Schema Information
#
# Table name: agreement_categories
#
#  id           :integer          not null, primary key
#  title        :string
#  pro_title    :string
#  client_title :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class AgreementCategory < ActiveRecord::Base

  has_many :user_agreements

  validates :title, :pro_title, :client_title, presence: true

end
