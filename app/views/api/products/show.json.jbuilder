json.product do

    json.name @product.name
    json.description @product.description
    json.quantity @product.quantity
    json.price @product.price
    json.category @product.category
    if(@product.image.attached?)
        json.image rails_blob_url(@product.image)
    end
end

json.message @message
json.success true