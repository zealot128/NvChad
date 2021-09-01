; inherits: html_tags

(
  (style_element
    (start_tag
      (attribute
        (quoted_attribute_value (attribute_value) @_lang)))
    (raw_text) @scss)
  (#any-of? @_lang "scss" "postcss" "less")
)

(
  (script_element
    (start_tag
      (attribute
        (quoted_attribute_value (attribute_value) @_lang)))
    (raw_text) @typescript)
  (#any-of? @_lang "ts" "typescript")
)

((interpolation
  (raw_text) @javascript))

((directive_attribute
    (quoted_attribute_value
      (attribute_value) @javascript)))

(
  (template_element
    (start_tag
      (attribute
        (quoted_attribute_value (attribute_value) @_lang)))
    (raw_text) @pug)
  (#any-of? @_lang "pug")
)

(element
 (start_tag
  (tag_name) @_tag_name
  (attribute
   (attribute_name) @_attr_name
   (quoted_attribute_value
    (attribute_value) @_lang
   )
  )
 )
 (text) @yaml
 (#match? @_tag_name "i18n")
 (#match? @_lang "yaml")
 (#match? @_attr_name "lang")
)


(comment) @comment
