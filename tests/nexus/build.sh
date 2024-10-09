#!/bin/bash
#
#  Copyright (c) 2024, The OpenThread Authors.
#  All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions are met:
#  1. Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
#  2. Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in the
#     documentation and/or other materials provided with the distribution.
#  3. Neither the name of the copyright holder nor the
#     names of its contributors may be used to endorse or promote products
#     derived from this software without specific prior written permission.
#
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
#  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
#  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
#  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
#  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
#  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
#  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
#  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
#  POSSIBILITY OF SUCH DAMAGE.
#

display_usage()
{
    echo ""
    echo "Nexus build script "
    echo ""
    echo ""
}

die()
{
    echo " *** ERROR: " "$*"
    exit 1
}

cd "$(dirname "$0")" || die "cd failed"
cd ../.. || die "cd failed"

if [ -n "${top_builddir}" ]; then
    top_srcdir=$(pwd)
    mkdir -p "${top_builddir}"
else
    top_srcdir=.
    top_builddir=.
fi

echo "===================================================================================================="
echo "Building OpenThread Nexus test platform"
echo "===================================================================================================="
cd "${top_builddir}" || die "cd failed"
cmake -GNinja -DOT_PLATFORM=nexus -DOT_COMPILE_WARNING_AS_ERROR=ON \
    -DOT_MULTIPLE_INSTANCE=ON \
    -DOT_THREAD_VERSION=1.4 -DOT_APP_CLI=OFF -DOT_APP_NCP=OFF -DOT_APP_RCP=OFF \
    -DOT_PROJECT_CONFIG=../tests/nexus/openthread-core-nexus-config.h \
    "${top_srcdir}" || die
ninja || die

exit 0
