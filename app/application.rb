class Application

  @@items = []

    def call(env)
      resp = Rack::Response.new
      req = Rack::Request.new(env)

      if req.path.match(/items/)
        item = req.path.split('/')[2]
        if @@items.find {|i| i.name == item}
          value = @@items.find {|i| i.name == item}.price
          resp.write value
        else
          resp.write "Item not found"
          resp.status = 400
          end
        elsif !req.path.match(/items/)
          resp.write "Route not found"
          resp.status = 404
      end



      resp.finish
    end

end


# it 'Returns item price if it is in @@item' do
#   Application.class_variable_set(:@@items, [Item.new("Figs",3.42),Item.new("Pears",0.99)])
#   get '/items/Figs'
#   expect(last_response.body).to include("3.42")
#   expect(last_response.status).to be(200)
# end
#
# it 'Returns an error and 400 if the item is not there' do
#   Application.class_variable_set(:@@items, [Item.new("Figs",3.42),Item.new("Pears",0.99)])
#   get '/items/Apples'
#   expect(last_response.body).to include("Item not found")
#   expect(last_response.status).to be(400)
# end
