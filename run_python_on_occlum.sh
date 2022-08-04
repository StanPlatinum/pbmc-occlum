#!/bin/bash
set -e

BLUE='\033[1;34m'
NC='\033[0m'

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" >/dev/null 2>&1 && pwd )"
python_dir="$script_dir/occlum_instance/image/opt/python-occlum"

[ -d occlum_instance ] || occlum new occlum_instance

cd occlum_instance && rm -rf image
copy_bom -f ../python-glibc.yaml --root image --include-dir /opt/occlum/etc/template

if [ ! -d $python_dir ];then
    echo "Error: cannot stat '$python_dir' directory"
    exit 1
fi

new_json="$(jq '.resource_limits.user_space_size = "30720MB" |
        .resource_limits.kernel_space_heap_size = "20480MB" |
        .resource_limits.max_num_of_threads = 2048 |
	.process.default_mmap_size = "10240MB" |
	.env.default += ["PYTHONHOME=/opt/python-occlum"]' Occlum.json)" && \
echo "${new_json}" > Occlum.json
occlum build

# Run the python demo
occlum run /bin/python3 classify.py
