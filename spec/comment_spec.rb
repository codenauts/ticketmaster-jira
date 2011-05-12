require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "TicketMaster::Provider::Jira::Comment" do
  before(:each) do
    @url = "some_url"
    @fj = FakeJiraTool.new
    @project_jira = Struct.new(:id, :name, :description).new(1, 'project', 'project description')
    @ticket = Struct.new(:id, 
                         :status, 
                         :priority, 
                         :summary, 
                         :resolution, 
                         :created, 
                         :updated, 
                         :description, :assignee, :reporter).new(1,'open','high', 'ticket 1', 'none', Time.now, Time.now, 'description', 'myself', 'yourself')
    Jira4R::JiraTool.stub!(:new).with(2, @url).and_return(@fj)
    @fj.stub!(:getProjectsNoSchemes).and_return([@project_jira, @project_jira])
    @fj.stub!(:getProjectById).and_return(@project_jira)
    @fj.stub!(:getIssuesFromJqlSearch).and_return([@ticket])
    @tm = TicketMaster.new(:jira, :username => 'testuser', :password => 'testuser', :url => @url)
    @project_tm = @tm.projects.first
    @klass = TicketMaster::Provider::Jira::Ticket
  end

  it "should be able to load all comments"
  it "should be able to create a comment"
end
