module Sinatra
  module Sinatrapi
    module Routing
      module Users

        def self.registered(app)
          show_users = lambda do
            content_type :json

            coll = settings.mongo_db['users']
            puts coll.find.each { |doc| puts doc.inspect }
            #
            # users = coll.find.to_a.to_json
            # users = [
            #   {
            #     name: "Joe"
            #   },
            #   {
            #     name: "Bob"
            #   },
            #   {
            #     name: "Sam"
            #   }
            # ]

            ActiveSupport::JSON.encode(coll.find.to_a)
          end

          app.get  '/users', &show_users
        end

      end
    end
  end
end
