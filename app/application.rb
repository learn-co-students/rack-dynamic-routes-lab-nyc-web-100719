require 'pry'

class Application
     
    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        file_path = req.path.split("/")[1]
        searched_item = req.path.split("/")[2]

        if file_path=="items"
            if @@items.empty?
                resp.write "There are no items"
                resp.status = 400
            else
                match = @@items.select do |item|
                    item.name == searched_item
                end
                if match.empty?
                    resp.write "Item not found"
                    resp.status = 400
                else
                    resp.write "#{match.first.price}"
                    resp.status = 200
                end
            end
        else
            resp.write "Route not found"
            resp.status = 404
        end
   
        resp.finish
    end
end