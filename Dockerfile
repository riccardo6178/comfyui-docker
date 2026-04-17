FROM rocm/pytorch:rocm7.2.2_ubuntu24.04_py3.12_pytorch_release_2.10.0
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True
ENV HF_HUB_DISABLE_TELEMETRY=1
RUN apt-get update && apt-get install -y \
	git
	libgl1-mesa-glx \
	libglib2.0-0 \
	libsm6 \
	libxext6 \
	libxrender-dev \
	git \
	wget \
	&& rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/Comfy-Org/ComfyUI
WORKDIR /app/ComfyUI
RUN pip install --no-cache-dir --ignore-installed torch torchvision torchaudio && \
    pip install --no-cache-dir -r requirements.txt
EXPOSE 8188
CMD ["python", "main.py"]
