git clone https://github.com/obvionaoe/docker-ghz.git
cd docker-ghz && docker build -t ghcr.io/bojand/ghz:0.114.0 /. && cd ..
./build.sh cpp_grpc_bench cpp_grpc_aca_bench node_grpcjs_st_bench rust_pajamax_bench go_grpc_bench
GRPC_SERVER_CPUS=4 GRPC_SERVER_RAM=8g GRPC_CLIENT_CPUS=4 ./bench.sh cpp_grpc_bench cpp_grpc_aca_bench cpp_grpc_mt_bench node_grpcjs_st_bench rust_pajamax_bench go_grpc_bench