send:
	git add .
	git commit -m "m"
	git push

recv:
	git fetch --all
	git branch -D backup-main
	git branch backup-main
	git reset --hard origin/main