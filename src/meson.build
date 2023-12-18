exempi_vala_deps = [
  dependency('glib-2.0'),
  dependency('gio-2.0'),
  dependency('gobject-2.0'),
  dependency('exempi-2.0'),
]

valac_args = [
  '--target-glib=2.58',
  '--vapidir', meson.project_source_root() / 'vapi',
 ]

executable('ReadingXmp', 'ReadingXmp.vala',
  vala_args: valac_args,
  dependencies: exempi_vala_deps,
  install: true,
)

executable('ModifyingXmp', 'ModifyingXmp.vala',
  vala_args: valac_args,
  dependencies: exempi_vala_deps,
  install: true,
)

executable('MyCustomSchema', 'MyCustomSchema.vala',
  vala_args: valac_args,
  dependencies: exempi_vala_deps,
  install: true,
)