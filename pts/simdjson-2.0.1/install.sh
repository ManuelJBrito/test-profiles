#!/bin/sh

rm -rf simdjson-2.0.4
tar -xf simdjson-2.0.4.tar.gz
cd simdjson-2.0.4
mkdir build
cd build

cmake .. -DCMAKE_BUILD_TYPE=Release -DSIMDJSON_JUST_LIBRARY=OFF -DCMAKE_CROSSCOMPILING=1 -DHAVE_STD_REGEX=0 -DHAVE_POSIX_REGEX=0 -DHAVE_GNU_POSIX_REGEX=0 -DHAVE_STEADY_CLOCK=0 -DHAVE_THREAD_SAFETY_ATTRIBUTES=0

make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status
cd ~

echo "#!/bin/sh
cd simdjson-2.0.4/build/benchmark
./bench_ondemand --benchmark_min_time=30 --benchmark_filter=\$@\<simdjson_ondemand\> > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > simdjson
chmod +x simdjson
