{ lib, config, ... }:

{
 options.ncmpcppConfig.enable = lib.mkEnableOption "Enable ncmpcpp configuration";

 config = lib.mkIf config.ncmpcppConfig.enable {
   programs.ncmpcpp = {
     enable = true;
     bindings = [
       { key = "k"; command = "scroll_up"; }
       { key = "j"; command = "scroll_down"; }
       { key = "J"; command = [ "select_item" "scroll_down" ]; }
       { key = "K"; command = [ "select_item" "scroll_up" ]; }
       { key = "l"; command = "next_column"; }
       { key = "h"; command = "previous_column"; }
     ];

     settings = {
       ncmpcpp_directory = "~/.local/share/ncmpcpp";
       mpd_host = "127.0.0.1";

       external_editor = "nvim";
       message_delay_time = 1;
       playlist_disable_highlight_delay = 2;
       autocenter_mode = "yes";
       centered_cursor = "yes";
       ignore_leading_the = "yes";
       allow_for_physical_item_deletion = "no";
       connected_message_on_startup = "no";
       cyclic_scrolling = "yes";
       mouse_support = "no";
       mouse_list_scroll_whole_page = "yes";
       lines_scrolled = 1;
       playlist_shorten_total_times = "yes";
       playlist_display_mode = "columns";
       browser_display_mode = "columns";
       search_engine_display_mode = "columns";
       playlist_editor_display_mode = "columns";
       user_interface = "alternative";
       display_bitrate = "yes";
       startup_screen = "playlist";

       header_visibility = "no";

       media_library_primary_tag = "album_artist";

       progressbar_look = "─╼ ";
       statusbar_visibility = "yes";
       progressbar_color = "black";
       progressbar_elapsed_color = "blue";
       song_list_format = "{%t $8by$9 }{$4(%20a)$9}$R{$3(%20b)$9}";
       song_status_format = "{$b$3%t$9$/b by $b$5%a$9$/b}";
       song_columns_list_format = "(50)[blue]{ar} (50)[green]{t}";
       current_item_prefix = ''$(blue)$r'';
       current_item_suffix = ''$/r$(end)'';

       visualizer_data_source = "/tmp/mpd.fifo";
       visualizer_output_name = "Visualizer";
       visualizer_in_stereo = "no";
       visualizer_type = "ellipse";
       visualizer_fps = 60;
       visualizer_look = "●▮";
       visualizer_color = "33,39,63,75,81,99,117,153,189";

       main_window_color = "default";
       titles_visibility = "no";

       system_encoding = "utf8";
     };
   };
 };
}
