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
RUSTLIB_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/src
RUST_SRC_PATH="${RUSTLIB_PATH}"
export RUST_SRC_PATH
else
echo 'rustc not found.'
echo 'Nothing to do.'
fi