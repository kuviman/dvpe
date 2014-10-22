rm -r docs
cp -r ~/.dub/packages/ddox-0.10.0/public docs
dub build --config=buildDocs
~/.dub/packages/ddox-0.10.0/ddox generate-html docs.json docs
rm docs.json
rm __dummy.html
