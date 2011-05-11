require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "TicketMaster::Provider::Jira" do 
  before(:each) do
    @url = "some_url"
    @fj = FakeJiraTool.new
    Jira4R::JiraTool.stub!(:new).with(2, @url).and_return(@fj)
  end

  it "should be able to instantiate a new ticketmaster instance" do
    @tm = TicketMaster.new(:jira, :username => 'testing', :password => 'testing', :url => @url)
    @tm.should be_an_instance_of(TicketMaster)
    @tm.should be_a_kind_of(TicketMaster::Provider::Jira)
  end
end
