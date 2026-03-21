#!/usr/bin/env bash
set -Eeuo pipefail

source /venv/main/bin/activate

WORKSPACE="${WORKSPACE:-/workspace}"
COMFYUI_DIR="${WORKSPACE}/ComfyUI"
CUSTOM_NODES_DIR="${COMFYUI_DIR}/custom_nodes"

echo "=== ComfyUI запускает PHOTO GENERATOR ==="

APT_PACKAGES=(
    git
    curl
    wget
)

PIP_PACKAGES=()

NODES=(
    "[github.com](https://github.com/ltdrdata/ComfyUI-Manager)"
    "[github.com](https://github.com/kijai/ComfyUI-WanVideoWrapper)"
    "[github.com](https://github.com/ltdrdata/ComfyUI-Impact-Pack)"
    "[github.com](https://github.com/pythongosssss/ComfyUI-Custom-Scripts)"
    "[github.com](https://github.com/chflame163/ComfyUI_LayerStyle)"
    "[github.com](https://github.com/rgthree/rgthree-comfy)"
    "[github.com](https://github.com/yolain/ComfyUI-Easy-Use)"
    "[github.com](https://github.com/numz/ComfyUI-SeedVR2_VideoUpscaler)"
    "[github.com](https://github.com/cubiq/ComfyUI_essentials)"
    "[github.com](https://github.com/ClownsharkBatwing/RES4LYF)"
    "[github.com](https://github.com/chrisgoringe/cg-use-everywhere)"
    "[github.com](https://github.com/ltdrdata/ComfyUI-Impact-Subpack)"
    "[github.com](https://github.com/Smirnov75/ComfyUI-mxToolkit)"
    "[github.com](https://github.com/TheLustriVA/ComfyUI-Image-Size-Tools)"
    "[github.com](https://github.com/ZhiHui6/zhihui_nodes_comfyui)"
    "[github.com](https://github.com/kijai/ComfyUI-KJNodes)"
    "[github.com](https://github.com/crystian/ComfyUI-Crystools)"
    "[github.com](https://github.com/jnxmx/ComfyUI_HuggingFace_Downloader)"
    "[github.com](https://github.com/plugcrypt/CRT-Nodes)"
    "[github.com](https://github.com/EllangoK/ComfyUI-post-processing-nodes)"
    "[github.com](https://github.com/Fannovel16/comfyui_controlnet_aux)"
    "[github.com](https://github.com/Starnodes2024/ComfyUI_StarNodes)"
    "[github.com](https://github.com/DesertPixelAi/ComfyUI-Desert-Pixel-Nodes)"
)

CLIP_MODELS=(
    "[huggingface.co](https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/text_encoders/qwen_3_4b.safetensors)"
)

CKPT_MODELS=(
    "[huggingface.co](https://huggingface.co/cyberdelia/CyberRealisticPony/resolve/main/CyberRealisticPony_V15.0_FP32.safetensors)"
)

FUN_MODELS=(
    "[huggingface.co](https://huggingface.co/arhiteector/zimage/resolve/main/Z-Image-Turbo-Fun-Controlnet-Union.safetensors)"
)

TEXT_ENCODERS=(
    "[huggingface.co](https://huggingface.co/UmeAiRT/ComfyUI-Auto_installer/resolve/refs%2Fpr%2F5/models/clip/umt5-xxl-encoder-fp8-e4m3fn-scaled.safetensors)"
)

UNET_MODELS=(
    "[huggingface.co](https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/diffusion_models/z_image_turbo_bf16.safetensors)"
)

VAE_MODELS=(
    "[huggingface.co](https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/vae/ae.safetensors)"
)

DIFFUSION_MODELS=(
    "[huggingface.co](https://huggingface.co/T5B/Z-Image-Turbo-FP8/resolve/main/z-image-turbo-fp8-e4m3fn.safetensors)"
)

BBOX_0=(
    "[huggingface.co](https://huggingface.co/gazsuv/pussydetectorv4/resolve/main/face_yolov8s.pt)"
)

BBOX_1=(
    "[huggingface.co](https://huggingface.co/gazsuv/pussydetectorv4/resolve/main/femaleBodyDetection_yolo26.pt)"
)

BBOX_2=(
    "[huggingface.co](https://huggingface.co/gazsuv/pussydetectorv4/resolve/main/female_breast-v4.2.pt)"
)

