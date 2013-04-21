module JIRA
  module Resource

    class PriorityFactory < JIRA::BaseFactory # :nodoc:
    end

    class Priority < JIRA::Base
      def self.id_attribute
        attrs[:id]
      end
    
      def self.all(client)
        response = client.get("/rest/api/2/priority")
        json = parse_json(response.body)
        json.each do |priority|
          client.Priority.build(priority)
        end
      end
        
    end

  end
end
