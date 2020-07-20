json.purchase do
  json.id @purchase.id
  json.content_id @purchase.content_id
  json.content_type @purchase.content_type
  json.quality @purchase.quality
  json.price @purchase.price
  json.available_until @purchase.available_until.to_i
  json.created_at @purchase.created_at.to_i
end