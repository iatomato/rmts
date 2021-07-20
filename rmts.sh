#!/bin/bash

declare readonly GLABLE_TRASH_DIR=$HOME/.trash
declare readonly DEFAULT_SIZE=1000

if [ ! -e ${GLABLE_TRASH_DIR} ]; then
        mkdir ${GLABLE_TRASH_DIR}
fi

if [ `du ${GLABLE_TRASH_DIR} | awk '{ print $1 }'` -lt ${DEFAULT_SIZE} ]; then
        if [ "$#" != 0 ]; then
                tar -czf $HOME/.trash/`date "+%m-%d-%Y-%H-%M-%S"`.tar.gz $@ && rm -rf $@
        fi
else
        echo "error: '${GLABLE_TRASH_DIR}' Storage capacity is full"
fi
