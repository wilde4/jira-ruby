module JIRA
  module Resource

    class RapidboardFactory < JIRA::BaseFactory # :nodoc:
    end

    class Rapidboard < JIRA::Base

      def self.id_attribute
        attrs[:id]
      end
    

      def self.all(client)
        response = client.get("/rest/greenhopper/1.0/rapidview")
        json = parse_json(response.body)
        json['views'].map do |view|
          client.Rapidboard.build(view)
        end
      end

      def sprints
        # https://nidigitalsolutions.jira.com/rest/greenhopper/1.0/sprints/237
        response = client.get("/rest/greenhopper/1.0/sprints/#{attrs[:id]}")
        json = self.class.parse_json(response.body)
        json['sprints'].map do |sprint|
          client.Sprint.build(sprint)
        end
      end
      
      


    end

  end
end
