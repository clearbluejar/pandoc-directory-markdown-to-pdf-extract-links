# Pandoc Directory to PDF with URL link extractor

A simple repo to remind me how to convert markdown files to PDFs and also generate a references pdf.

## Setup

1. Install [Pandoc](https://pandoc.org/)

## Use

1. Open terminal.
2. Convert Markdown to PDF

```bash
for f in *.md; 
    do pandoc "$f" -o "${f%.md}.pdf" 
done
```

3. Extract all links with [extract-links.lua](extract-links.lua)

```bash
for f in $(find markdown_files -type f -name "*.md"); 
    do pandoc "$f" -o "${f%.md}.refs.pdf"  --lua-filter=extract-links.lua
done
```


### Single
Create links PDF from markdown file. 

```bash
pandoc markdown_files/test.md -o test.refs.pdf --pdf-engine=xelatex --lua-filter=extract-links.lua
```
