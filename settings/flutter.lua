
local flutter = require('flutter-tools')

if flutter ~= nil then

    flutter.setup( {
        ui = {
            -- single | shadow
            border = 'rounded',
            notification_style = 'native' | 'plugin'
        },

        decorations = {
            statusline = {
                app_version = false,
                device = false,
                project_config = false
            }
        },

        debugger = {
            enabled = false,
            run_via_dap = false,
            exception_breakpoints = {},

            register_configurations = function(path)
                require('dap').configurations.dart = {
                }
            end,
        },

        flutter_path = "%localappdata%\\js-frameworks\\flutter",
        flutter_lookup_cmd = "%localappdata%\\js-frameworks\\flutter\\bin",
        root_patterns = { ".git", "pubspec.yaml" },
        fvm = false,
        widget_guides = {
            enabled = false,
        },
        closing_tags = {
            highlight = 'ErrorMsg',
            prefix = ">",
            enabled = true
        },
        dev_log = {
            enabled = true,
            notify_errors = false,
            open_cmd = "tabedit",
        },

        outline = {
            open_cmd = "30vnew",
            auto_open = false
        },

        name = "pTSern",
        flavor = "pTSFlavor",

        target = 'lib/main_dev.dart',
        device = 'pixel5pro',
        dart_define = {  },
        dart_define_from_file = 'config.json'
    } )

end
