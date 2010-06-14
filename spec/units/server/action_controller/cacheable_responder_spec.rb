require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

class RestfulController < ApplicationController
  self.responder = Restfulie::Server::ActionController::RestfulResponder
  respond_to :atom

  def single
    response.last_modified = Time.utc(2010, 2) if params[:last_modified]
    respond_with(AtomifiedModel.new(Time.utc(2010)))
  end

  def collection
    respond_with [AtomifiedModel.new(Time.utc(2010)), AtomifiedModel.new(Time.utc(2009))]
  end

  def new_record
    model = AtomifiedModel.new(Time.utc(2010))
    model.new_record = true
    respond_with(model)
  end

  def empty
    respond_with []
  end
end

ActionController::Routing::Routes.draw do |map|
  map.connect ':controller/:action/:id'
end

describe RestfulController, :type => :controller do
  
  before(:each) do
    request.accept = "application/atom+xml"
  end
  
  context "single resource" do
    
    it "does not set Etag" do
      get :single
      controller.response.etag.should == nil
    end
    
    it "returns 304 Not Modified if client's cache is still valid" do
      request.env["HTTP_IF_MODIFIED_SINCE"] = Time.utc(2010).httpdate
      get :single
      response.status.to_i.should == 304
    end
    
    it "does not use cache in PUT requests" do
      pending
    end

    it "does not use cache in POST requests" do
      pending
    end

    it "does not set cache for new records" do
      pending
    end
  end  
end
