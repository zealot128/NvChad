(tag_name) @tag
(erroneous_end_tag_name) @error
(comment) @comment
(attribute_name) @tag.attribute
(attribute
  (quoted_attribute_value) @string)
(text) @none

((element (start_tag (tag_name) @_tag) (text) @text.title)
 (#match? @_tag "^(h[0-9]|title)$"))

((element (start_tag (tag_name) @_tag) (text) @text.strong)
 (#match? @_tag "^(strong|b)$"))

((element (start_tag (tag_name) @_tag) (text) @text.literal)
 (#match? @_tag "^(code|kbd)$"))

[
 "<"
 ">"
 "</"
 "/>"
] @tag.delimiter

"=" @operator
