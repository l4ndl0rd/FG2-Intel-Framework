# Git Workflow

## Initial repository setup

```bash
git init
git add .
git commit -m "Initial FG2 Intel Framework commit"
git branch -M main
git remote add origin https://github.com/<USER>/<REPO>.git
git push -u origin main
```

## Push wiki documentation

Enable Wiki in GitHub, then:

```bash
git clone https://github.com/<USER>/<REPO>.wiki.git FG2-Intel-Framework.wiki
cp wiki/*.md FG2-Intel-Framework.wiki/
cd FG2-Intel-Framework.wiki
git add .
git commit -m "Add framework wiki"
git push
```
