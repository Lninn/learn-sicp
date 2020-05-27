FROM gitpod/workspace-full
                    
RUN sudo apt-get -q update && sudo apt-get -yq install mit-scheme rlwrap

ENV sicp="rlwrap scheme"
# Install custom tools, runtime, etc. using apt-get
# For example, the command below would install "bastet" - a command line tetris clone:
#
# RUN sudo apt-get -q update && #     sudo apt-get install -yq bastet && #     sudo rm -rf /var/lib/apt/lists/*
#
# More information: https://www.gitpod.io/docs/42_config_docker/
