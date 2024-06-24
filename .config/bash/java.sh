#!/bin/bash

JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
if [ -d "$JAVA_HOME" ]; then
  export JAVA_HOME
  PATH=$PATH:$JAVA_HOME/bin
  export PATH
fi
