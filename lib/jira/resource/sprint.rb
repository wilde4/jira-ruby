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
        response = client.get(client.options[:rest_base_path] + "/search?maxResults=200&jql=sprint%3D#{attrs[:id]}")
        json = self.class.parse_json(response.body)
        json['issues'].map do |issue|
          client.Issue.build(issue)
        end
      end
      
      def dates(rapidboard_id)
        response = client.get("/rest/greenhopper/1.0/rapid/charts/sprintreport?rapidViewId=#{rapidboard_id}&sprintId=#{attrs[:id]}")
        json = self.class.parse_json(response.body)
        start_date = DateTime.parse(json['sprint']['startDate']) rescue nil
        end_date = DateTime.parse(json['sprint']['endDate']) rescue nil
        complete_date = DateTime.parse(json['sprint']['completeDate']) rescue nil
        return {:start_date => start_date, :end_date => end_date, :complete_date => complete_date}
      end


    end

  end
end
