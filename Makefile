
# Find all markdown files
MARKDOWN=$(shell find . -iname "*.md")

# Form all 'html' counterparts
HTML=$(MARKDOWN:.md=.html)

.PHONY: all
all: $(HTML)

%.html: %.md
	pandoc \
	    --standalone \
	    --css style/sakura.css \
	    --css style/main.css \
	    --template=template/template.html \
	    --variable=lastUpdated:$( stat -c %y $< | cut -f 1 -d ' ' ) \
	    --variable=creationDate:$( stat -c %w $< | cut -f 1 -d ' ' ) \
	    --variable=lang:uk \
	    --metadata=pagetitle:"Agreemeeting" \
	    --from gfm \
	    --to html \
	    $< -o $@

.PHONY: clean
clean:
	rm -f $(HTML)
