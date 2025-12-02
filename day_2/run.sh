#!/bin/sh

odin build main.odin -file -out:main && ./main $1
