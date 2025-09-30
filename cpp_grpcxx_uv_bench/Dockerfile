FROM gcc:latest

RUN apt-get update && apt-get install -y libjemalloc-dev protobuf-compiler \
    cmake libprotobuf-dev

# Download grpcxx and build it
WORKDIR /tmp
RUN wget https://github.com/uatuko/grpcxx/archive/refs/tags/v0.6.2.tar.gz \
    && tar -xzf v0.6.2.tar.gz \
    && cd grpcxx-0.6.2 \
    && cmake -B build -DCMAKE_BUILD_TYPE=Release -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
    && cmake --build build -j$(nproc) \
    && cmake --install build --prefix=/usr/local \
    && ldconfig

WORKDIR /app
COPY cpp_grpcxx_uv_bench /app
COPY proto /app/proto

RUN mkdir gen && \
    protoc --proto_path=/app/proto/helloworld --cpp_out=gen helloworld.proto && \
    protoc --proto_path=/app/proto/helloworld --grpc_out=gen --plugin=protoc-gen-grpc=`which grpc_cpp_plugin` helloworld.proto
RUN g++ -O3 -flto main.cpp gen/helloworld.grpc.pb.cc gen/helloworld.pb.cc -Igen $(pkg-config --cflags --libs grpcxx)

ENTRYPOINT /app/a.out
