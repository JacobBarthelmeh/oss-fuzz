#!/bin/bash -eu
# Copyright 2016 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
################################################################################

cmake . -DCMAKE_INSTALL_PREFIX=$WORK -DENABLE_STATIC:bool=on
make "-j$(nproc)"
make install

$CXX $CXXFLAGS -std=c++11 -I. \
    $SRC/libjpeg_turbo_fuzzer.cc -o $OUT/libjpeg_turbo_fuzzer \
    -lFuzzingEngine "$WORK/lib/libturbojpeg.a"

cp $SRC/libjpeg_turbo_fuzzer_seed_corpus.zip $OUT/
