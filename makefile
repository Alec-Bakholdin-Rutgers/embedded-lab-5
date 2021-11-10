send:
	git add .
	git commit -m "m"
	git push

recv:
	git reset --hard
	git pull