class PublicController < ApplicationController
  def main
    @properties = Property.latest
    @posts = Post.latest.limit(4)
  end

  def latest_properties
    @properties = Property.latest.limit(24)
  end
end
