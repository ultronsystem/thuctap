module BuyRequestsHelper
  def load_status status
    result = []
    if status == Settings.request_waiting
      result << (content_tag :td do
        Settings.request_waiting_in_words
      end)
    elsif stats == Settings.request_success
      result << (content_tag :td do
        Settings.request_success_in_words
      end)
    else
      result << (content_tag :td do
        Settings.request_cancel_in_words
      end)
    end
    safe_join result
  end
end
