class Application

    @@items = [Item.new("Apples", 3.00), Item.new("Oranges", 2.00)]

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            item_name = req.path.split("/items/").last #i think in this line the request would be for example items/bananas and so code is accessing the word bananas
            
            if item = @@items.find{|i|i.name == item_name}
                resp.write item.price
            else 
                resp.status = 400
                resp.write "Item not found"
            end 
        else 
            resp.status = 404
            resp.write "Route not found"
        end 
        resp.finish
    end 

end #end of class 
