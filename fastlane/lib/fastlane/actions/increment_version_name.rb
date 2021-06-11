module Fastlane
  module Actions
    module SharedValues
      INCREMENT_VERSION_NAME_CUSTOM_VALUE = :INCREMENT_VERSION_NAME_CUSTOM_VALUE
    end

    class IncrementVersionNameAction < Action
      def self.run(params)
        path = params[:build_gradle]
        bump_type = params[:bump_type]
        version_name = params[:version_name]

        re = /versionName\s+"(\d|\.)*"/
        re_value = /"(\d|\.)*"/

        s = File.read(path)
        if (version_name == nil)
            old_version_name = s[re][re_value]
            old_version_name[0] = ''
            old_version_name[old_version_name.length - 1] = ''
            version_name = old_version_name

            version_name = version_name.split(/\./)

            case bump_type
            when 'patch'
                version_name[2] = (version_name[2].to_i + 1).to_s
            when 'minor'
                version_name[1] = (version_name[1].to_i + 1).to_s
                version_name[2] = '0'
            when 'major'
                version_name[0] = (version_name[0].to_i + 1).to_s
                version_name[1] = '0'
                version_name[2] = '0'
            else
                raise 'Wrong or no bump_type provided'
            end

            version_name = version_name.join('.')
        end

        s[re] = "versionName \"" + version_name + "\""

        f = File.new(path, 'w')
        f.write(s)
        f.close
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Increment the version name of your project"
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "You can use this action to do cool things..."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :build_gradle,
                                       env_name: "FL_INCREMENT_VERSION_NAME_BUILD_GRADLE",
                                       description: "You must specify the path to your build.gradle",
                                       is_string: true,
                                       verify_block: proc do |value|
                                          UI.user_error!("No build.gradle path for IncrementVersionNameAction given, pass using `build_gradle: './app/build.gradle'`") unless (value and not value.empty?)
                                       end),
          FastlaneCore::ConfigItem.new(key: :bump_type,
                                       env_name: "FL_INCREMENT_VERSION_NAME_BUMP_TYPE",
                                       description: "The type of this version bump. Available: patch, minor, major",
                                       is_string: false,
                                       verify_block: proc do |value|
                                         UI.user_error!("Available values are 'patch', 'minor' and 'major'") unless ['patch', 'minor', 'major'].include?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :version_name,
                                       env_name: "FL_INCREMENT_VERSION_NAME_VERSION_NAME",
                                       description: "Change to a specific version name",
                                       is_string: true,
                                       optional: true),
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        # [
        #   ['INCREMENT_VERSION_NAME_CUSTOM_VALUE', 'A description of what this value contains']
        # ]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.authors
        ["reichhartd"]
      end

      def self.example_code
        [
          'increment_version_name(
            build_gradle: "./app/build.gradle" # You must specify the path to your build.gradle
            bump_type: "patch", # Automatically increment patch version number
          )',
          'increment_version_name(
            build_gradle: "./app/build.gradle" # You must specify the path to your build.gradle
            version_name: "73", # Specify specific version name
          )'
        ]
      end

      def self.is_supported?(platform)
        platform == :android
      end
    end
  end
end
