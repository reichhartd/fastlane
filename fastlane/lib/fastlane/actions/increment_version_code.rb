module Fastlane
  module Actions
    module SharedValues
      INCREMENT_VERSION_CODE_CUSTOM_VALUE = :INCREMENT_VERSION_CODE_CUSTOM_VALUE
    end

    class IncrementVersionCodeAction < Action
      def self.run(params)
        path = params[:build_gradle]
        version_code = params[:version_code]

        re = /versionCode\s+(\d+)/

        s = File.read(path)
        if (version_code == nil)
            old_version_code = s[re, 1].to_i
            version_code = (old_version_code + 1).to_s
        end
        s[re, 1] = (version_code).to_s

        f = File.new(path, 'w')
        f.write(s)
        f.close
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Increment the version code of your project"
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "You can use this action to do cool things..."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :build_gradle,
                                       env_name: "FL_INCREMENT_VERSION_CODE_BUILD_GRADLE",
                                       description: "You must specify the path to your build.gradle",
                                       is_string: true,
                                       verify_block: proc do |value|
                                          UI.user_error!("No build.gradle path for IncrementVersionCodeAction given, pass using `build_gradle: './app/build.gradle'`") unless (value and not value.empty?)
                                       end),
          FastlaneCore::ConfigItem.new(key: :version_code,
                                       env_name: "FL_INCREMENT_VERSION_CODE_VERSION_CODE",
                                       description: "Change to a specific version code",
                                       is_string: true,
                                       optional: true),
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        # [
        #   ['INCREMENT_VERSION_CODE_CUSTOM_VALUE', 'A description of what this value contains']
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
          'increment_version_code(
            build_gradle: "./app/build.gradle" # You must specify the path to your build.gradle
          )',
          'increment_version_code(
            build_gradle: "./app/build.gradle" # You must specify the path to your build.gradle
            build_number: "73", # Specify specific version code (optional, omitting it increments by one)
          )'
        ]
      end

      def self.is_supported?(platform)
        platform == :android
      end
    end
  end
end
