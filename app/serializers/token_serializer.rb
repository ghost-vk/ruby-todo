class TokenSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :refresh_token
end