BBOX_3=(
    "[huggingface.co](https://huggingface.co/gazsuv/pussydetectorv4/resolve/main/nipples_yolov8s.pt)"
)

BBOX_4=(
    "[huggingface.co](https://huggingface.co/gazsuv/pussydetectorv4/resolve/main/vagina-v4.2.pt)"
)

BBOX_5=(
    "[huggingface.co](https://huggingface.co/gazsuv/xmode/resolve/main/assdetailer.pt)"
)

SAM_PTH=(
    "[huggingface.co](https://huggingface.co/datasets/Gourieff/ReActor/resolve/main/models/sams/sam_vit_b_01ec64.pth)"
)

BBOX_6=(
    "[huggingface.co](https://huggingface.co/gazsuv/pussydetectorv4/resolve/main/Eyeful_v2-Paired.pt)"
)

BBOX_7=(
    "[huggingface.co](https://huggingface.co/gazsuv/pussydetectorv4/resolve/main/Eyes.pt)"
)

BBOX_8=(
    "[huggingface.co](https://huggingface.co/gazsuv/pussydetectorv4/resolve/main/FacesV1.pt)"
)

BBOX_9=(
    "[huggingface.co](https://huggingface.co/gazsuv/pussydetectorv4/resolve/main/hand_yolov8s.pt)"
)

BBOX_10=(
    "[huggingface.co](https://huggingface.co/AunyMoons/loras-pack/resolve/main/foot-yolov8l.pt)"
)

QWEN3VL_1=(
    "[huggingface.co](https://huggingface.co/svjack/Qwen3-VL-4B-Instruct-heretic-7refusal/resolve/main/added_tokens.json)"
    "[huggingface.co](https://huggingface.co/svjack/Qwen3-VL-4B-Instruct-heretic-7refusal/resolve/main/chat_template.jinja)"
    "[huggingface.co](https://huggingface.co/svjack/Qwen3-VL-4B-Instruct-heretic-7refusal/resolve/main/config.json)"
    "[huggingface.co](https://huggingface.co/svjack/Qwen3-VL-4B-Instruct-heretic-7refusal/resolve/main/generation_config.json)"
    "[huggingface.co](https://huggingface.co/svjack/Qwen3-VL-4B-Instruct-heretic-7refusal/resolve/main/merges.txt)"
    "[huggingface.co](https://huggingface.co/svjack/Qwen3-VL-4B-Instruct-heretic-7refusal/resolve/main/model.safetensors.index.json)"
    "[huggingface.co](https://huggingface.co/svjack/Qwen3-VL-4B-Instruct-heretic-7refusal/resolve/main/preprocessor_config.json)"
    "[huggingface.co](https://huggingface.co/svjack/Qwen3-VL-4B-Instruct-heretic-7refusal/resolve/main/special_tokens_map.json)"
    "[huggingface.co](https://huggingface.co/svjack/Qwen3-VL-4B-Instruct-heretic-7refusal/resolve/main/tokenizer.json)"
    "[huggingface.co](https://huggingface.co/svjack/Qwen3-VL-4B-Instruct-heretic-7refusal/resolve/main/tokenizer_config.json)"
    "[huggingface.co](https://huggingface.co/svjack/Qwen3-VL-4B-Instruct-heretic-7refusal/resolve/main/vocab.json)"
)

QWEN3VL_2=(
    "[huggingface.co](https://huggingface.co/svjack/Qwen3-VL-4B-Instruct-heretic-7refusal/resolve/main/model-00001-of-00002.safetensors)"
)

QWEN3VL_3=(
    "[huggingface.co](https://huggingface.co/svjack/Qwen3-VL-4B-Instruct-heretic-7refusal/resolve/main/model-00002-of-00002.safetensors)"
)

UPSCALER_MODELS=(
    "[huggingface.co](https://huggingface.co/gazsuv/pussydetectorv4/resolve/main/4xUltrasharp_4xUltrasharpV10.pt)"
)

