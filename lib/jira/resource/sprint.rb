module JIRA
  module Resource

    class SprintFactory < JIRA::BaseFactory # :nodoc:
    end

    class Sprint < JIRA::Base
      
      def self.id_attribute
        attrs[:id]
      end

      # Returns all the issues for this project
      def issues
        response = client.get(client.options[:rest_base_path] + "/search?jql=sprint%3D#{attrs[:id]}")
        json = self.class.parse_json(response.body)
        json['issues'].map do |issue|
          client.Issue.build(issue)
        end
      end
      

      
      
    end

  end
end
