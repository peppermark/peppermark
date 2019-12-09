= Peppermark

== Introduction

- Human and Machine Readable Plaintext
    - Simple, unobtrusive syntax
    - Well-defined and checked (comprehensible errors and warnings are
        encouraged)
    - Block-structured
    - Unambiguous by design
- Easy to Learn, Read, Write, Distribute
    - Simple and consistent syntax
    - Convertable and extendable to any file format (focus on HTML and LaTeX)
    - Provide maintainability through imports and variables
    - Generate table of contents, citations and footnotes
- Flexible Presentation
    - Utilize custom styles
    - Support for icons

Markdown can be awesome. We enjoy using it and like many other tools for
programmers, this format accompanies us almost daily. Everyone picks it up
really quickly. We find endless support for different applications. Sometimes,
however, details in the markdown syntax are just completely unintuitive, it can
be really unpleasant to parse and extract data from a text and in order to do so
some libraries even convert it to HTML (or another format) before processing it.
With this project we want to tackle these main problems but most importantly
define a format that works for our purposes.

The biggest inspiration of this project is of couse markdown. Other Markup
languages that shaped this specification in any form are listed below:

- Creole
- BBCode
- Textile
- reStructuredText

== General

Peppermark structures any document as a set of blocks and inlines. Multiple
whitespace characters are mostly ignored and do not have any purpose in the
context of parsing.

Most blocks (with the exception of code blocks and multi-line commentaries) end
automatically with an empty line.  Blocks can contain other blocks or inline
content elements. All special elements (blocks and inline) can be escaped with a
backslash. Some special characters will be automatically converted to a
different format to prevent issues for the renderers.

All blocks can be sorted into either one of following the categories:
- leaf blocks
- container blocks

== Leaf Blocks

=== Thematic break

A typical thematic break would render as a <hr> elements in plain HTML. These
could be used to separate chapters or paragraphs on a high level of
abstraction.

Three or more consecutive hyphen characters in a line form a thematic break. An
empty line has to be before and after this element and spaces in front of the
characters are allowed.

```

---

  ---

----------

```

=== Heading

Headings start with 1 or more = characters followed by one strict space. The
level 1 heading (the title) starts with =, section headings with ==, subheads
with ===, and so on. The maximum nesting layer is limited to 6 headings. An
empty line has to be before and after this element and spaces in front of the
characters are NOT allowed.

```

= Heading 1

== Heading 2

=== Heading 3

==== Heading 4

===== Heading 5

====== Heading 6

```

=== Code block

A code fence is a sequence of three consecutive backtick characters. The content
of the code block consists of all subsequent lines, until a closing code fence
is found. An empty line has to be before the start and after the end of the code
block and spaces in front of the fence characters are NOT allowed.

Optionally, the line with the opening code fence may contain some text following
the code fence referring to a highlight scheme to be applied (if possible).

All characters inside a code block are treated as literal text, not parsed as
inlines.

```
\``` bash
#! /bin/bash
# script to turn the screen blue
setterm -background blue
echo It is a blue day
\```
```

=== Math block

```
$$$
x = {-b \pm \sqrt{b^2-4ac} \over 2a}.
$$$
```

=== Comment block

´´´
/*
This part will be ignored while parsing.
 */
´´´

=== Table

```
[!table]
[[
  -
    -
    - First Header
    - Second Header
    - Third Header
  -
    - Line 1
    - Content 1
    - Content 2
    - Content 3
  -
    - Line 2
    - Content A
    - Content B
    - Content C
]]
```

Result in the following table:

```
           | First Header | Second Header | Third Header |
-----------|--------------|---------------|--------------|
Line 1     | Content 1    | Content 2     | Content 3    |
Line 2     | Content A    | Content B     | Content C    |
```

With the option `pivot` the definition of the table will be column-wise:

```
[!table | pivot]
[[
  -
    -
    - First Header
    - Second Header
    - Third Header
  -
    - Column 1
    - Content 1
    - Content 2
    - Content 3
  -
    - Column 2
    - Content A
    - Content B
    - Content C
]]
```

```
              | Column 1     | Column 2     |
--------------|--------------|--------------|
First Header  | Content 1    | Content A    |
Second Header | Content 2    | Content B    |
Third Header  | Content 3    | Content C    |
```

=== Paragraph

A sequence of non-blank lines that cannot be interpreted as other kinds of
blocks forms a paragraph. The paragraph’s raw content is formed by
concatenating the lines and removing initial and final whitespace of every line. An empty line
has to be before and after this element.

== Container block

A container block is a block that has other blocks as its contents.

=== Block quote

An empty line before and after the element defines the extension of the block.

```
|| Blockquote
The content on this next line will still be a part of the same quote.

This here will not be part of the quote.
```

=== Unordered list

```
- unordered list item 1
- unordered list item 2
```

=== Ordered list

```
# ordered list item 1
# ordered list item 2
```

=== Task list

```
-[ ] unchecked task list item
-[x] checked task list item
-[~] partial checked task list item
```

== Inlines

Inlines are parsed sequentially from the beginning of the character stream to
the end.

=== Backslash escape

Escaped characters are treated as regular characters and do not have their usual
Peppermark meanings. If a backslash is itself escaped, the following character
is not. A backslash at the end of the line is a hard line break. Backslash
escapes do not work in code blocks, code spans, math blocks or comments.

=== Code span

```
``inline code span``
```

=== Math span

```
$$inline math span$$
```

=== Emphasis/italics

```
~~italics~~
```

=== Strong emphasis/bold font

```
**bold**
```

=== Underline

```
__underline__**__
```

=== Strikethrough

```
--strikethrough--
```

=== Link

```
[!link www.link.com]
[www.link.com]
[www.link.com | content]
```

=== Image

```
[!image www.image.com]
[!image img/file.png]
[!image www.image.com | image caption)
```

=== Video

```
[!video www.video.com]
[!video file.mp4]
[!video www.video.com | video caption)
```

=== Audio

```
[!audio www.audio.com]
[!audio file.mp3]
[!audio www.audio.com | audio caption)
```

=== Variable

```
[!var $my-variable | www.url.com]

// usage
[$myVariable | content]
[!link $myVariable | content]
[!video $myVariable | content]
```

=== Citation

```
[!cite | citation]
```

=== Footnote

```
[!footnote | content]
```

=== Property

```
[!prop name | content]
```

== Miscellaneous

=== Style imports

```
[!style css/style.css]
```

=== File imports

```
[!import chapters/chapter2.pep]
```

=== Metadata

```
---
Title:      Peppermark Demo
Author:     John Doe
Date:       _
Heroimage:  img/hero.png
Tags:
    - markup language
    - peppermark
    - demonstration
---
```

=== Table of contents

```
[!toc]
[!table-of-contents]
```

=== Forced Linebreak

```
paragraph 1\
still paragraph 1     \
still still paragraph 1
```

=== Automatic conversion

Depending on the concrete peppermark writer, some automatic conversions might
happen inline:

- Quotation marks (&#8220; and &#8221;)
- Apostrophes (&#8216; and &#8217;)
- Ampersand (&amp;)
- Angle brackets (&lt; and &gt;)
- Hyphen between whitespaces (&#8211;)
- Double hyphens (&#8212;)
- Three periods (&#8230;)
- Trademark (tm)
- Registered (R)
- Copyright (C)
- Non-breaking~space
