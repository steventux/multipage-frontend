class MultipartContentsController < ApplicationController

  before_action :get_content_item, only: [:show]

  def show
    render_404 unless @content.present?
  end

private

  def get_content_item
    @content = ContentStore.service.content_item(content_item_path)

    unless @content.present?
      if base_content_item_path != content_item_path
        redirect_to base_content_item_path
      end
    end
  end

  def content_item_path
    "/#{params[:slug]}"
  end

  def base_content_item_path
    parts = content_item_path.split("/")
    parts.shift

    return content_item_path if parts.first.empty?

    "/#{parts.first}"
  end
end
