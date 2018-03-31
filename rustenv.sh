which cargo > /dev/null 2>\&1
#cargoでインストールしたコマンドのパスを環境変数に追加する。
if [ $? -eq 0 ]; then
PATH=$PATH:${HOME}/.cargo/bin
export PATH
else
echo 'Cargo not found.'
echo 'Nothing to do.'
fi

which rustc > /dev/null 2>\&1
if [ $? -eq 0 ]; then
TEMP_DIR="/tmp"
SRC_DIR_TEMP1="${TEMP_DIR}/src_dir.tmp1"
SRC_DIR_TEMP2="${TEMP_DIR}/src_dir.tmp2"
SRC_DIR_TEMP3="${TEMP_DIR}/src_dir.tmp3"
SRC_DIR_TEMP4="${TEMP_DIR}/src_dir.tmp4"
SRC_DIR_TEMP5="${TEMP_DIR}/src_dir.tmp5"
echo -n "" > ${SRC_DIR_TEMP1}
#rustのソースがインストールされる場所と、ライブラリのソースがインストールされる場所を捜索してsrcフォルダを全部探す。
find "/usr/share/cargo/registry" -name "src" -type d  >> ${SRC_DIR_TEMP1}
find "$HOME/.cargo/registry" -name "src" -type d  >> ${SRC_DIR_TEMP1}
cat ${SRC_DIR_TEMP1} | sort | uniq > ${SRC_DIR_TEMP2}
#見つけたパスをコロンで区切って環境変数に追加する。
sed 's/$/:/g' ${SRC_DIR_TEMP2} > ${SRC_DIR_TEMP3}
sed '$s/.$//' ${SRC_DIR_TEMP3} > ${SRC_DIR_TEMP4}
sed -n 'H;${x;s/\n//g;s/^ //;p}' ${SRC_DIR_TEMP4} > ${SRC_DIR_TEMP5}
SRCS=`cat ${SRC_DIR_TEMP5}`
RUSTLIB_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src
RUST_SRC_PATH="${RUSTLIB_PATH}:${SRCS}"
export RUST_SRC_PATH
else
echo 'rustc not found.'
echo 'Nothing to do.'
fi