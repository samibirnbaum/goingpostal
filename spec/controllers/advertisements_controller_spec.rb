require 'rails_helper'

RSpec.describe AdvertisementsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "renders the #index view" do
      get :index
      expect(response).to render_template(:index)
    end

    it "assigns all advertisement objects from datbase to @ads" do
      Advertisement.create!(title: "test ad title" , copy: "test add body" , price: 1)
      Advertisement.create!(title: "test ad title2" , copy: "test add body2" , price: 2)
      get :index
      expect(assigns(:ads)).to eq(Advertisement.all) 
    end
  end

  describe "GET #show" do
    it "returns http success" do
      Advertisement.create!(title: "test ad title" , copy: "test add body" , price: 1)
      get :show, params: {id: 1}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      Advertisement.create!(title: "test ad title" , copy: "test add body" , price: 1)
      get :show, params: {id: 1}
      expect(response).to render_template(:show)
    end

    it "assigns to @advert variable the advert from the db with that id" do
      20.times {Advertisement.create!(title: RandomData.random_sentence, copy: RandomData.random_paragraph, price: RandomData.random_integer)}
      get :show, params: {id: 12}
      expect(assigns(:advert)).to eq(Advertisement.find(12))
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template(:new)
    end

    it "assigns to var @advert a new advertisement object for user to populate with form" do
      get :new
      expect(assigns(:advert)).to be_an_instance_of(Advertisement)
    end
  end

  describe "POST #create" do
    it "adds a new advertisement row to the databse" do
      expect{ post :create, params: {advertisement: {title: RandomData.random_sentence, copy: RandomData.random_paragraph, price: RandomData.random_integer}}}.to change{Advertisement.all.size}.by(1)
    end

    it "ultimatley assigns to var @advert the newly created advert" do
      post :create, params: {advertisement: {title: RandomData.random_sentence, copy: RandomData.random_paragraph, price: RandomData.random_integer}}
      expect(assigns(:advert)).to eq(Advertisement.last)
    end

    it "redirects to the new advert on show page" do
      post :create, params: {advertisement: {title: RandomData.random_sentence, copy: RandomData.random_paragraph, price: RandomData.random_integer}}
      expect(response).to redirect_to(Advertisement.last)
    end
  end

end
