class MultipartContentsController < ApplicationController
  def show
    content_item_response = ContentStore.service.content_item("/#{params[:slug]}")
    @content = MultipartContent.new(content_item_response.to_hash) if content_item_response
    if @content.present?
      if params[:part]
        @current_part = current_part
        redirect_to "/#{params[:slug]}" unless @current_part
      end
    else
      render_404
    end
  end

private

  def current_part
    return unless part_slug = params[:part]
    return unless @content.parts && @content.parts.any?
    @content.parts.find{ |part| part.slug == part_slug }
  end
end
