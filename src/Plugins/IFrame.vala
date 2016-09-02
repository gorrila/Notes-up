/*
* Copyright (c) 2011-2016 Felipe Escoto (https://github.com/Philip-Scott/Notes-up)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 59 Temple Place - Suite 330,
* Boston, MA 02111-1307, USA.
*
* Authored by: Felipe Escoto <felescoto95@hotmail.com>
*/

public class ENotes.IFrame : ENotes.Plugin , GLib.Object {
    private PatternSpec spec = new PatternSpec ("*<web *>*"); 

    construct {

    }

    public bool is_active () {
        return true;
    }

    public void set_active (bool active) {

    }

    public string get_desctiption () {
        return "Insert a webpage via <web [website]>";
    }

    public string get_name () {
        return "iframe";
    }
    
    public Gtk.Widget? editor_button () {
        return null;
    }

    public bool has_match (string text) {
        return spec.match_string (text);
    }

    public string convert (string line_) {
        int chars = line_.length;
        string line = line_ + "     ";
        string builed = "";

        int initial = 0, final = 0, last = 0;
        int i;
        for (i = -1; i < chars; ++i) {
            if (line[i] == '<') initial = i;
            else if (line[i] == '>') {
                final = i;
                string cut = line[initial:final];
                if (cut.contains ("<web ")) {
                    builed = builed + line [last:initial] + cut.replace ("<web ", "<iframe src=\"") + "\" style=\"width: 100%; height: 500px\"> </iframe>";
                    last = final +1;
                    
                }
            }
        }

        return builed + line[last:i];
    }
}