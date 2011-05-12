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
            hash = {:id => object.id, 
              :status => object.status,
              :priority => object.priority,
              :title => object.summary,
              :resolution => object.resolution,
              :created_at => object.created,
              :update_at => object.updated,
              :description => object.description,
              :assignee => object.assignee,
              :requestor => object.reporter}
          else
            hash = object
          end
          super(hash)
        end
      end

      def self.find_by_attributes(project_id, attributes = {})
        search_by_attribute(self.find_all(project_id), attributes)
      end

      def self.find_by_id(project_id, id)
        self.find_all(project_id).select { |ticket| ticket.id == id }.first
      end

      def self.find_all(project_id)
        $jira.getIssuesFromTextSearchWithProject("project = #{project_id}", 25).map do |ticket|
          self.new ticket
        end
      end

   end

  end
end
