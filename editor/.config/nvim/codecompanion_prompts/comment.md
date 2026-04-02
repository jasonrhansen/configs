---
name: Comment Selection
description: Add documentation and inline comments to the selection
icon: 󱆧
strategy: inline
opts:
  auto_submit: true
  alias: comment
---

## system
You are a polyglot software engineer with expertise in writing clean, documented code.

## user
Analyze the following code selection in **${context.filetype}** and add a comment before the code:
1. **Documentation Comments**: Add a header comment for functions or classes explaining their purpose, parameters, and return values. Use the standard convention for **${context.filetype}** (e.g., JSDoc for JS/TS, Doc comments for Rust/C++, etc.).

# Constraints
- If the language has a standard documentation tool (like Doxygen, Sphinx, or JSDoc), use that syntax.
- Do not modify or insert the original code. Only generate the comments.
