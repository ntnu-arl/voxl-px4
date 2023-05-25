#!/bin/bash

# Run this from the px4 project top level directory
docker run -it --rm -v `pwd`:/usr/local/workspace -w /usr/local/workspace px4io/px4-dev-nuttx-focal:2022-08-12 
