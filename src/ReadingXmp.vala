// =================================================================================================
// Copyright 2008 Adobe
// All Rights Reserved.
//
// NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the terms
// of the Adobe license agreement accompanying it.
// =================================================================================================

/* Ported to Vala from the original Walkthrough 1, from the XMP Programmer's Guide */

int main (string[] args) {
    if (args.length != 2) {
        print ("Usage: %s [FILE]\n", args[0]);
        return 1;
    }

    if (!Xmp.init ()) {
        error ("Failed to start exempi.");
    }

    var g_file = File.new_for_commandline_arg (args[1]);
    bool file_exists = g_file.query_exists (null );
    if (!file_exists) {
        error ("File %s does not exist!", args[1]);
    }

    string status =  "", path = g_file.get_path ();
    Xmp.OpenFileOptions open_options = READ | USESMARTHANDLER;

    var file = new Xmp.File ();
    bool ok = file.open_file (path, open_options);
    if (!ok) {
        status += @"No smart packet available for $path\n";
        status += "Trying packet scanning\n";

        open_options = FORUPDATE | USEPACKETSCANNING;

        if (!file.open_file (path, open_options)) {
            error ("Could not open %s.", path);
        }
    }

    var meta = new Xmp.Meta.empty ();
    file.get_xmp (meta);

    bool exists = false;
    string simple_value;
    exists = meta.get_property (Xmp.Namespace.XAP, "CreatorTool", out simple_value, null );

    if (exists) {
        print (@"CreatorTool $simple_value\n");
    }

    string element_value = "";
    int creator_size = meta.count_array_items (Xmp.Namespace.DC, "creator");
    for (int i = 1; i <= creator_size; i++) {
        exists = meta.get_array_item (Xmp.Namespace.DC, "creator", i, out element_value, null);
        print (@"dc:creator [$i] = $element_value\n");
    }

    if (exists) {
        print (@"dc:creator $element_value\n");
    }

    int array_size = meta.count_array_items (Xmp.Namespace.DC, "subject");
    for (int i = 1; i <= array_size; i++) {
        exists = meta.get_array_item (Xmp.Namespace.DC, "subject", i, out element_value, null);
        print (@"dc:subject [$i] = $element_value\n");
    }

    string item_value;
    exists = meta.get_localized_text (Xmp.Namespace.DC, "title", "en", "en-US", null,
                                      out item_value, null);
    if (exists) {
        print (@"dc:title in English = $item_value\n");
    }

    exists = meta.get_localized_text (Xmp.Namespace.DC, "title", "fr", "fr-FR", null,
                                      out item_value, null);
    if (exists) {
        print (@"dc:title in French = $item_value\n");
    }

    DateTime my_date;
    if (meta.get_property_date_time (Xmp.Namespace.XAP, "MetadataDate", out my_date, null)) {
        print (@"meta:MetadataDate = $my_date\n");
    }

    var stream = FileStream.open ("XmpDump.txt", "w");
    bool success = meta.dump_object<unowned FileStream> (stream, (filestream, contents) => {
        filestream.printf ("%s", contents );
        return 0;
    });
    print ("Xmp dumped to XmpDump.txt\n");

    Xmp.terminate ();
    return 0;
}
