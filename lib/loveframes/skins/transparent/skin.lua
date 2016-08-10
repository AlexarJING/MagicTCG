--[[------------------------------------------------
	-- Love Frames - A GUI library for LOVE --
	-- Copyright (c) 2012-2014 Kenny Shields --
--]]------------------------------------------------

-- get the current require path
local path = string.sub(..., 1, string.len(...) - string.len(".skins.transparent.skin"))
local loveframes = require(path .. ".libraries.common")

-- skin table
local skin = {}

-- skin info (you always need this in a skin)
skin.name = "transparent"
skin.author = "Alex JING"
skin.version = "0.1"
skin.base = "Blue"

local smallfont = loveframes.basicfontsmall
local imagebuttonfont = loveframes.basicfontbig
local bordercolor = {143, 143, 143, 255}

-- add skin directives to this table
skin.directives = {}

-- controls 
skin.controls = {}

-- frame
skin.controls.frame_body_color                      = {232, 232, 232, 255}
skin.controls.frame_name_color                      = {255, 255, 255, 255}
skin.controls.frame_name_font                       = smallfont

-- button
skin.controls.button_text_down_color                = {255, 255, 255, 255}
skin.controls.button_text_nohover_color             = {0, 0, 0, 200}
skin.controls.button_text_hover_color               = {255, 255, 255, 255}
skin.controls.button_text_nonclickable_color        = {0, 0, 0, 100}
skin.controls.button_text_font                      = smallfont

-- imagebutton
skin.controls.imagebutton_text_down_color           = {255, 255, 255, 255}
skin.controls.imagebutton_text_nohover_color        = {255, 255, 255, 200}
skin.controls.imagebutton_text_hover_color          = {255, 255, 255, 255}
skin.controls.imagebutton_text_font                 = imagebuttonfont

-- closebutton
skin.controls.closebutton_body_down_color           = {255, 255, 255, 255}
skin.controls.closebutton_body_nohover_color        = {255, 255, 255, 255}
skin.controls.closebutton_body_hover_color          = {255, 255, 255, 255}

-- progressbar
skin.controls.progressbar_body_color                = {255, 255, 255, 255}
skin.controls.progressbar_text_color                = {0, 0, 0, 255}
skin.controls.progressbar_text_font                 = smallfont

-- list
skin.controls.list_body_color                       = {232, 232, 232, 255}

-- scrollarea
skin.controls.scrollarea_body_color                 = {220, 220, 220, 255}

-- scrollbody
skin.controls.scrollbody_body_color                 = {0, 0, 0, 0}

-- panel
skin.controls.panel_body_color                      = {232, 232, 232, 255}

-- tabpanel
skin.controls.tabpanel_body_color                   = {232, 232, 232, 255}

-- tabbutton
skin.controls.tab_text_nohover_color                = {0, 0, 0, 200}
skin.controls.tab_text_hover_color                  = {255, 255, 255, 255}
skin.controls.tab_text_font                         = smallfont

-- multichoice
skin.controls.multichoice_body_color                = {240, 240, 240, 255}
skin.controls.multichoice_text_color                = {0, 0, 0, 255}
skin.controls.multichoice_text_font                 = smallfont

-- multichoicelist
skin.controls.multichoicelist_body_color            = {240, 240, 240, 200}

-- multichoicerow
skin.controls.multichoicerow_body_nohover_color     = {240, 240, 240, 255}
skin.controls.multichoicerow_body_hover_color       = {51, 204, 255, 255}
skin.controls.multichoicerow_text_nohover_color     = {0, 0, 0, 150}
skin.controls.multichoicerow_text_hover_color       = {255, 255, 255, 255}
skin.controls.multichoicerow_text_font              = smallfont

-- tooltip
skin.controls.tooltip_body_color                    = {255, 255, 255, 255}

-- textinput
skin.controls.textinput_body_color                  = {250, 250, 250, 255}
skin.controls.textinput_indicator_color             = {0, 0, 0, 255}
skin.controls.textinput_text_normal_color           = {0, 0, 0, 255}
skin.controls.textinput_text_placeholder_color      = {127, 127, 127, 255}
skin.controls.textinput_text_selected_color         = {255, 255, 255, 255}
skin.controls.textinput_highlight_bar_color         = {51, 204, 255, 255}

-- slider
skin.controls.slider_bar_outline_color              = {220, 220, 220, 255}

-- checkbox
skin.controls.checkbox_body_color                   = {255, 255, 255, 255}
skin.controls.checkbox_check_color                  = {128, 204, 255, 255}
skin.controls.checkbox_text_font                    = smallfont

-- radiobutton
skin.controls.radiobutton_body_color                = {255, 255, 255, 255}
skin.controls.radiobutton_check_color               = {128, 204, 255, 255}
skin.controls.radiobutton_inner_border_color        = {77, 184, 255, 255}
skin.controls.radiobutton_text_font                 = smallfont

-- collapsiblecategory
skin.controls.collapsiblecategory_text_color        = {255, 255, 255, 255}

-- columnlist
skin.controls.columnlist_body_color                 = {232, 232, 232, 255}

-- columlistarea
skin.controls.columnlistarea_body_color             = {232, 232, 232, 255}

-- columnlistheader
skin.controls.columnlistheader_text_down_color      = {255, 255, 255, 255}
skin.controls.columnlistheader_text_nohover_color   = {0, 0, 0, 200}
skin.controls.columnlistheader_text_hover_color     = {255, 255, 255, 255}
skin.controls.columnlistheader_text_font            = smallfont

-- columnlistrow
skin.controls.columnlistrow_body1_color             = {245, 245, 245, 255}
skin.controls.columnlistrow_body2_color             = {255, 255, 255, 255}
skin.controls.columnlistrow_body_selected_color     = {26, 198, 255, 255}
skin.controls.columnlistrow_body_hover_color        = {102, 217, 255, 255}
skin.controls.columnlistrow_text_color              = {100, 100, 100, 255}
skin.controls.columnlistrow_text_hover_color        = {255, 255, 255, 255}
skin.controls.columnlistrow_text_selected_color     = {255, 255, 255, 255}

-- modalbackground
skin.controls.modalbackground_body_color            = {255, 255, 255, 100}

-- linenumberspanel
skin.controls.linenumberspanel_text_color           = {170, 170, 170, 255}
skin.controls.linenumberspanel_body_color			= {235, 235, 235, 255}

-- grid
skin.controls.grid_body_color                       = {230, 230, 230, 255}

-- form
skin.controls.form_text_color                       = {0, 0, 0, 255}
skin.controls.form_text_font                        = smallfont

-- menu
skin.controls.menu_body_color                       = {255, 255, 255, 255}

-- menuoption
skin.controls.menuoption_body_hover_color           = {51, 204, 255, 255}
skin.controls.menuoption_text_hover_color           = {255, 255, 255, 255}
skin.controls.menuoption_text_color                 = {180, 180, 180, 255}

-- register the skin
loveframes.skins.Register(skin)
