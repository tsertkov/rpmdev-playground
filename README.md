# my-world

Aka "hello-world". RRM package development playground.

See:

- https://rpm-packaging-guide.github.io/

## Usage

Prerequisites: vagrant, virtualbox, make

Use `make` to run common project tasks. Monitor `logs/` directory for new logs after running `make build`.

- `make up` - create and start vm with vagrant
- `make build` - build rpm inside vm with make
- `make down` - remove vm
