load("//:plugin.bzl", "ProtoPluginInfo")
load(
    "//:aspect.bzl",
    "ProtoLibraryAspectNodeInfo",
    "proto_compile_aspect_attrs",
    "proto_compile_aspect_impl",
    "proto_compile_attrs",
    "proto_compile_impl",
)

# Create aspect for java_proto_compile
java_proto_compile_aspect = aspect(
    implementation = proto_compile_aspect_impl,
    provides = [ProtoLibraryAspectNodeInfo],
    attr_aspects = ["deps"],
    attrs = dict(
        proto_compile_aspect_attrs,
        _plugins = attr.label_list(
            doc = "List of protoc plugins to apply",
            providers = [ProtoPluginInfo],
            default = [
                Label("//java:java_plugin"),
            ],
        ),
        _prefix = attr.string(
            doc = "String used to disambiguate aspects when generating outputs",
            default = "java_proto_compile_aspect",
        )
    ),
    toolchains = [str(Label("//protobuf:toolchain_type"))],
)

# Create compile rule to apply aspect
_rule = rule(
    implementation = proto_compile_impl,
    attrs = dict(
        proto_compile_attrs,
        deps = attr.label_list(
            mandatory = True,
            providers = [ProtoInfo, ProtoLibraryAspectNodeInfo],
            aspects = [java_proto_compile_aspect],
        ),
    ),
)

# Create macro for converting attrs and passing to compile
def java_proto_compile(**kwargs):
    _rule(
        verbose_string = "{}".format(kwargs.get("verbose", 0)),
        merge_directories = False,
        **{k: v for k, v in kwargs.items() if k != "merge_directories"}
    )
