xml.instruct!
xml.shop do
  xml << render(partial: 'api/v1/backup/shop.xml',
                locals: { shop: @shop })
end # xml.shop
