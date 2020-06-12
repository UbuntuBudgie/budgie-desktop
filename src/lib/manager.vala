/*
 * This file is part of budgie-desktop.
 *
 * Copyright © 2015-2019 Budgie Desktop Developers
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 */

namespace Budgie
{

public abstract class DesktopManager : GLib.Object
{

    public signal void panels_changed();
    public signal void panel_deleted(string uuid);
    public signal void panel_added(string uuid, Budgie.Toplevel toplevel);

    public virtual GLib.List<Budgie.Toplevel?> get_panels()
    {
        return new GLib.List<Budgie.Toplevel?>();
    }

    public abstract uint slots_available();
    public abstract uint slots_used();
    public abstract void set_placement(string uuid, Budgie.PanelPosition position, int monitor);
    public abstract void set_transparency(string uuid, Budgie.PanelTransparency transparency);
    public abstract void set_autohide(string uuid, Budgie.AutohidePolicy policy);
    public abstract void set_dock_mode(string uuid, bool dock_mode);
    public abstract void set_size(string uuid, int size);
    public abstract void set_display_disconnect(string uuid, bool move_on_disconnect);

    public abstract void create_new_panel();
    public abstract void delete_panel(string uuid);
    public abstract GLib.List<Peas.PluginInfo?> get_panel_plugins();

}


} /* End namespace */

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
