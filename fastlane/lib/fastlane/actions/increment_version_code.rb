module Fastlane
  module Actions
    module SharedValues
      INCREMENT_VERSION_CODE_CUSTOM_VALUE = :INCREMENT_VERSION_CODE_CUSTOM_VALUE
    end

    class IncrementVersionCodeAction < Action
      def self.run(params)
        # fastlane will take care of reading in the parameter and fetching the environment variable:
        UI.message "Parameter API Token: #{params[:api_token]}"

        # sh "shellcommand ./path"

        # Actions.lane_context[SharedValues::INCREMENT_VERSION_CODE_CUSTOM_VALUE] = "my_val"
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
                                       env_name: "FL_INCREMENT_VERSION_CODE_BUILD_GRADLE",
                                       description: "You must specify the path to your build.gradle",
                                       is_string: true,
                                       verify_block: proc do |value|
                                          UI.user_error!("No build.gradle path for IncrementVersionCodeAction given, pass using `build_gradle: './app/build.gradle'`") unless (value and not value.empty?)
                                       end),
          FastlaneCore::ConfigItem.new(key: :development,
                                       env_name: "FL_INCREMENT_VERSION_CODE_DEVELOPMENT",
                                       description: "Create a development certificate instead of a distribution one",
                                       is_string: false, # true: verifies the input is a string, false: every kind of value
                                       default_value: false) # the default value if the user didn't provide one
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['INCREMENT_VERSION_CODE_CUSTOM_VALUE', 'A description of what this value contains']
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
