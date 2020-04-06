# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validate :email_validator
  has_secure_password

  has_many :orders
  has_many :items, through: :orders
  has_many :comments
  has_many :commented_items, through: :comments, source: 'item'

  def email_validator
    errors.add(:email, "#{email} is not a valid Email") unless EmailAddress.valid? email
  end

  def last_orders
    orders.order('created_at desc')
  end
end