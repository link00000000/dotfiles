;;extends

((source_file
  (comment) @injection.content (#offset! @injection.content 1 0 -1 0)
  (import_declaration
    (import_spec
      path: (interpreted_string_literal) @_path (#eq? @_path "\"C\""))))
 (#set! injection.language "c")
)

