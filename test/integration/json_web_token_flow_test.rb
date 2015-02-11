require 'test_helper'

class JsonWebTokenFlowTest < ActionDispatch::IntegrationTest
  
  
  test "Should fail to get a token" do
    # Call auth with incorrect information - Methods in the SessionHelper
    post "/auth", {email: users(:one).email, password: "hemligtmenfel"}
    assert_response :unauthorized
    
    # Parse the response
    token = JSON.parse(response.body)
   
    # Should not have an auth_token (JWT)
    assert_nil token["auth_token"]
  end
 
  test "Should authenticate and get a JWT" do
    
    # Call auth with correct information - Methods in the SessionHelper
    post "/auth", {email: users(:one).email, password: "hemligt"}
    assert_response :success
    
    # Parse the response
    token = JSON.parse(response.body)
   
    # Should have an auth_token (JWT)
    assert_not_nil token["auth_token"]
    
    
    # Should be able to call GET /teams/1
    get "teams.json", {}, {Authorization: "Bearer #{token['auth_token']}"}
    assert_response :success
  
    # test without a token
    get "teams.json"
    assert_response :forbidden # No token => forbidden to see this
  end
  
  
   test "should authenticate and get a JWT" do
    
     # Post with wrong password
     post "/auth", {email: users(:one).email, password: "hemligtmenfel"}
     assert_response :unauthorized
         
     token = JSON.parse(response.body)
   
     # Should gor an error message
     assert_nil token["auth_token"] 
     assert_not_nil token["error"]
   end
  
end
