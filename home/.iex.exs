# IEx.configure colors: [enabled: true]
# IEx.configure colors: [eval_result: [:cyan, :bright]]
Application.put_env(:elixir, :ansi_enabled, true)
IEx.configure(
  colors: [
      syntax_colors: [
            number: :light_yellow,
            atom: :light_cyan,
            string: :light_black,
            boolean: :red,
            nil: [:magenta, :bright]
          ],
      ls_directory: :cyan,
      ls_device: :yellow,
      doc_code: :green,
      doc_inline_code: :magenta,
      doc_headings: [:cyan, :underline],
      doc_title: [:cyan, :bright, :underline],
      eval_result: [:green, :bright] ,
      eval_error: [[:red, :bright, "\n▶▶▶\n"]],
      eval_info: [:yellow, :bright ],
    ],
  default_prompt: [
      "\e[G", # cursor ⇒ column 1
      :green, "%prefix", :white, "|", :green, "%counter", " ", :blue, "▶", :reset
    ] |> IO.ANSI.format |> IO.chardata_to_string,
      inspect: [
          pretty: true,
          limit: :infinity,
          width: 80
        ]
)
