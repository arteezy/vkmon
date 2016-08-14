class VK
  include HTTParty
  base_uri 'https://api.vk.com/method'
  default_params v: '5.60', lang: 0, https: 1

  def initialize(user_id)
    @options = { user_id: user_id, user_ids: user_id }
  end

  def users(name_case = :nom)
    fields = %w(domain nickname sex photo_50 photo_200_orig)
    query = @options.except(:user_id).merge(name_case: name_case, fields: fields.join(','))
    self.class.get('/users.get', query: query).deep_symbolize_keys
  end

  def friends(order = :id)
    fields = %w(nickname sex bdate city country photo_50 photo_200_orig
                domain contacts education universities online relation
                has_mobile last_seen status)
    query = @options.except(:user_ids).merge(order: order, fields: fields.join(','))
    self.class.get('/friends.get', query: query).deep_symbolize_keys
  end
end
