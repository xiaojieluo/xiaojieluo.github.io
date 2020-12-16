#!/usr/bin/env sh

set -e

rm -r docs/*
echo "Done: rm -r docs/* \n"

hugo -d docs
echo "Done: hugo \n"

git add .
git commit -m "Blog update at $(date)"
echo "Done: git commit, Blog update at $(date) \n"

git push -u origin main
echo "\nDone: git push -u origin main"
