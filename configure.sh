#!/bin/bash
declare readonly SCRIPTE_NAME="rmts"
declare readonly VERSION=0.1~
declare readonly DEFAULT_SIZE=1000
declare readonly DEFAULT_BIN="$HOME/.local/bin"
declare readonly DEFAULT_PATH="$HOME/.trash"

declare bin=$DEFAULT_BIN
declare trash=$DEFAULT_PATH
declare max_size=$DEFAULT_SIZE

for arg in "$@"; do
    case "${arg%%=*}" in
        "-b" | "--local_bin") bin=${arg#*=};;
        "-t" | "--local_trash") trash=${arg#*=};;
        "-s" | "--max_size") max_size=${arg#*=};;
    esac
done

# -b=, --local_bin=
# -t=, --local_trash=
# -s=, --max_size=

if [ ! -e $bin ]; then
    mkdir $bin
fi

if [ ! -e $trash ]; then
    mkdir $trash
fi

cat <<EOF > $bin/$SCRIPTE_NAME
#!/bin/bash

GLABLE_TRASH_DIR=$bin
DEFAULT_SIZE=$max_size

if [ \`du $GLABLE_TRASH_DIR | awk '{ print $1 }'\` -lt $DEFAULT_SIZE ]; then
        if [ "$#" != 0 ]; then
                tar -czf $HOME/.trash/`date "+%m-%d-%Y-%H-%M-%S"`.tar.gz $@ && rm -rf $@
        fi
else
        echo "error: '$GLABLE_TRASH_DIR' Storage capacity is full"
fi
EOF

chmod +x $bin/SCRIPTE_NAME
