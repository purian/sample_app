require 'spec_helper'

describe UsersController do
  render_views


  describe "Get 'show'" do

    before(:each) do
      @user = FactoryGirl.create(:user)
      @base_title = "Ruby on Rails Tutorial Sample App"
    end

    it "should be successful" do
      get :show,  :id => @user
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user    # assigns :user the @user from the users_controller
    end

    it "should have the right title" do
      get :show, :id => @user
      response.should have_selector('title', :content => @user.name)
    end

    it "should have the user's name" do
      get :show, :id => @user
      response.should have_selector('h1', :content => @user.name)
    end

    it "should have a profile image" do
      get :show, :id => @user
      response.should have_selector('h1>img', :class => "gravatar")
    end

    it "should have the right url" do
      get :show, :id => @user
      response.should have_selector('td>a', :content => user_path(@user),
                                            :href => user_path(@user))
    end
  end
  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector("title",
                                    :content => "Sign Up")
    end
  end

  describe "POST 'new'" do

    describe "failure" do

      before(:each) do
        @attr = { :name => "", :email => "", :password => "", :password_confirmation => "" }
      end

      it "should have the right title" do
        post :create, :user => @attr
        response.should have_selector('title', :content => "Sign Up")
      end

      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end

      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)

      end
    end

    describe 'success' do
      before(:each) do
        @attr = { :name => 'new user', :email => "user@example.com",
                  :password => "1234", :password_confirmation => "1234" }
      end

      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it 'should redirect to the user show page' do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end

      it 'should have a welcome message' do
        post :create, :user => @attr
        flash[:success].should =~ /welcome to the sample app/i
      end
    end
  end




end
