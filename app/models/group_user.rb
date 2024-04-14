# frozen_string_literal: true

class GroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :group
end
