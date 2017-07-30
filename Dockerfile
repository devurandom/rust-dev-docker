FROM quay.io/devurandom/c-dev:debian9-2

ENV RUST_VERSIONS="1.15.0 1.16.0 1.17.0 1.18.0 1.19.0"

ENV CARGO_HOME=/opt/cargo \
	RUSTUP_HOME=/opt/rust \
	PATH=/opt/cargo/bin:$PATH

RUN /bin/bash -c \
	"apt-get -y update \
	&& apt-get -y install \
		clang \
		curl \
	&& apt-get -y clean all \
	&& set -o pipefail \
	&& curl --fail --silent --show-error https://sh.rustup.rs | sh -s -- -y"

RUN for v in ${RUST_VERSIONS} ; do \
		echo "Installing Rust ${v} ..." ; \
		rustup toolchain install "${v}" || exit ; \
	done

RUN echo "Installing binaries with Cargo ..." ; \
	rustup run "${v}" cargo install cargo-test-junit --vers=0.6.1 || exit
