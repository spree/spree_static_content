class Spree::Page < ActiveRecord::Base
  acts_as_list

  default_scope -> { order('position ASC') }

  validates_presence_of :title
  validates_presence_of [:slug, :body], if: :not_using_foreign_link?
  validates_presence_of :layout, if: :render_layout_as_partial?

  validates :slug, uniqueness: true, if: :not_using_foreign_link?
  validates :foreign_link, uniqueness: true, allow_blank: true

  scope :visible, -> { where(visible: true) }
  scope :header_links, -> { where(show_in_header: true).visible }
  scope :footer_links, -> { where(show_in_footer: true).visible }
  scope :sidebar_links, -> { where(show_in_sidebar: true).visible }

  before_save :update_slug

  def link
    foreign_link.blank? ? slug : foreign_link
  end

  private

  def update_slug
    # ensure that all slugs start with a slash
    slug.prepend('/') if not_using_foreign_link? && !slug.start_with?('/')
  end

  def not_using_foreign_link?
    foreign_link.blank?
  end
end
