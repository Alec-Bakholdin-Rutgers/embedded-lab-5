send:
	git add .
	git commit -m "m"
	git push

recv:
	git stash
	git pull