log() {
    echo ""
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

fix_hf_url() {
    local url="$1"
    url="${url/blob\/main/resolve\/main}"
    echo "$url"
}

get_auth_header() {
    local url="$1"
    if [[ "$url" =~ huggingface\.co ]] && [[ -n "${HF_TOKEN:-}" ]]; then
        echo "Authorization: Bearer ${HF_TOKEN}"
        return
    fi
    if [[ "$url" =~ civitai\.com ]] && [[ -n "${CIVITAI_TOKEN:-}" ]]; then
        echo "Authorization: Bearer ${CIVITAI_TOKEN}"
        return
    fi
    echo ""
}

download_file() {
    local dir="$1"
    local url="$2"
    local fixed_url
    fixed_url="$(fix_hf_url "$url")"

    mkdir -p "$dir"

    local filename
    filename="$(basename "${fixed_url%%\?*}")"
    local outfile="${dir}/${filename}"

    if [[ -f "$outfile" && -s "$outfile" ]]; then
        echo " [=] Already exists: $outfile"
        return 0
    fi

    local auth_header
    auth_header="$(get_auth_header "$fixed_url")"

    echo " [>] Downloading: $fixed_url"

    if [[ -n "$auth_header" ]]; then
        curl -L --fail --retry 5 --retry-delay 5 \
            -H "$auth_header" \
            -o "$outfile" \
            "$fixed_url" || {
                echo " [!] Download failed: $fixed_url"
                rm -f "$outfile"
                return 1
            }
    else
        curl -L --fail --retry 5 --retry-delay 5 \
            -o "$outfile" \
            "$fixed_url" || {
                echo " [!] Download failed: $fixed_url"
                rm -f "$outfile"
                return 1
            }
    fi

    if [[ ! -s "$outfile" ]]; then
        echo " [!] Empty file downloaded: $outfile"
        rm -f "$outfile"
        return 1
    fi

    echo " [✓] Saved: $outfile"
}

provisioning_get_files() {
    if [[ $# -lt 2 ]]; then
        return 0
    fi

    local dir="$1"
    shift
    local files=("$@")

    mkdir -p "$dir"
    log "Скачивание ${#files[@]} file(s) → $dir"

    local failed=0
    for url in "${files[@]}"; do
        download_file "$dir" "$url" || failed=1
    done

    return $failed
}

provisioning_get_apt_packages() {
    if [[ ${#APT_PACKAGES[@]} -gt 0 ]]; then
        log "Устанавливаю apt packages..."
        export DEBIAN_FRONTEND=noninteractive
        apt-get update
        apt-get install -y --no-install-recommends "${APT_PACKAGES[@]}"
        apt-get clean
        rm -rf /var/lib/apt/lists/*
    fi
}

provisioning_clone_comfyui() {
    mkdir -p "$WORKSPACE"

    if [[ ! -d "${COMFYUI_DIR}" ]]; then
        log "Клонирую ComfyUI..."
        git clone [github.com](https://github.com/comfyanonymous/ComfyUI.git) "${COMFYUI_DIR}"
    else
        log "ComfyUI уже существует, обновляю..."
        git -C "${COMFYUI_DIR}" fetch --all --prune || true
        git -C "${COMFYUI_DIR}" pull --ff-only || true
    fi

    cd "${COMFYUI_DIR}"
}

provisioning_install_base_reqs() {
    cd "${COMFYUI_DIR}"

    if [[ -f requirements.txt ]]; then
        log "Устанавливаю base requirements..."
        pip install --no-cache-dir -r requirements.txt
    fi
}

provisioning_get_pip_packages() {
    if [[ ${#PIP_PACKAGES[@]} -gt 0 ]]; then
        log "Устанавливаю extra pip packages..."
        pip install --no-cache-dir "${PIP_PACKAGES[@]}"
    fi
}

update_or_clone_repo() {
    local repo="$1"
    local dir="${repo##*/}"
    local path="${CUSTOM_NODES_DIR}/${dir}"

    if [[ -d "$path/.git" ]]; then
        echo "Updating node: $dir"
        git -C "$path" fetch --all --prune || return 1

        local branch
        branch="$(git -C "$path" symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null | sed 's|^origin/||' || true)"
        branch="${branch:-main}"

        git -C "$path" checkout "$branch" 2>/dev/null || true
        git -C "$path" pull --ff-only origin "$branch" || true
        git -C "$path" submodule update --init --recursive || true
    else
        echo "Cloning node: $dir"
        git clone --recursive "$repo" "$path" || {
            echo " [!] Clone failed: $repo"
            return 1
        }
    fi

    local requirements="${path}/requirements.txt"
    if [[ -f "$requirements" ]]; then
        echo "Installing deps for $dir..."
        pip install --no-cache-dir -r "$requirements" || echo " [!] pip requirements failed for $dir"
    fi
}

provisioning_get_nodes() {
    mkdir -p "${CUSTOM_NODES_DIR}"

    log "Устанавливаю custom nodes..."

    local unique_nodes=()
    local seen=""

    for repo in "${NODES[@]}"; do
        if [[ " $seen " != *" $repo "* ]]; then
            unique_nodes+=("$repo")
            seen+=" $repo"
        fi
    done

    for repo in "${unique_nodes[@]}"; do
        update_or_clone_repo "$repo"
    done
}

provisioning_start() {
    echo ""
    echo "##############################################"
    echo "# DURDOM PHOTO GENERATOR V1 2025-2026        #"
    echo "# BY RUSLAN & MAPICH                         #"
    echo "##############################################"
    echo ""

    provisioning_get_apt_packages
    provisioning_clone_comfyui
    provisioning_install_base_reqs
    provisioning_get_nodes
    provisioning_get_pip_packages

    provisioning_get_files "${COMFYUI_DIR}/models/clip" "${CLIP_MODELS[@]}" || true
    provisioning_get_files "${COMFYUI_DIR}/models/text_encoders" "${TEXT_ENCODERS[@]}" || true
    provisioning_get_files "${COMFYUI_DIR}/models/unet" "${UNET_MODELS[@]}" || true
    provisioning_get_files "${COMFYUI_DIR}/models/vae" "${VAE_MODELS[@]}" || true
    provisioning_get_files "${COMFYUI_DIR}/models/ckpt" "${CKPT_MODELS[@]}" || true
    provisioning_get_files "${COMFYUI_DIR}/models/model_patches" "${FUN_MODELS[@]}" || true
    provisioning_get_files "${COMFYUI_DIR}/models/diffusion_models" "${DIFFUSION_MODELS[@]}" || true

    provisioning_get_files "${COMFYUI_DIR}/models/ultralytics/bbox" "${BBOX_0[@]}" || true
    provisioning_get_files "${COMFYUI_DIR}/models/ultralytics/bbox" "${BBOX_1[@]}" || true
    provisioning_get_files "${COMFYUI_DIR}/models/ultralytics/bbox" "${BBOX_2[@]}" || true
    provisioning_get_files "${COMFYUI_DIR}/models/ultralytics/bbox" "${BBOX_3[@]}" || true
    provisioning_get_files "${COMFYUI_DIR}/models/ultralytics/bbox" "${BBOX_4[@]}" || true
    provisioning_get_files "${COMFYUI_DIR}/models/ultralytics/bbox" "${BBOX_5[@]}" || true
    provisioning_get_files "${COMFYUI_DIR}/models/ultralytics/bbox" "${BBOX_6[@]}" || true
    provisioning_get_files "${COMFYUI_DIR}/models/ultralytics/bbox" "${BBOX_7[@]}" || true
    provisioning_get_files "${COMFYUI_DIR}/models/ultralytics/bbox" "${BBOX_8[@]}" || true
    provisioning_get_files "${COMFYUI_DIR}/models/ultralytics/bbox" "${BBOX_9[@]}" || true
    provisioning_get_files "${COMFYUI_DIR}/models/ultralytics/bbox" "${BBOX_10[@]}" || true

    provisioning_get_files "${COMFYUI_DIR}/models/sams" "${SAM_PTH[@]}" || true

    provisioning_get_files "${COMFYUI_DIR}/models/prompt_generator/Qwen3-VL-4B-Instruct-heretic-7refusal" "${QWEN3VL_1[@]}" || true
    provisioning_get_files "${COMFYUI_DIR}/models/prompt_generator/Qwen3-VL-4B-Instruct-heretic-7refusal" "${QWEN3VL_2[@]}" || true
    provisioning_get_files "${COMFYUI_DIR}/models/prompt_generator/Qwen3-VL-4B-Instruct-heretic-7refusal" "${QWEN3VL_3[@]}" || true

    provisioning_get_files "${COMFYUI_DIR}/models/upscale_models" "${UPSCALER_MODELS[@]}" || true

    echo ""
    echo "DURDOM настроил → Starting ComfyUI..."
    echo ""
}

main() {
    if [[ ! -f /.noprovisioning ]]; then
        provisioning_start
    fi

    echo "=== DURDOM запускает ComfyUI ==="

    if [[ ! -d "${COMFYUI_DIR}" ]]; then
        echo "[!] ComfyUI directory not found: ${COMFYUI_DIR}"
        exit 1
    fi

    cd "${COMFYUI_DIR}"
    exec python main.py --listen 0.0.0.0 --port 8188
}

main "$@"
