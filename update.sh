keepass
hugo -d gitcafe -t casper
cd gitcafe/
git add -A
git commit -m"`date -u`"
git push
cd ..
git submodule update
git add -A
git commit -m"`date -u`"
git push
