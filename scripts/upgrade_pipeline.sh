#!/usr/bin/env bash

# This script upgrade the pipeline to the latest version.

set -xe

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null && pwd)"
ENV_FILE="env.sh"

source ${ENV_FILE}
export KUBEFLOW_KS_DIR=${KUBEFLOW_KS_DIR:-"$(pwd)/ks_app"}

pushd ${KUBEFLOW_KS_DIR}

ks param list pipeline
# Add the kubeflow pipeline branch as a registry
ks registry add kfp https://github.com/kubeflow/kubeflow/tree/pipelines/kubeflow

ks pkg remove kubeflow/pipeline
ks component rm pipeline

# export GITHUB_TOKEN=[token]if hit rate limit
# or ks pkg install kubeflow/pipeline@hash_for_specific_version
ks pkg install kfp/pipeline
ks generate pipeline pipeline


# set parameter
# reset registry back to normal
# ks param list pipeline

popd