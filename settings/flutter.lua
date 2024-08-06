
local flutter = require('flutter-tools')

if flutter ~= nil then

    flutter.setup( {
        ui = {
            -- single | shadow
            border = 'rounded',
            notification_style = 'native'
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

        --flutter_path = os.getenv("LOCALAPPDATA") .. "\\js-frameworks\\flutter",
        --flutter_lookup_cmd = os.getenv("LOCALAPPDATA") .. "\\js-frameworks\\flutter",
        --flutter_path = os.getenv("LOCALAPPDATA") .. "\\js-frameworks\\flutter\\",
        root_patterns = { ".git", "pubspec.yaml" },
        fvm = false,
        widget_guides = {
            enabled = true,
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

        {
            name = "pTSern",
            flavor = "pTSFlavor",

            target = 'lib/main_dev.dart',
            device = 'pixel5pro',
            dart_define = {
                IS_DEV = true
            },
            dart_define_from_file = 'config.json'
        },
    } )

    require('telescope').load_extension("flutter")

end

