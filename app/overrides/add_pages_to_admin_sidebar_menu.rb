Deface::Override.new(
  virtual_path: 'spree/admin/shared/main_menu',
  name: 'pages_admin_sidebar_menu',
  insert_bottom: '.nav-sidebar',
  partial: 'spree/admin/shared/pages_sidebar_menu',
  disabled: false
)
