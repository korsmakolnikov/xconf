-- Rounded corners for the conky panel, 14px like the eww pills, with the bg3 border of the
-- eww tooltips. picom does not round conky's override-redirect window, so the window is
-- opaque (own_window_color: conky gives its alpha to the bars and rules too) and this hook
-- clears the four corners outside the rounded rectangle.
require 'cairo'
require 'cairo_xlib'

local function rounded(cr, w, h, r)
  cairo_new_sub_path(cr)
  cairo_arc(cr, w - r, r, r, -math.pi / 2, 0)
  cairo_arc(cr, w - r, h - r, r, 0, math.pi / 2)
  cairo_arc(cr, r, h - r, r, math.pi / 2, math.pi)
  cairo_arc(cr, r, r, r, math.pi, 3 * math.pi / 2)
  cairo_close_path(cr)
end

function conky_background()
  if conky_window == nil then return end
  local w, h, r = conky_window.width, conky_window.height, 14
  local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable,
                                       conky_window.visual, w, h)
  local cr = cairo_create(cs)
  -- corners: the window rectangle minus the rounded one, made fully transparent
  cairo_set_operator(cr, CAIRO_OPERATOR_CLEAR)
  cairo_set_fill_rule(cr, CAIRO_FILL_RULE_EVEN_ODD)
  cairo_rectangle(cr, 0, 0, w, h)
  rounded(cr, w, h, r)
  cairo_fill(cr)
  -- border
  cairo_set_operator(cr, CAIRO_OPERATOR_OVER)
  rounded(cr, w - 0.5, h - 0.5, r)
  cairo_translate(cr, 0.5, 0.5)
  cairo_set_source_rgba(cr, 0x38 / 255, 0x3e / 255, 0x42 / 255, 1)
  cairo_set_line_width(cr, 1)
  cairo_stroke(cr)
  cairo_destroy(cr)
  cairo_surface_destroy(cs)
end
