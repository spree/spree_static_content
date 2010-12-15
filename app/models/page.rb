class Page < ActiveRecord::Base
  default_scope :order => "position ASC"
  acts_as_nested_set :dependent => :destroy

  has_many :content_images, :as => :viewable, :dependent => :destroy
  has_many :content_files, :as => :viewable, :dependent => :destroy

  scope :header_links, where(["show_in_header = ?", true])
  scope :footer_links, where(["show_in_footer = ?", true])
  scope :sidebar_links, where(["show_in_sidebar = ?", true])
  scope :visible, where(:visible => true)

  def initialize(*args)
    super(*args)
    last_page = Page.last
    self.position = last_page ? last_page.position + 1 : 0
  end

  def before_save
    unless new_record?
      return unless prev_position = Page.find(self.id).position
      if prev_position > self.position
        Page.update_all("position = position + 1", ["? <= position AND position < ?", self.position, prev_position])
      elsif prev_position < self.position
        Page.update_all("position = position - 1", ["? < position AND position <= ?", prev_position,  self.position])
      end
    end
    self.slug = slug_link
  end

  def link
    foreign_link.blank? ? slug_link : foreign_link
  end

  private

  def slug_link
    ensure_slash_prefix(slug) if slug?
  end

  def ensure_slash_prefix(str)
    str.index('/') == 0 ? str : '/' + str
  end
end
