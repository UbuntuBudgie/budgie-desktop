/*
 * This file is part of budgie-desktop
 * 
 * Copyright (C) 2015-2016 Ikey Doherty <ikey@solus-project.com>
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 */

public class RavenTriggerPlugin : Budgie.Plugin, Peas.ExtensionBase
{
    public Budgie.Applet get_panel_widget(string uuid)
    {
        return new RavenTriggerApplet();
    }
}

public class RavenTriggerApplet : Budgie.Applet
{
    protected Gtk.Button widget;
    protected Gtk.Image img;

    public RavenTriggerApplet()
    {
        widget = new Gtk.Button();
        widget.relief = Gtk.ReliefStyle.NONE;
        img = new Gtk.Image.from_icon_name("pane-show-symbolic", Gtk.IconSize.BUTTON);
        widget.add(img);
        add(widget);
        show_all();
    }
}


[ModuleInit]
public void peas_register_types(TypeModule module)
{
    // boilerplate - all modules need this
    var objmodule = module as Peas.ObjectModule;
    objmodule.register_extension_type(typeof(Budgie.Plugin), typeof(RavenTriggerPlugin));
}

/*
 * Editor modelines  -  https://www.wireshark.org/tools/modelines.html
 *
 * Local variables:
 * c-basic-offset: 4
 * tab-width: 4
 * indent-tabs-mode: nil
 * End:
 *
 * vi: set shiftwidth=4 tabstop=4 expandtab:
 * :indentSize=4:tabSize=4:noTabs=true:
 */