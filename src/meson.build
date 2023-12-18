exempi_vapi_sources = [
  'main.vala',
]

exempi_vapi_deps = [
  dependency('glib-2.0'),
  dependency('gobject-2.0'),
]

executable('exempi-vapi', exempi_vapi_sources,
  vala_args: '--target-glib=2.58',  dependencies: exempi_vapi_deps,
  install: true,
)

