#!/bin/sh

rm -rf aom-master
git clone https://aomedia.googlesource.com/aom aom-master
mkdir aom-master/build
cd aom-master/build
cmake ..
make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status
cd ~

7z x Bosphorus_1920x1080_120fps_420_8bit_YUV_Y4M.7z

echo "#!/bin/sh
./aom-master/build/aomenc -v --rt --threads=\$NUM_CPU_CORES --tile-columns=2 --limit=20 -o test.av1 Bosphorus_1920x1080_120fps_420_8bit_YUV.y4m > 1.log 2>&1
echo \$? > ~/test-exit-status
sed \$'s/[^[:print:]\t]/\\n/g' 1.log > \$LOG_FILE" > aom-av1
chmod +x aom-av1
