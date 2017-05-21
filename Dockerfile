FROM docker.io/library/debian:9

ENV RUST_VERSIONS="1.15.0 1.16.0 1.17.0"

ENV CARGO_HOME=/opt/cargo \
	RUSTUP_HOME=/opt/rust \
	PATH=/opt/cargo/bin:$PATH

RUN apt-get -y update \
	&& apt-get -y install \
		build-essential \
		clang \
		curl \
		gcovr \
		git \
		valgrind \
	&& apt-get -y clean all \
	&& curl https://sh.rustup.rs -sSf | sh -s -- -y

RUN for v in ${RUST_VERSIONS} ; do \
		echo "Installing Rust ${v} ..." ; \
		rustup toolchain install "${v}" || exit ; \
	done
