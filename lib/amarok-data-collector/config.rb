require 'yaml'

module AmarokDataCollector
  class Config

    class << self
      def load_config
        # todo
      end

      def write_config(amarok, amarok_stats)
        config = deep_stringify_keys_and_values(amarok: amarok.to_config, amarok_stats: amarok_stats.to_config).to_yaml
        File.open(config_file, 'w') { |file| file.write config }
      end

      def deep_stringify_keys_and_values(hash)
        result = {}

        hash.each do |k, v|
          v = v.to_s if v.is_a?(Symbol)
          v = deep_stringify_keys_and_values(v) if v.is_a?(Hash)
          result[k.to_s] = v
        end

        result
      end

      def config_file
        File.join(Dir.home, '.config', 'amarok_stats', 'db_config.yml')
      end
    end

  end
end
