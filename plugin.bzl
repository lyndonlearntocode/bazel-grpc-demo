ProtoPluginInfo = provider(fields = {
    "name": "The proto plugin name",
    "options": "A list of options to pass to the compiler for this plugin",
    "outputs": "Output filenames generated on a per-proto basis. Example: '{basename}_pb2.py",
    "out": "Output filename generated on a per-plugin basis; to be used in the value for --NAME-out=OUT",
    "output_directory": "Flag that indicates that the plugin should just output a directory. Used for plugins that have no direct mapping from source file name to output name. Cannot be used in conjunction with outputs or out",
    "tool": "The plugin binary. If absent, it is assumed the plugin is built-in to protoc itself and plugin_name will be used if available, otherwise the plugin name",
    "tool_executable": "The plugin binary executable",
    "use_built_in_shell_environment": "Whether the tool should use the built in shell environment or not",
    "protoc_plugin_name": "The name used for the plugin binary on the protoc command line. Useful for targeting built-in plugins. Uses plugin name when not set",
    "exclusions": "Exclusion filters to apply when generating outputs with this plugin. Used to prevent generating files that are included in the protobuf library, for example. Can exclude either by proto name prefix or by proto folder prefix",
    "data": "Additional files required for running the plugin",
    "separate_options_flag": "Flag to indicate if plugin options should be sent via the --{lang}_opts flag"
})


def _proto_plugin_impl(ctx):
    return [
        ProtoPluginInfo(
            name = ctx.attr.name,
            options = ctx.attr.options,
            outputs = ctx.attr.outputs,
            out = ctx.attr.out,
            output_directory = ctx.attr.output_directory,
            tool = ctx.attr.tool,
            tool_executable = ctx.executable.tool,
            use_built_in_shell_environment = ctx.attr.use_built_in_shell_environment,
            protoc_plugin_name = ctx.attr.protoc_plugin_name,
            exclusions = ctx.attr.exclusions,
            data = ctx.files.data,
            separate_options_flag = ctx.attr.separate_options_flag,
        )
    ]


proto_plugin = rule(
    implementation = _proto_plugin_impl,
    attrs = {
        "options": attr.string_list(
            doc = "A list of options to pass to the compiler for this plugin",
        ),
        "outputs": attr.string_list(
            doc = "Output filenames generated on a per-proto basis. Example: '{basename}_pb2.py'",
        ),
        "out": attr.string(
            doc = "Output filename generated on a per-plugin basis; to be used in the value for --NAME-out=OUT",
        ),
        "output_directory": attr.bool(
            doc = "Flag that indicates that the plugin should just output a directory. Used for plugins that have no direct mapping from source file name to output name. Cannot be used in conjunction with outputs or out",
            default = False,
        ),
        "tool": attr.label(
            doc = "The plugin binary. If absent, it is assumed the plugin is built-in to protoc itself and builtin_plugin_name will be used if available, otherwise the plugin name",
            cfg = "exec",
            allow_files = True,
            executable = True,
        ),
        "use_built_in_shell_environment": attr.bool(
            doc = "Whether the tool should use the built in shell environment or not",
            default = False,
        ),
        "protoc_plugin_name": attr.string(
            doc = "The name used for the plugin binary on the protoc command line. Useful for targeting built-in plugins. Uses plugin name when not set",
        ),
        "exclusions": attr.string_list(
            doc = "Exclusion filters to apply when generating outputs with this plugin. Used to prevent generating files that are included in the protobuf library, for example. Can exclude either by proto name prefix or by proto folder prefix",
        ),
        "data": attr.label_list(
            doc = "Additional files required for running the plugin",
            allow_files = True,
        ),
        "separate_options_flag": attr.bool(
            doc = "Flag to indicate if plugin options should be sent via the --{lang}_opts flag",
            default = False,
        ),
    },
)
