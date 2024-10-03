project('gvc', 'c',
  meson_version: '>= 0.42.0',
  default_options: ['static=true']
)

assert(meson.is_subproject(), 'This project is only intended to be used as a subproject!')

gnome = import('gnome')

pkglibdir = get_option('pkglibdir')
pkgdatadir = get_option('pkgdatadir')

cdata = configuration_data()
cdata.set_quoted('GETTEXT_PACKAGE', get_option('package_name'))
cdata.set_quoted('PACKAGE_VERSION', get_option('package_version'))

libgvc_gir_headers = [
  'gvc-channel-map.h',
  'gvc-mixer-card.h',
  'gvc-mixer-control.h',
  'gvc-mixer-event-role.h',
  'gvc-mixer-sink.h',
  'gvc-mixer-sink-input.h',
  'gvc-mixer-source.h',
  'gvc-mixer-source-output.h',
  'gvc-mixer-stream.h',
  'gvc-mixer-ui-device.h'
]

libgvc_enums = gnome.mkenums_simple('gvc-enum-types',
  sources: libgvc_gir_headers
)

libgvc_gir_sources = [
  'gvc-channel-map.c',
  'gvc-mixer-card.c',
  'gvc-mixer-control.c',
  'gvc-mixer-event-role.c',
  'gvc-mixer-sink.c',
  'gvc-mixer-sink-input.c',
  'gvc-mixer-source.c',
  'gvc-mixer-source-output.c',
  'gvc-mixer-stream.c',
  'gvc-mixer-ui-device.c'
]

libgvc_no_gir_sources = [
  'gvc-mixer-card-private.h',
  'gvc-mixer-stream-private.h',
  'gvc-channel-map-private.h',
  'gvc-mixer-control-private.h',
  'gvc-pulseaudio-fake.h'
]

libgvc_deps = [
  dependency('gio-2.0'),
  dependency('gobject-2.0'),
  dependency('libpulse', version: '>= 12.99.3'),
  dependency('libpulse-mainloop-glib')
]

enable_alsa = get_option('alsa')
if enable_alsa
  libgvc_deps += dependency('alsa')
endif
cdata.set('HAVE_ALSA', enable_alsa)

enable_static = get_option('static')
enable_introspection = get_option('introspection')

assert(not enable_static or not enable_introspection, 'Currently meson requires a shared library for building girs.')
assert(enable_static or pkglibdir != '', 'Installing shared library, but pkglibdir is unset!')

c_args = ['-DG_LOG_DOMAIN="Gvc"']

if enable_introspection
  c_args += '-DWITH_INTROSPECTION'
endif

if enable_static
  libgvc_static = static_library('gvc',
    sources: libgvc_gir_sources + libgvc_no_gir_sources + libgvc_enums,
    dependencies: libgvc_deps,
    c_args: c_args
  )

  libgvc = libgvc_static
else
  if pkglibdir == ''
    error('Installing shared library, but pkglibdir is unset!')
  endif

  libgvc_shared = shared_library('gvc',
    sources: libgvc_gir_sources + libgvc_no_gir_sources + libgvc_enums,
    dependencies: libgvc_deps,
    c_args: c_args,
    install_dir: pkglibdir,
    install: true
  )

  libgvc = libgvc_shared
endif

if enable_introspection
  assert(pkgdatadir != '', 'Installing introspection, but pkgdatadir is unset!')

  libgvc_gir = gnome.generate_gir(libgvc,
    sources: libgvc_gir_sources + libgvc_gir_headers + libgvc_enums,
    nsversion: '1.0',
    namespace: 'Gvc',
    includes: ['Gio-2.0', 'GObject-2.0'],
    extra_args: ['-DWITH_INTROSPECTION', '--quiet'],
    install_dir_gir: pkgdatadir,
    install_dir_typelib: pkglibdir,
    install: true
  )
endif

if enable_alsa
  executable('test-audio-device-selection',
    sources: 'test-audio-device-selection.c',
    link_with: libgvc,
    dependencies: libgvc_deps,
    c_args: c_args
  )
endif

libgvc_dep = declare_dependency(
  link_with: libgvc,
  include_directories: include_directories('.'),
  dependencies: libgvc_deps
)

configure_file(
  output: 'config.h',
  configuration: cdata
)
