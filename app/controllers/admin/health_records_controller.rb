class Admin::HealthRecordsController < ApplicationController
  before_action :authenticate_admin!
end
