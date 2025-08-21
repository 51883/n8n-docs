# -------- Build MkDocs site --------
FROM python:3.12-slim AS build
WORKDIR /app

# 安装依赖
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 拷贝全部源码并构建
COPY . .
# 如果引用的目录/文件缺失会在这里报错，先按需要注释 mkdocs.yml 中的 extra_* 或补齐文件
RUN python -m mkdocs build --clean --site-dir /out

# -------- Serve with NGINX --------
FROM nginx:alpine
COPY --from=build /out /usr/share/nginx/html
