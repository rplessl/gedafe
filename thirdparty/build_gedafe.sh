#!/bin/bash

export PATH=$PREFIX/bin:$PATH

. `dirname $0`/sdbs.inc

perlmodule CGI
perlmodule CGI::Fast
perlmodule FCGI
perlmodule YAML::XS 
