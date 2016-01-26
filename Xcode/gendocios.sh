#!/bin/sh
jazzy \
-o ../Documentation/iOS \
-c --swift-version 2.1.1 \
--sdk iphoneos \
--author 'Pierre Tacchi' \
--author_url 'https://github.com/Pyroh/' \
-g 'https://github.com/Pyroh/SwiftMark' \
-m SwiftMark \
--module-version 0.9 \
--readme ../README.md \
--docset-icon ../Documentation/docset_icon.png \
--skip-undocumented 
rm -rf build
