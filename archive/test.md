<!-- 
Test to check how header links are generated when 
`code ticks` are included in the header title
--> 
# Header 1
```bash
test.md#header-1
```

## Header 2 `code`
```bash
test.md#header-2-code
```

## `Header 2 code`
```bash
test.md#header-2-code-1
```

### Header 3 `code` and `--code`
```bash
header-3-code-and---code
```

### `Header 3` and XYZ
```bash
test.md#header-3-and-xyz
```

## `Header 2 code` and `code`
```bash
test.md#header-2-code-and-code
```

> **Conclusion**: `code ticks` (i.e. \`example\`) don't show up in header links and can/should be used in the guide

<!-- EOF -->