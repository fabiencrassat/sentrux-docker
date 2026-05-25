# syntax=docker/dockerfile:1

# Downloader stage: install the official Sentrux binary and preload language grammars.
FROM debian:bookworm-slim AS downloader

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
        ca-certificates \
        libgtk-3-0 \
        libx11-xcb1 \
        libxkbcommon-x11-0 \
        libgl1-mesa-glx \
        libgl1-mesa-dri \
        libegl1 \
        libgles2 \
        libgbm1 \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://raw.githubusercontent.com/sentrux/sentrux/main/install.sh | sh
RUN sentrux --version

# Runtime stage: use Debian slim and install the GTK runtime dependencies.
FROM debian:bookworm-slim

ENV HOME=/root
ENV XDG_RUNTIME_DIR=/tmp/runtime-root

RUN mkdir -p "$XDG_RUNTIME_DIR" \
    && chmod 0700 "$XDG_RUNTIME_DIR" \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        libgtk-3-0 \
        libx11-xcb1 \
        libxkbcommon-x11-0 \
        libgl1-mesa-glx \
        libgl1-mesa-dri \
        libegl1 \
        libgles2 \
        libgbm1 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=downloader /usr/local/bin/sentrux /usr/local/bin/sentrux
COPY --from=downloader /root/.sentrux /root/.sentrux

ENTRYPOINT ["/usr/local/bin/sentrux"]
CMD ["--help"]
