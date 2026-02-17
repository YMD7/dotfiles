# AGENT.md

ユーザーには日本語で応答してください。

## CLI Tools

This environment has modern CLI tools installed. Prefer these over traditional commands:

| Traditional | Modern    | Usage                          |
|-------------|-----------|--------------------------------|
| `ls`        | `eza`     | `eza --icons --git`            |
| `cat`       | `bat`     | `bat --paging=never`           |
| `grep`      | `rg`      | `rg <pattern>`                 |
| `find`      | `fd`      | `fd <pattern>`                 |
| `du`        | `dust`    | `dust`                         |
| `sed`       | `sd`      | `sd <from> <to>`               |
| `diff`      | `delta`   | Configured as git pager        |
| `top`       | `btop`    | `btop`                         |
| `cd`        | `z`       | `z <partial-path>` (zoxide)    |

## JSON Tools

`jq` and `fx` are available for JSON processing:

| Tool | Usage                              |
|------|------------------------------------|
| `jq` | `jq '<filter>' file.json`         |
| `fx` | `fx file.json` (interactive viewer)|
