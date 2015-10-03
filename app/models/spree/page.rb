class Spree::Page < ActiveRecord::Base
  default_scope { order(position: :asc) }

  has_and_belongs_to_many :stores, join_table: 'spree_pages_stores'

  belongs_to :parent, class_name: 'Spree::Page'
  has_many :children, class_name: 'Spree::Page', foreign_key: 'parent_id', :dependent => :destroy

  validates :title, presence: true
  validates :slug, :body, presence: true, if: :not_using_foreign_link?
  validates :layout, presence: true, if: :render_layout_as_partial?
  validates :slug, uniqueness: true, if: :not_using_foreign_link?
  validates :foreign_link, uniqueness: true, allow_blank: true

  scope :visible, -> { where(visible: true) }
  scope :header_links, -> { where(show_in_header: true).visible }
  scope :footer_links, -> { where(show_in_footer: true).visible }
  scope :sidebar_links, -> { where(show_in_sidebar: true).visible }
  scope :root, -> { where(parent: nil).visible }
  scope :current_locale, -> { where(locale: I18n.locale).visible }
  scope :with_locale, ->(locale) { where(locale: locale).visible }
  scope :except_id, ->(id) { where.not(id: id) }

  scope :by_store, ->(store) { joins(:stores).where('spree_pages_stores.store_id = ?', store) }

  before_save :update_positions_and_slug

  def initialize(*args)
    super(*args)
    last_page = Spree::Page.last
    self.position = last_page ? last_page.position + 1 : 0
  end

  def link
    foreign_link.blank? ? "/#{locale}#{slug}" : foreign_link
  end

  private

  def update_positions_and_slug
    # Ensure that all slugs start with a slash.
    slug.prepend('/') if not_using_foreign_link? && !slug.start_with?('/')
    return if new_record?
    # return unless (prev_position = Spree::Page.find(id).position)
    # if prev_position > position
    #   Spree::Page.where('? <= position and position < ?', position, prev_position).update_all('position = position + 1')
    # elsif prev_position < position
    #   Spree::Page.where('? < position and position <= ?', prev_position, position).update_all('position = position - 1')
    # end
  end

  def not_using_foreign_link?
    foreign_link.blank?
  end
end
