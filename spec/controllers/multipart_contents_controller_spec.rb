require 'rails_helper'

RSpec.describe MultipartContentsController, type: :controller do
  describe "GET show" do
    context "for an existing content item" do
      before do
        content_store_has_item("/vat-rates")
      end

      it "renders the content item" do
        get :show, slug: "vat-rates"

        expect(response).to be_successful
      end
    end

    context "for an existing content item with parts" do
      before do
        content_item = content_item_for_base_path("/vat-rates")
        content_item["details"].merge!("parts" => [
          {"slug" => "information", "title" => "Information", "body" => "Body..."},
          {"slug" => "current-rates", "title" => "Current rates", "body" => "Body..."},
        ])
        content_store_has_item("/vat-rates", content_item)
      end

      it "responds successfully when the base content item is requested" do
        get :show, slug: "vat-rates"

        expect(response).to be_successful
        expect(assigns(:content)).to be
        expect(assigns(:current_part)).not_to be
      end

      it "responds successfully when a part is requested" do
        get :show, slug: "vat-rates", part: "current-rates"

        expect(response).to be_successful
        expect(assigns(:content)).to be
        expect(assigns(:current_part)).to be
      end

      it "redirects to the base path when an invalid part is requested" do
        get :show, slug: "vat-rates", part: "current-rateses"

        expect(response).to redirect_to("/vat-rates")
        expect(assigns(:content)).to be
        expect(assigns(:current_part)).not_to be
      end
    end

    context "for an invalid path" do
      before do
        content_store_does_not_have_item("/cat-rates")
      end

      it "responds with 404" do
        get :show, slug: "cat-rates"

        expect(response.status).to eq(404)
      end
    end
  end
end
