module JIRA
  module Resource

    class ProjectFactory < JIRA::BaseFactory # :nodoc:
    end

    class Project < JIRA::Base

      has_one :lead, :class => JIRA::Resource::User
      has_many :components
      has_many :issuetypes, :attribute_key => 'issueTypes'
      has_many :versions

      def self.key_attribute
        :key
      end

      # Returns all the issues for this project
      def issues
        project_id = key rescue attrs[:key]
        response = client.get(client.options[:rest_base_path] + "/search?maxResults=50&jql=project%3D'#{project_id}'")
        json = self.class.parse_json(response.body)
        json['issues'].map do |issue|
          client.Issue.build(issue)
        end
      end
      
      # Returns all the issues for this project
      def bugs
        project_id = key rescue attrs[:key]
        
        # Establish which issue types are bugs
        ids = IssueType.where(:bug => true).map{|i| "type%3D#{i.issue_type_id}"}.join("+OR+")
        filter_by_bug = "(#{ids})%26"
        filter_by_resolution = "(resolution!%3D'fixed'+OR+resolution!%3D'done')%26"
        
        response = client.get(client.options[:rest_base_path] + "/search?maxResults=300&jql=#{filter_by_bug}#{filter_by_resolution}project%3D'#{project_id}'")
        json = self.class.parse_json(response.body)
        json['issues'].map do |issue|
          client.Issue.build(issue)
        end
      end

    end

  end
end
