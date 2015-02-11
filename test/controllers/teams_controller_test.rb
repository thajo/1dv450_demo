require 'test_helper'

class TeamsControllerTest < ActionController::TestCase
 
  # This test should check the route för /teams
  # Do the call with Accept application/json
  # And check that the instance variables is set

  
  # This test is now obsolete because we're testing JWT
  test "Should list teams (GET /teams)" do
    assert_routing '/teams', { controller: "teams", action: "index"}  #check the route
   # get :index ,{:format => :json} # check that the action exists
    
   # assert_response :success
   # assert_not_nil assigns(:teams) # check that we assigns @team
    
    #assert_equal assigns(:teams).first.nickname.downcase, "spurs" # check some data, controlled by fixures
  end
  
  
  
  
  ## Just checking the route for teams/:id  
  test "The route teams/:id should work" do
    assert_routing '/teams/1212', { controller: "teams", action: "show", id: "1212"}  #check the route
  end
  
  
  ## Test for error handling
  test 'Should return (404) and an errormessage in json format' do
    
    # call a resource that dont exists
    get :show ,{:id => "824723", format: "json"} # check that the action exists
    assert_response :not_found
    
    # parse the response (error messages)
    error = JSON.parse(response.body)
   
    # Check that it is correct
    assert_not_nil error["developer_message"]
    assert_not_nil error["user_message"]
  end
  
  test 'Should return (404) and an errormessage in xml format' do
    get :show ,{:id => "824723", format: "xml"} # check with XML
    assert_response :not_found
    
    # I could try the header in the response...should be XML
    assert_equal @response.headers['Content-Type'], 'application/xml; charset=utf-8'
    
    # assert_select is often used for HTML but thats great for XML
    assert_select 'developer_message', 1
    assert_select 'user_message', 1
   end
  
  test 'Should return (400) and an errormessage in json format' do
    get :show ,{:id => "824723", format: "html"} # This test a format my API doesn't reponse to
    assert_response :bad_request
  end
  
   
end

# http://railsguides.net/belongs-to-and-presence-validation-rule1/