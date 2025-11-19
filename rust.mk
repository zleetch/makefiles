.ONESHELL:
.SHELL := /bin/bash

.PHONY:  help install rup cup uninstall plugins

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

init:
	@curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

components: rup
	@rustup component add clippy rust-docs rust-analyzer miri

plugins: ##Install plugins
	@cargo +stable install --locked cargo-binstall cargo-geiger cargo-udeps cargo-hack flamegraph criterion cargo-bloat cargo-outdated \
	  cargo-machete cargo-fuzz cargo-mutants cargo-audit cargo-deny cargo-watch

install: init components ##Install rust and components

rup: ##Update rust
	@rustup update

cup: ##Update cargo
	@cargo update

uninstall: ##Uninstall rust
	@rustup self uninstall