module TicketMaster::Provider
  module Jira
    # Project class for ticketmaster-jira
    #
    #
    class Project < TicketMaster::Provider::Base::Project
      #API = Jira::Project # The class to access the api's projects
      # declare needed overloaded methods here
      # copy from this.copy(that) copies that into this
      def initialize(*object)
        if object.first
          object = object.first
          unless object.is_a? Hash
            @system_data = {:client => object}
            hash = {:id => object.id.to_i, 
                    :name => object.name,
                    :description => object.description}
          else
            hash = object
          end
          super(hash)
        end
      end

      def copy(project)
        project.tickets.each do |ticket|
          copy_ticket = self.ticket!(:title => ticket.title, :description => ticket.description)
          ticket.comments.each do |comment|
            copy_ticket.comment!(:body => comment.body)
            sleep 1
          end
        end
      end

      def self.find(*options)
        jira_projects = self.find_all
        if options.first.is_a? Array
          jira_projects.select do |project| 
            project if options.first.any? { |id| project.id == id }
          end
        elsif options.first.is_a? Hash
          find_by_attributes(options.first)
        else
          jira_projects
        end
      end

      def self.find_by_attributes(attributes = {})
        search_by_attribute(self.find_all, attributes)
      end

      def self.find_all
        $jira.getProjectsNoSchemes().map { |project| Project.new project }
      end

      def self.find_by_id(id)
        self.find_all.select { |project| project.id == id }.first
      end

    end
  end
end


