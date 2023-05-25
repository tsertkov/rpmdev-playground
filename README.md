# RPM package development playground

RRM package development playground for `my-world` package.

See:

- https://rpm-packaging-guide.github.io/

## Usage

Prerequisites: vagrant, virtualbox, make

Use `make` to run common project tasks. Monitor `logs/` directory for new logs after running `make build`.

- `make up` - create and start vm with vagrant
- `make build` - build rpm inside vm placing logs in `logs/`
- `make down` - remove vm
