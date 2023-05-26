NAME=(rpmdev)
.PHONY: *
up:
	$(info $(NAME) Bringing vagrant vm up)
	@vagrant up
build:
	$(info $(NAME) Running make all command inside vm)
	@vagrant ssh -c 'cd my-package && make all'
down:
	$(info $(NAME) Destroying vagrant vm)
	@vagrant destroy -f
clean:
	$(info $(NAME) Removing all files in logs/ directory)
	@rm -rf ./logs/*
