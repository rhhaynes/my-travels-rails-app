class LogSerializer < ActiveModel::Serializer
  attributes :title, :content, :created_at
end
