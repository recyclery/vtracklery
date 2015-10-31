module Worker::WorkerImage
  extend ActiveSupport::Concern

  included do
    mount_uploader :image, AvatarUploader
  end

  module ClassMethods
    # @return [Array<String>]
    def avatar_filepaths
      filepaths = []
      Dir.entries(Settings.avatars.default_dir).each do |file|
        filepaths.push file if file =~ /\.png/
      end
      return filepaths
    end

    # @return [String]
    def cheese_dir
      return Settings.cheese.dir
    end

    # @return [Array<String>]
    def cheese_filepaths
      filepaths = []
      begin
        Dir.entries(Settings.cheese.dir).each do |file|
          filepaths.push file if file =~ /\.jpg/
        end if File.directory? Settings.cheese.dir
      rescue #"Errno::ENOENT"
      end
      return filepaths
    end

    # @return [String]
    def default_avatar_dir
      return Settings.avatars.default_dir
    end

  end

  # Carrierwave doesn't allow image field to be assigned directly
  # Must pass a file to be written on assignment.
  #
  def seed_image; image; end
  def seed_image=(val)
    path = File.join(Rails.root, 'public', val)
    self.image = open(path) if File.exists?(path)
  end

  # @return [String]
  def avatar_url
    image_url
    #if image.nil? then return Settings.avatars.missing_url
    #elsif image =~ /\w+\/\w+/ then
    #  return image_exists? ? "/system/#{image}" : Settings.avatars.missing_url
    #elsif image_exists? then return "/assets/default_avatars/#{image}"
    #else return Settings.avatars.missing_url
    #end
  end

  # @return [String]
  def avatar_path
    image.path
    #if image.nil?
    #  return File.join(Settings.avatars.missing_path.split('/'))
    #elsif image =~ /\w+\/\w+/
    #  File.join("public", "system", image.split("/"))
    #else
    #  # If the image name has no directory marks, assume its from the default
    #  File.join("app", "assets", "images", "default_avatars", image)
    #end
  end

  # @return [Boolean] true if there's a file at #avatar_path
  def image_exists?
    File.exists?(avatar_path)
  end

end
