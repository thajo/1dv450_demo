require 'test_helper'

class JsonWebTokenFlowTest < ActionDispatch::IntegrationTest
 
  test "ahould authenticate and get a JWT" do
    
    # Call auth with correct information
    post "/auth", {email: users(:one).email, password: "hemligt"}
    assert_response :success
    
    # Parse the response
    token = JSON.parse(response.body)
   
    # Should have an auth_token (JWT)
    assert_not_nil token["auth_token"]
    
    #puts "Bearer #{token['auth_token']}"
    # Should be able to call GET /teams/1
    get "teams/1.json", {}, {Authorization: "Bearer #{token['auth_token']}"}
    assert_response :success
  end
  
  
   test "should authenticate and get a JWT" do
    
     # Post with wrong password
     post "/auth", {email: users(:one).email, password: "hemligtmenfel"}
     assert_response :unauthorized
         
     token = JSON.parse(response.body)
   
     # Should gor an error message
     assert_nil token["auth_token"] 
     assert_not_nil token["error"]
     
     # Should not be able to call GET  /teams/1 (just stupid test url)
     
     
  end
  
end
