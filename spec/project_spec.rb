require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "TicketMaster::Provider::Jira::Project" do 
  before(:each) do
    @url = "some_url"
    @fj = FakeJiraTool.new
    @project = Struct.new(:name, :description)
    Jira4R::JiraTool.stub!(:new).with(2, @url).and_return(@fj)
    @fj.stub!(:getProjectsNoSchemes).and_return([@project, @project])
    @tm = TicketMaster.new(:jira, :username => 'testuser', :password => 'testuser', :url => @url)
    @klass = TicketMaster::Provider::Jira::Project
  end

  it "should be able to load all projects" do
    @tm.projects.should be_an_instance_of(Array)
    @tm.projects.first.should be_an_instance_of(@klass)
  end

  it "should be able to load all projects based on an array of id's"
  it "should be able to load all projects by attributes" 
  it "should be able to load a single project based on id" 
  it "should be able to load a single project by attributes"
end
