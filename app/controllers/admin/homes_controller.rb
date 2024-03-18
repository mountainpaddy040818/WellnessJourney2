class Admin::HomesController < ApplicationController
  #before_action :authenticate_admin!

  def top
    # レコード一覧情報取得
    @health_records = HealthRecord.all
    # レコードコメント一覧取得
    @health_record_comments = HealthRecordComment.all
    # ユーザー一覧取得
    @users = User.all
  end
  
end
