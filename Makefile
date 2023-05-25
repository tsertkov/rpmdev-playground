.PHONY: *
up:
	vagrant up
build:
	vagrant ssh -c 'cd my-world && make all'
down:
	vagrant destroy