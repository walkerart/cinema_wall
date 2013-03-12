class Panel < ActiveRecord::Base

  attr_accessible :background_color, :background_file, :order, :slide_id, :text
  attr_accessible :retained_background_file, :remove_background_file
  default_scope order("'panels'.'order'") # wtf

  belongs_to :slide
  image_accessor :background_file

  def position
    order.nil? ? 0 : order
  end

  # defaults to white if no image or color
  def background
    background_file.try( :remote_url) || background_color || "#ffffff"
  end

  def panel_type
    case
    when background_file_uid.nil? && text.nil?
      "color"
    when background_file_uid.present? && text.nil?
      "image"
    when background_file_uid.present? && text.present?
      "detail"
    when background_file_uid.nil? && text.present?
      "headline"
    end
  end

  def to_s
    id
  end
end