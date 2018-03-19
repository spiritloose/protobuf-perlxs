# Example: $ docker run --rm -v $(pwd)/examples/simple:/proto -it protobuf-perlxs \
#                sh -c 'cd /proto && protoxs --cpp_out=. --out=. person.proto'
FROM debian:stretch

RUN apt-get update && apt-get install -y autoconf automake make g++ libprotoc-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY . /protobuf-perlxs
WORKDIR /protobuf-perlxs
RUN aclocal && automake --add-missing && autoconf
RUN ./configure && make && make install
WORKDIR /

CMD protoxs --version
