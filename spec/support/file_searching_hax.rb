# frozen_string_literal: true

require_relative "../../lib/bundler/shared_helpers"
require_relative "path"

module Bundler
  module TestSharedHelpers
    def self.prepended(base)
      base.singleton_class.prepend(ClassMethods)
    end

    module ClassMethods
      private # rubocop:disable Layout/AccessModifierIndentation

      def find_file(*names)
        limit_to_files_inside_test_repo(super)
      end

      def find_directory(*names)
        limit_to_files_inside_test_repo(super)
      end

      def limit_to_files_inside_test_repo(result)
        return nil unless result
        repo_root = Spec::Path.root.to_s
        result_root = File.dirname(result)
        return nil if repo_root.include?(result_root)
        result
      end
    end
  end

  module SharedHelpers
    prepend TestSharedHelpers
  end
end
