# Use this hook to configure ckeditor
Ckeditor.setup do |config|
  # ==> ORM configuration
  # Load and configure the ORM. Supports :active_record (default), :mongo_mapper and
  # :mongoid (bson_ext recommended) by default. Other ORMs may be
  # available as additional gems.
  require 'ckeditor/orm/active_record'

 Ckeditor.setup do |config|
  require 'ckeditor/orm/active_record'
  config.image_file_types = %w(jpg jpeg png gif tiff)
  config.attachment_file_types = %w(doc docx xls odt ods pdf rar zip tar tar.gz swf)
  config.js_config_url = 'ckeditor/config.js'
  config.cdn_url = "//cdn.ckeditor.com/4.7.0/standard/ckeditor.js"
end
end
