-- 1px bg3 border around the conky panel, like the eww pills; picom rounds the window
-- (corner-radius 14), the border follows the same radius.
require 'cairo'
require 'cairo_xlib'

function conky_background()
  if conky_window == nil then return end
  local w, h, r = conky_window.width - 1, conky_window.height - 1, 14
  local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable,
                                       conky_window.visual, conky_window.width, conky_window.height)
  local cr = cairo_create(cs)
  cairo_translate(cr, 0.5, 0.5)
  cairo_new_sub_path(cr)
  cairo_arc(cr, w - r, r, r, -math.pi / 2, 0)
  cairo_arc(cr, w - r, h - r, r, 0, math.pi / 2)
  cairo_arc(cr, r, h - r, r, math.pi / 2, math.pi)
  cairo_arc(cr, r, r, r, math.pi, 3 * math.pi / 2)
  cairo_close_path(cr)
  cairo_set_source_rgba(cr, 0x38 / 255, 0x3e / 255, 0x42 / 255, 1) -- bg3
  cairo_set_line_width(cr, 1)
  cairo_stroke(cr)
  cairo_destroy(cr)
  cairo_surface_destroy(cs)
end
