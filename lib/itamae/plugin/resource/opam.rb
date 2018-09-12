require "itamae/resource/base"

module Itamae
  module Plugin
    module Resource
      class Opam < Itamae::Resource::Base
        define_attribute :action, default: :install
        define_attribute :opam_binary, type: [String, Array], default: 'opam'
        define_attribute :package_name, type: String, default_name: true
        define_attribute :version, type: String, default: false

        def pre_action
          case @current_action
          when :install
            attributes.installed = true
          when :uninstall
            attributes.installed = false
          end
        end

        def set_current_attributes
          installed = installed_opams.find{|opam| opam[:name] == attributes.package_name }
          current.installed = !!installed

          if current.installed
            version  = installed[:version]
            current.version = version if version != attributes.version
          end
        end

        def action_install(action_options)
          if current.installed
            if attributes.version && current.version != attributes.version
              action!
              updated!
            end
          else
            action!
            updated!
          end
        end

        def action_upgrade(action_options)
          return if current.installed && attributes.version && attributes.version == current.version
          action!
          updated!
        end

        def action_uninstall(action_options)
          action!
          updated!
        end

        private

        def installed_opams
          opams = []
          run_command([*Array(attributes.opam_binary), 'list']).stdout.each_line do |line|
            name, version, *_descriptions = line.split(/\s+/)
            opams << {name: name, version: version}
          end
          opams
        rescue Backend::CommandExecutionError
          []
        end

        def build_aciotn_opam_command
          cmd = [*Array(attributes.opam.binary)]
          case @current_action
          when :install
            cmd << 'install'
          when :uninstall
            cmd << 'uninstall'
          end
          cmd << '-y'

          cmd << attributes.package_name if attributes.package_name
          if @current_action != :switch && attributes.version
            cmd[-1] = "#{attributes.package_name}.#{attributes.vresion}"
          end
          cmd
        end

        def action!
          run_command(build_aciotn_opam_command)
        end
      end
    end
  end
end
