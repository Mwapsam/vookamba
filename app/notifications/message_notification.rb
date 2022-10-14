class MessageNotification < Noticed::Base
  deliver_by :database

  param :message

  def message
    params[:message].content
  end
  
  def url
    message_path(params[:message])
  end
end