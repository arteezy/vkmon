class VK
  include HTTParty
  base_uri 'https://api.vk.com/method'
  default_params v: '5.58'

  def initialize(user_id)
    @options = { user_id: user_id }
  end

  def friends(method = :friends, order = :id, lang = 0)
    fields = %w(nickname sex bdate city country photo_50 photo_200_orig
                domain contacts education universities online relation
                has_mobile last_seen status)
    query = @options.merge(order: order, lang: lang, fields: fields.join(','))
    self.class.get("/#{method}.get", query: query)
  end
end
