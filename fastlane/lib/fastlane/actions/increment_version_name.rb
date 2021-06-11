module Fastlane
  module Actions
    module SharedValues
      INCREMENT_VERSION_NAME_CUSTOM_VALUE = :INCREMENT_VERSION_NAME_CUSTOM_VALUE
    end

    class IncrementVersionNameAction < Action
      def self.run(params)
        # fastlane will take care of reading in the parameter and fetching the environment variable:
        UI.message "Parameter API Token: #{params[:api_token]}"

        # sh "shellcommand ./path"

        # Actions.lane_context[SharedValues::INCREMENT_VERSION_NAME_CUSTOM_VALUE] = "my_val"
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "A short description with <= 80 characters of what this action does"
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
                                         UI.user_error!("Available values are 'patch', 'minor' and 'major'") unless ['bump', 'patch', 'minor', 'major'].include?(value)
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
        [
          ['INCREMENT_VERSION_NAME_CUSTOM_VALUE', 'A description of what this value contains']
        ]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.authors
        ["reichhartd"]
      end

      def self.is_supported?(platform)
        platform == :android
      end
    end
  end
end
