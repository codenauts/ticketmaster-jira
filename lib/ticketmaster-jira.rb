require 'ticketmaster'
require 'jira4r'

# Monkey patch for Jira4R

module Jira4R
  module V2
    class JiraSoapService < ::SOAP::RPC::Driver
      Methods.push(
      [ XSD::QName.new(NsSoapRpcJiraAtlassianCom, "getIssuesFromJqlSearch"),
          "",
          "getIssuesFromJqlSearch",
          [ ["in", "in0", ["::SOAP::SOAPString"]],
            ["in", "in1", ["::SOAP::SOAPString"]],
            ["in", "in3", ["::SOAP::SOAPInt"]],
            ["retval", "getIssuesFromJqlSearchReturn", ["Jira4R::V2::ArrayOf_tns1_RemoteIssue", "http://jira.atlassian.com/rpc/soap/jirasoapservice-v2", "ArrayOf_tns1_RemoteIssue"]] ],
          { :request_style =>  :rpc, :request_use =>  :encoded,
            :response_style => :rpc, :response_use => :encoded,
            :faults => {"Jira4R::V2::RemoteException_"=>{:use=>"encoded", :name=>"RemoteException", :ns=>"http://jira.atlassian.com/rpc/soap/jirasoapservice-v2", :namespace=>"http://jira.atlassian.com/rpc/soap/jirasoapservice-v2", :encodingstyle=>"http://schemas.xmlsoap.org/soap/encoding/"}} }])
    end
  end
end

%w{ jira ticket project comment }.each do |f|
  require File.dirname(__FILE__) + '/provider/' + f + '.rb';
end
