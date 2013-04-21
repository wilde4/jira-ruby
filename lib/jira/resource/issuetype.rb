module JIRA
  module Resource

    class IssuetypeFactory < JIRA::BaseFactory # :nodoc:
    end

    class Issuetype < JIRA::Base
      
      def self.id_attribute
        attrs[:id]
      end
    
      def self.all(client)
        response = client.get("/rest/api/2/issuetype")
        json = parse_json(response.body)
        json.each do |issue_type|
          client.Issuetype.build(issue_type)
        end
      end
        
    end

  end
end
