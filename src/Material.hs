{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Material where

import Lucid.Base
import Paths_web_material (version)
import XStatic.TH (XStaticFile, embedXStaticFileVersion)

materialJs, materialJsMap :: XStaticFile
materialJs = $(embedXStaticFileVersion "data/material.js.gz" version)
materialJsMap = $(embedXStaticFileVersion "data/material.js.map.gz" version)

md_checkbox_ :: Applicative m => [Attribute] -> HtmlT m ()
md_checkbox_ = with (makeElement "md-checkbox" mempty)

md_outlined_button_ :: Term arg result => arg -> result
md_outlined_button_ = term "md-outlined-button"

md_filled_button_ :: Term arg result => arg -> result
md_filled_button_ = term "md-filled-button"
