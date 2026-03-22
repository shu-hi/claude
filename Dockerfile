FROM node:22-slim

WORKDIR /usr/src/app

# bash と curl インストール
RUN apt-get update && apt-get install -y curl bash && rm -rf /var/lib/apt/lists/*

ENV NODE_ENV=development

# Claude Code インストール
USER root
RUN curl -fsSL https://claude.ai/install.sh | bash

# node ユーザーでも claude CLI を使えるよう PATH に追加
ENV PATH=/root/.local/bin:$PATH

# npm パッケージをグローバルインストール
RUN npm install -g @musistudio/claude-code-router

# config.json を正しい場所にコピー
COPY --chown=node:node ./claude-code-router/config.json ./claude-code-router/config.json

# 環境変数で config.json を指定
ENV CLAUDE_CONFIG=/usr/src/app/claude-code-router/config.json

# コンテナ常駐
CMD ["sleep", "infinity"]