module JIRA
  module Resource

    class RapidboardFactory < JIRA::BaseFactory # :nodoc:
    end

    class Rapidboard < JIRA::Base

      def self.key_attribute
        :key
      end

      def self.all(client)
        response = client.get("/rest/greenhopper/1.0/rapidview")
        json = parse_json(response.body)
        json['views'].map do |view|
          client.Rapidboard.build(view)
        end
      end

    end

  end
end
