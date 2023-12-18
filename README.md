# Vala Bindings for Exempi

**NOTE**: This project is not affiliated to the upstream Exempi project.
In case of any issues with the bindings, report them to this repository
first.

This repository contains Vala bindings for Libexempi, as well as Vala ports
of some of the Walkthroughs from the Adobe XMP Toolkit SDK Programmer's Guide,
including:

- ModifyingXmp
- MyCustomSchema (Partially)
- ReadingXmp

## Background

The Vala bindings were developed by me in order to support Xmp Metadata in
[Paper Clip](https://apps.gnome.org/PdfMetadataEditor/), a PDF Metadata
editing app. For that same reason, these bindings use GLib more than other
non-GIR bindings, as I prefered some utilities provided by it that I could
better integrate with Paper Clip.

## Features

These bindings port 100% of the functions provided by the C API. It notably
replaces uses of `XmpStr` and `XmpDateTime` in favour of `string` and
`GLib.DateTime` respectively. This also dismisses the need for missing C++
functions in the C header, such as the DateTime utilities.

Also, methods like `XmpMeta::DumpObject` are reimplemented in these bindings
despite being missing from the C API.

```vala
DumpCallback<FileStream> callback = (stream, contents) => {
    stream.printf ("%s", contents);
    return 0;
};
var stream = FileStream.open ("DumpObject.txt", "w");
bool success = meta.dump_object<unowned FileStream> (stream, callback);
```

Other functions such as `XmpMeta::CountArrayItems` are restored too, in a 
somewhat hacky implementation.

## Usage

In order to integrate the bindings with your app, you have to pass the
Vala compiler (valac) the `vapidir` that contains the VAPI files that
were not found in the usual directory; this is done through the `--vapidir`
parameter. The directory you specify must contain `vapi/exempi-2.0.vapi`.

If you want to take a look at examples, the `src/meson.build` contains a Meson
implementation of the instructions above.
