# ---- Build ----
FROM python:3.12-slim AS build
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
RUN python -m mkdocs build --clean --site-dir /out

# ---- Serve ----
FROM nginx:alpine
COPY --from=build /out /usr/share/nginx/html
