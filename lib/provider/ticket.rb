module TicketMaster::Provider
  module Jira
    # Ticket class for ticketmaster-jira
    #
    
    class Ticket < TicketMaster::Provider::Base::Ticket
      #API = Jira::Ticket # The class to access the api's tickets
      # declare needed overloaded methods here
      def initialize(*object)
        if object.first
          object = object.first
          unless object.is_a? Hash
            @system_data = {:client => object}
            hash = {:id => object.id.to_i, 
              :key => object.key,
              :status => object.status,
              :priority => object.priority,
              :title => object.summary,
              :resolution => object.resolution,
              :created_at => object.created,
              :updated_at => object.updated,
              :description => object.description,
              :assignee => object.assignee,
              :requestor => object.reporter}
          else
            hash = object
          end
          super(hash)
        end
      end

      def id
        self[:id].to_i
      end

      def updated_at
        normalize_datetime(self[:updated_at])
      end

      def created_at
        normalize_datetime(self[:created_at])
      end

      def self.find_by_attributes(project_id, attributes = {})
        search_by_attribute(self.find_all(project_id), attributes)
      end

      def self.find_by_id(project_id, id)
        if id.kind_of?(String)
          $jira.getIssue(id)
        else
          self.find_all(project_id).select { |ticket| ticket.id == id }.first
        end
      end

      def self.find_all_with_query(project_id, query)
        $jira.getIssuesFromJqlSearch("project = #{project_id} and summary ~ #{query} and description ~ #{query}", 200).map do |ticket|
          self.new ticket
        end
      end

      def self.find_all(project_id)
        $jira.getIssuesFromJqlSearch("project = #{project_id}", 200).map do |ticket|
          self.new ticket
        end
      end

      def comments(*options)
        Comment.find(self.id, options)
      end

      def comment(*options)
        nil
      end
      
      def self.create(*options)
        attributes = options.first
        
        issue = Jira4R::V2::RemoteIssue.new
        issue.summary = attributes[:title]
        issue.description = attributes[:description]
        issue.project = attributes[:project_key]
        issue.priority = attributes[:priority] if attributes[:priority].present?
        
        if attributes[:components].present?
          components = Jira4R::V2::ArrayOf_tns1_RemoteComponent.new 
          attributes[:components].each do |id|
            component = Jira4R::V2::RemoteComponent.new(id)
            components.push(component)
          end
          issue.components = components
        end
        
        issue.type = "1"
        result = $jira.createIssue(issue)
        
        return nil if result.nil? or result.id.nil?
        return result
      end
      
      private
      def normalize_datetime(datetime)
        Time.mktime(datetime.year, datetime.month, datetime.day, datetime.hour, datetime.min, datetime.sec)
      end

   end

  end
end
