.PHONY: *
up:
	$(info Bringing vagrant vm up)
	@vagrant up
build:
	$(info Running make all command inside vm)
	@vagrant ssh -c 'cd my-world && make all'
down:
	vagrant destroy