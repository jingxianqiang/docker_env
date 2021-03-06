#!/usr/bin/env bash

set -e
set -x

dummy=$1

# mkdir -p tmp

## read configration
source config.sh

save_docker_image(){
    docker_images=$1
    save_file=$2
    list_file=$3

    cmd_str="docker save "
    while read -r line; do
        if [[ "$line" =~ [^[:space:]] ]] && [[ !  "$line" =~ [\#][:print:]*  ]]; then
            cmd_str+=" $line"
        fi
    done < $list_file

    $cmd_str | pigz -c > $save_file
}

#################################
## pull and dump images

save_docker_image "$ose3_images" "ose3-images.tgz" "ose3-images.list"

save_docker_image "$ose3_optional_imags" "ose3-optional-imags.tgz" "ose3-optional-imags.list"

save_docker_image "$ose3_builder_images" "ose3-builder-images.tgz" "ose3-builder-images.list"

save_docker_image "$cnv_optional_imags" "cnv-optional-images.tgz" "cnv-optional-images.list"

save_docker_image "$istio_optional_imags" "istio-optional-images.tgz" "istio-optional-images.list"

save_docker_image "$docker_builder_images" "docker-builder-images.tgz" "docker-builder-images.list"

save_docker_image "$quay_builder_images" "quayr-builder-images.tgz" "quay-builder-images.list"

##################################

docker image prune -f



