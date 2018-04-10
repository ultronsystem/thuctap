module UsersHelper
  include LoginsHelper
  def gravatar_for user, options = {size: 200}
    gravatar_id = Digest::MD5.hexdigest user.email.downcase
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.fullname, class: "gravatar")
  end

  def load_user_book user_id, book_id
    user_book = UserBook.find_by user_id: user_id, book_id: book_id
  end
end
